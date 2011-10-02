require 'spec_helper'

describe CLI do
  describe "Transmute" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI::Runner.new(@valid_initialize_options) }

    describe "Definitions" do
      it { should respond_to(:transmute) }
      it { should respond_to(:transmute!) }
    end

    describe "#transmute!" do
      describe "Errors" do
        it "should raise a NameError exception" do
          cli = subject.dup
          cli.instance_variable_set("@input_fileformat", 'Invalid')
          -> { cli.transmute! }.should raise_error NameError
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
