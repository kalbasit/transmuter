require 'spec_helper'

module Format
  describe Markdown do
    describe "REDCARPET_OPTIONS" do
      it "shoudle have defined REDCARPET_OPTIONS" do
        Markdown.constants.should include(:REDCARPET_OPTIONS)
      end

      it "should be equal to [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]" do
        Markdown::REDCARPET_OPTIONS.should == [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
      end
    end

    describe "#to_html" do
      it { should respond_to :to_html }
    end
  end
end
