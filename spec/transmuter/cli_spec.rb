require 'spec_helper'

describe CLI do
  subject { CLI }

  describe "Methods" do
    it { should respond_to(:start) }
    it { should respond_to(:help) }
    it { should respond_to(:execute) }
    it { should respond_to(:execute!) }
  end
end