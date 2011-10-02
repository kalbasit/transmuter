require 'spec_helper'

describe CLI do
  describe "Transmute" do
    before(:all) do
      @valid_initialize_options = ['README.md']
    end

    subject { CLI::Runner.new(@valid_initialize_options) }

    it { should respond_to(:transmute) }
    it { should respond_to(:transmute!) }
  end
end
