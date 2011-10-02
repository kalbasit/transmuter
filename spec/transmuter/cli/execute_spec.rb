require 'spec_helper'

describe CLI do
  describe "Execute" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI::Runner }

    it { should respond_to(:execute) }
    it { should respond_to(:execute!) }
  end
end
