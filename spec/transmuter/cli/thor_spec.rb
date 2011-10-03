require 'spec_helper'

describe CLI do
  describe "Thor" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI::Runner.new(@valid_initialize_options) }

    describe "Thor group definition" do
      subject { CLI::Runner }
      it { should respond_to(:desc) }
      it { should respond_to(:class_option) }
      it { should respond_to(:argument) }
      its (:desc) { should_not be_empty }
      its (:arguments) { should_not be_empty }
    end

    describe "input" do
      it "should have an arguments :input defined" do
        CLI::Runner.arguments.any? { |arg| arg.name == 'input' }.should be_true
      end

      it "should be required" do
        -> { CLI::Runner.new }.should raise_error Thor::RequiredArgumentMissingError,
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
        CLI::Runner.class_options.should have_key(:input_format)
      end

      it "should not be required" do
        -> { CLI::Runner.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end

      it { should respond_to(:set_input_fileformat) }

      it "should set @input_fileformat with --input_format" do
        cli = CLI::Runner.new @valid_initialize_options, input_format: 'format1'
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "format1"
      end

      it "should be markdown if the input file extensions is .md" do
        cli = CLI::Runner.new ['README.md']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "markdown"
      end

      it "should be markdown if the input file extensions is .markdown" do
        cli = CLI::Runner.new ['README.markdown']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "markdown"
      end

      it "should be html if the input file extensions is .htm" do
        cli = CLI::Runner.new ['README.htm']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "html"
      end

      it "should be html if the input file extensions is .html" do
        cli = CLI::Runner.new ['README.html']
        cli.set_input_fileformat
        cli.instance_variable_get('@input_fileformat').should == "html"
      end
    end

    describe "output format" do

      it "should have a class_option output_format defined" do
        CLI::Runner.class_options.should have_key(:output_format)
      end

      it "should not be required" do
        -> { CLI::Runner.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end

      it { should respond_to(:set_output_fileformat) }

      it "should set @output_fileformat with --output_format" do
        cli = CLI::Runner.new @valid_initialize_options, output_format: 'format1'
        cli.set_output_fileformat
        cli.instance_variable_get('@output_fileformat').should == "format1"
      end

      it "should default to pdf" do
        subject.set_output_fileformat
        subject.instance_variable_get('@output_fileformat').should == "pdf"
      end
    end

    describe "output" do
      before(:each) do
        subject.set_input_filename
        subject.set_input_fileformat
        subject.set_output_fileformat
      end

      it "should have an arguments :input defined" do
        CLI::Runner.arguments.any? { |arg| arg.name == 'output' }.should be_true
      end

      it "should not be required" do
        -> { CLI::Runner.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end

      it { should respond_to(:set_output_filename) }

      it "should raise an exception of both output_format and output are empty" do
        cli = CLI::Runner.new @valid_initialize_options, output_format: ''
        cli.set_input_filename
        cli.set_input_fileformat
        cli.set_output_fileformat

        -> { cli.set_output_filename }.should raise_error ArgumentError,
          "Either output or output_format should be given,"
      end

      it "should set @output_filename" do
        subject.set_output_filename
        subject.instance_variable_get('@output_filename').should == 'README.pdf'
      end
    end

    describe "stylesheets" do

      it "should have a class_option stylesheets defined" do
        CLI::Runner.class_options.should have_key(:stylesheets)
      end

      it "should not be required" do
        -> { CLI::Runner.new @valid_initialize_options }.should_not
          raise_error Thor::RequiredArgumentMissingError
      end

      it { should respond_to(:set_stylesheets) }

      it "should set @stylesheets with --stylesheets" do
        cli = CLI::Runner.new @valid_initialize_options, stylesheets: 'stylesheets/test.css'
        cli.set_stylesheets
        cli.instance_variable_get('@stylesheets').should == 'stylesheets/test.css'
      end

      it "should default to [#{ROOT_PATH}/stylesheets/default.css]" do
        subject.set_stylesheets
        subject.instance_variable_get('@stylesheets').should == ["#{ROOT_PATH}/stylesheets/default.css"]
      end
    end

    describe "#start" do
      it "should call transmute" do
        CLI::Runner.any_instance.expects(:transmute).returns(true).at_least(1)
        CLI::Runner.any_instance.expects(:transmute!).returns(true).at_least(1)

        CLI::Runner.start ["README.md"]
      end
    end

  end
end