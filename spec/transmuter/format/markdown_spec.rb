require 'spec_helper'

module Format
  describe Markdown do

    let(:markdown_h1) { '# Heading 1' }
    let(:html_h1) { '<h1>Heading 1</h1>' }
    let(:markdown_h2) { '## Heading 2' }
    let(:markdown_h3) { '### Heading 3' }
    let(:markdown_h4) { '#### Heading 4' }
    let(:markdown_h5) { '##### Heading 5' }
    let(:markdown_ruby) { %(```ruby\ndef say_hi\n  "Hello, world!"\nend\n```) }
    let(:html_ruby) { %(<pre lang=\"ruby\"><code>def say_hi\n  &quot;Hello, world!&quot;\nend\n</code></pre>\n) }

    subject { Markdown.new(markdown_h1, stylesheets: "/path/to/file.css") }

    before(:each) do
      File.stubs(:read).with('/path/to/file.css').returns('h1 { color: #000; }')
    end

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
      it "should have create_markdown as a protected method" do
        Markdown.protected_instance_methods.should include(:create_markdown)
      end

      it "should create a new Redcarpet object" do
        m = subject.send :create_markdown
        m.should be_instance_of Redcarpet
      end
    end

    describe "#parse_markdown" do
      it "should have parse_markdown as a protected method" do
        Markdown.protected_instance_methods.should include(:parse_markdown)
      end

      it "should call create_markdown" do
        markdown = mock()
        markdown.stubs(:to_html).returns(true)
        Markdown.any_instance.expects(:create_markdown).once.returns(markdown)

        subject.send(:parse_markdown)
      end

      it "should call Redcarpet.to_html" do
        Redcarpet.any_instance.expects(:to_html).returns(true)

        subject.send(:parse_markdown)
      end

      it "should render simple markdown" do
        subject.send(:parse_markdown).should match(%r(#{html_h1}))
      end
    end

    describe "#to_html" do
      describe "call stach" do
        it "should call parse_markdown" do
          Markdown.any_instance.expects(:parse_markdown).once.returns(html_h1)

          subject.to_html
        end

        it "should call process on the Html object" do
          Html.any_instance.expects(:process).once.returns(html_h1)

          subject.to_html
        end
      end

      it { should respond_to :to_html }

      it "should call Redcarpet.to_html" do
        Redcarpet.any_instance.expects(:to_html).returns(html_h1)

        subject.to_html
      end

      it "should render simple markdown" do
        subject.to_html.should match(%r(#{html_h1}))
      end

      it "should render simple markdown and include stylesheets" do
        subject.to_html.should
          match(%r(<html>.*<head>.*<style [^>]*>h1 { color: #000; }.*</style>.*</head>.*<body>.*#{html_h1}.*</body>.*</html>)m)
      end
    end
  end
end
