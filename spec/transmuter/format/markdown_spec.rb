require 'spec_helper'

module Format
  describe Markdown do

    let(:markdown_h1) { '# Heading 1' }
    let(:markdown_h2) { '## Heading 2' }
    let(:markdown_h3) { '### Heading 3' }
    let(:markdown_h4) { '#### Heading 4' }
    let(:markdown_h5) { '##### Heading 5' }

    describe "REDCARPET_OPTIONS" do
      it "shoudle have defined REDCARPET_OPTIONS" do
        Markdown.constants.should include(:REDCARPET_OPTIONS)
      end

      it "should be equal to [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]" do
        Markdown::REDCARPET_OPTIONS.should == [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
      end
    end

    describe "#new" do
      it "should require markdown" do
        -> { Markdown.new }.should raise_error ArgumentError, "wrong number of arguments (0 for 1)"
      end

      it "should set @markdown" do
        m = Markdown.new(markdown_h1)
        m.instance_variable_get("@markdown").should == markdown_h1
      end
    end

    describe "#parse_options" do
      subject { Markdown.new(markdown_h1) }

      it "should have parse_options as a protected method" do
        Markdown.protected_instance_methods.should include(:parse_options)
      end

      it "should set @options" do
        subject.instance_variable_get('@options').should_not be_empty
      end

      it "should include :redcarpet_options in the options" do
        redcarpet_options = subject.instance_variable_get('@options')[:redcarpet_options]
        redcarpet_options.should_not be_empty
        redcarpet_options.should == Markdown::REDCARPET_OPTIONS
      end
    end

    describe "#create_markdown" do
      subject { Markdown.new(markdown_h1) }

      it "should have create_markdown as a protected method" do
        Markdown.protected_instance_methods.should include(:create_markdown)
      end

      it "should create a new Redcarpet object" do
        m = subject.send :create_markdown
        m.should be_instance_of Redcarpet
      end
    end

    describe "#to_html" do

      subject { Markdown.new(markdown_h1) }

      it { should respond_to :to_html }

      it "should call Redcarpet.to_html" do
        Redcarpet.any_instance.expects(:to_html).returns(true)

        subject.to_html
      end
    end
  end
end
