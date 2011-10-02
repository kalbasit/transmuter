require 'spec_helper'

describe CLI do
  describe "Execute" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI.new(@valid_initialize_options) }

    it { should respond_to(:execute) }
    it { should respond_to(:execute!) }
  end
end
