require 'spec_helper'

module Format
  describe Html do
    let(:html_h1) { '<h1>Heading 1</h1>' }
    let(:html_ruby) { %(<pre lang=\"ruby\"><code>def say_hi\n  &quot;Hello, world!&quot;\nend\n</code></pre>\n) }

    subject { Html.new(html_h1, stylesheets: "/path/to/file.css") }

    before(:each) do
      File.stubs(:read).with('/path/to/file.css').returns('h1 { color: #000; }')
    end

    describe "#new" do
      it "should require html" do
        -> { Html.new }.should raise_error ArgumentError, "wrong number of arguments (0 for 1)"
      end

      it "should set @html" do
        h = Html.new(html_h1)
        h.instance_variable_get("@html").should == html_h1
      end
    end

    describe "#parse_options" do
      it "should have parse_options as a protected method" do
        Html.protected_instance_methods.should include(:parse_options)
      end

      it "should set @options" do
        subject.instance_variable_get('@options').should_not be_empty
      end
    end

    describe "#read_stylesheet_files" do
      describe "as an Array" do
        it "should have read_stylesheet_files as a protected method" do
          Html.protected_instance_methods.should include(:read_stylesheet_files)
        end

        it "should reads the stylesheets from the specified files" do
          File.expects(:read).with('/path/to/file.css').once
          subject.send :read_stylesheet_files
        end
      end

      describe "as a String" do
        it "should have read_stylesheet_files as a protected method" do
          Html.protected_instance_methods.should include(:read_stylesheet_files)
        end

        it "should reads the stylesheets from the specified files" do
          File.expects(:read).with('/path/to/file.css').once
          subject.send :read_stylesheet_files
        end
      end
    end

    describe "#include_inline_stylesheets" do
      it "should render html with stylsheets" do
        require 'nokogiri'
        html = "<html><body>#{html_h1}</body></html>"
        styled_html = subject.send(:include_inline_stylesheets, html)

        doc = Nokogiri::HTML(styled_html)
        doc.search('/html/head').size.should == 1

        styled_html.should
          match(%r(<html>[^<head>]*<head><style [^>]*>h1 { color: #000; }.*</style>.*</head>[^<head>]*<body>)m)
      end

      it "should render html with stylsheets even if there's already head" do
        require 'nokogiri'
        html = %(<html><head><link rel="stylesheet" href="styles.css" type="text/css" /></head><body>#{html_h1}</body></html>)
        styled_html = subject.send(:include_inline_stylesheets, html)

        doc = Nokogiri::HTML(styled_html)
        doc.search('/html/head').size.should == 1

        styled_html.should
          match(%r(<html>[^<head>]*<head><style [^>]*>h1 { color: #000; }.*</style>.*</head>[^<head>]*<body>)m)
      end
    end

    describe "#syntax_highlighter" do
      it "should have syntax_highlighter as a protected method" do
        Html.protected_instance_methods.should include(:syntax_highlighter)
      end

      it "should call Nokogiri::HTML" do
        nokogiri_document = mock()
        nokogiri_document.stubs(:search).returns([])
        Nokogiri.expects(:HTML).with(html_h1).once.returns(nokogiri_document)

        subject.send :syntax_highlighter
      end

      it "should call Albino.colorize" do
        pre = mock
        pre.stubs(:text).returns("some html")
        pre.stubs(:[]).with(:lang).returns(:ruby)
        pre.stubs(:replace).returns(true)
        nokogiri_document = mock()
        nokogiri_document.stubs(:search).returns([pre])
        Nokogiri.expects(:HTML).with(html_h1).once.returns(nokogiri_document)

        Albino.expects(:colorize).once.returns("")
        subject.send(:syntax_highlighter)
      end
    end

    describe "#process" do
      it { should respond_to :process }

      describe "call stack" do
        it "should call syntax_highlighter" do
          Html.any_instance.expects(:syntax_highlighter).once.returns(html_h1)

          subject.process
        end

        it "should call include_inline_stylesheets" do
          Html.any_instance.expects(:include_inline_stylesheets).once.returns(html_h1)

          subject.process
        end

      end
    end

  end
end
