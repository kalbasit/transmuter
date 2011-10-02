require 'spec_helper'

describe CLI do
  describe "Transmute" do

    let(:markdown_h1) { '# Heading 1' }
    let(:html_h1) { '<h1>Heading 1</h1>' }

    before(:all) do
      @valid_arguments = ['README.md']
      @valid_options = { output_format: 'html' }
      @valid_start_args = begin
        @valid_arguments + begin
          @valid_options.collect do |k, v|
            "--#{k.to_s.gsub(/_/, '-')}=#{v}"
          end
        end
      end
    end

    subject { CLI::Runner.new(@valid_arguments, @valid_options) }

    describe "Definitions" do
      it { should respond_to(:transmute) }
      it { should respond_to(:transmute!) }
    end

    describe "#transmute!" do
      describe "Errors" do
        it "should raise a NameError exception if input is invalid" do
          subject.instance_variable_set("@input_fileformat", 'Invalid')
          -> { subject.transmute! }.should raise_error NameError
        end

        it "should raise a NameError exception if output is invalid" do
          subject.instance_variable_set("@output_fileformat", 'Invalid')
          -> { subject.transmute! }.should raise_error NameError
        end

        it "should raise an NotImplementedError if we don't know how to transmute from input to output" do
          subject.instance_variable_set("@output_fileformat", "invalid")
          subject.instance_variable_set("@destination_klass", "set to bypass errors")
          -> { subject.transmute! }.should raise_error NotImplementedError
        end

        it "should raise an NotImplementedError if we don't know how to process output" do
          not_output = Class.new
          subject.instance_variable_set("@output_fileformat", "invalid")
          subject.instance_variable_set("@destination_klass", not_output)
          -> { subject.transmute! }.should raise_error NotImplementedError
        end
      end

      describe "Transmuting from markdown to HTML" do
        before(:each) do
          File.stubs(:read).with('README.md').returns(markdown_h1)
          File.any_instance.stubs(:write).returns(true)
        end

        it "should invoke #transmute!" do
          CLI::Runner.any_instance.expects(:transmute!).at_least(1)

          CLI::Runner.start @valid_start_args
        end

        it "should read the source file" do
          File.expects(:read).with('README.md').returns(markdown_h1).once

          CLI::Runner.start @valid_start_args
        end

        it "should write the source file" do
          File.any_instance.expects(:write).once

          CLI::Runner.start @valid_start_args
        end

      end
    end

    describe "#transmute" do
      describe "Errors" do
        it "should not raise a NameError exception" do
          cli = subject.dup
          cli.instance_variable_set("@input_fileformat", 'Invalid')
          -> { cli.transmute }.should_not raise_error NameError
        end
      end
    end

  end
end
