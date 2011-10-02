require 'spec_helper'

describe CLI do
  describe "Thor" do
    subject { CLI.new }

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
    end
  end
end