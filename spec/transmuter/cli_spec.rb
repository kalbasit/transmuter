require 'spec_helper'

describe CLI do
  subject { CLI }

  describe "Methods" do
    # App specific
    it { should respond_to(:start) }
    it { should respond_to(:help) }
    it { should respond_to(:execute) }
    it { should respond_to(:execute!) }

    # Thor specifics
    it { should respond_to(:map) }
    it { should respond_to(:desc) }
    it { should respond_to(:method_options) }
  end
end