require 'spec_helper'

describe CLI do
  describe "Thor" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI.new(@valid_initialize_options) }

    describe "Thor group definition" do
      subject { CLI }
      it { should respond_to(:desc) }
      it { should respond_to(:class_option) }
      it { should respond_to(:argument) }
      its (:desc) { should_not be_empty }
      its (:arguments) { should_not be_empty }
    end

    describe "input" do
      it "should have an arguments :input defined" do
        CLI.arguments.any? { |arg| arg.name == 'input' }.should be_true
      end

      it "should be required" do
        -> { CLI.new }.should raise_error Thor::RequiredArgumentMissingError,
          "No value provided for required arguments 'input'"
      end

      it { should respond_to(:set_input_filename) }

      it "should set @input_filename" do
        subject.set_input_filename
        subject.instance_variable_get('@input_filename').should == 'README.md'
      end
    end

    describe "input format" do
      it "should have a class_option input_format defined" do
        CLI.class_options.should have_key(:input_format)
      end

      it "should not be required" do
        -> { CLI.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end

      it { should respond_to(:set_input_fileformat) }

      it "should set @input_fileformat with --input_format" do
        cli = CLI.new @valid_initialize_options, input_format: 'format1'
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "format1"
      end

      it "should be markdown if the input file extensions is .md" do
        cli = CLI.new ['README.md']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "markdown"
      end

      it "should be markdown if the input file extensions is .markdown" do
        cli = CLI.new ['README.markdown']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "markdown"
      end

      it "should be html if the input file extensions is .htm" do
        cli = CLI.new ['README.htm']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "html"
      end

      it "should be html if the input file extensions is .html" do
        cli = CLI.new ['README.html']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "html"
      end
    end

    describe "output format" do

      it "should have a class_option output_format defined" do
        CLI.class_options.should have_key(:output_format)
      end

      it "should not be required" do
        -> { CLI.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end
    end

  end
end