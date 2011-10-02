require 'spec_helper'

describe CLI do
  describe "Thor" do
    subject { CLI.new }

    describe "Thor group definition" do
      subject { CLI }
      it { should respond_to(:desc) }
      it { should respond_to(:class_option) }
      it { should respond_to(:argument) }
    end
  end
end