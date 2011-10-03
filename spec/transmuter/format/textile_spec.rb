require 'spec_helper'

module Format
  describe Textile do

    let(:textile_h1) { 'h1. Heading 1' }
    let(:html_h1) { '<h1>Heading 1</h1>' }
    let(:textile_ruby) { %(```ruby\ndef say_hi\n  "Hello, world!"\nend\n```) }
    let(:html_ruby) { %(<pre lang=\"ruby\"><code>def say_hi\n  &quot;Hello, world!&quot;\nend\n</code></pre>\n) }

    subject { Textile.new(textile_h1, stylesheets: "/path/to/file.css") }

    before(:each) do
      File.stubs(:read).with('/path/to/file.css').returns('h1 { color: #000; }')
    end

    describe "#new" do
      it "should require textile" do
        -> { Textile.new }.should raise_error ArgumentError, "wrong number of arguments (0 for 1)"
      end

      it "should set @textile" do
        m = Textile.new(textile_h1)
        m.instance_variable_get("@textile").should == textile_h1
      end
    end

    describe "#parse_options" do
      it "should have parse_options as a protected method" do
        Textile.protected_instance_methods.should include(:parse_options)
      end

      it "should set @options" do
        subject.instance_variable_get('@options').should_not be_empty
      end
    end

    describe "#create_textile" do
      it "should have create_textile as a protected method" do
        Textile.protected_instance_methods.should include(:create_textile)
      end

      it "should create a new RedCloth object" do
        m = subject.send :create_textile
        m.should be_instance_of RedCloth::TextileDoc
      end
    end

    describe "#parse_textile" do
      it "should have parse_textile as a protected method" do
        Textile.protected_instance_methods.should include(:parse_textile)
      end

      it "should call create_textile" do
        textile = mock()
        textile.stubs(:to_html).returns(true)
        Textile.any_instance.expects(:create_textile).once.returns(textile)

        subject.send(:parse_textile)
      end

      it "should call RedCloth.to_html" do
        RedCloth::TextileDoc.any_instance.expects(:to_html).returns(true)

        subject.send(:parse_textile)
      end

      it "should render simple textile" do
        subject.send(:parse_textile).should match(%r(#{html_h1}))
      end
    end

    describe "#to_html" do
      describe "call stach" do
        it "should call parse_textile" do
          Textile.any_instance.expects(:parse_textile).once.returns(html_h1)

          subject.to_html
        end

        it "should call process on the Html object" do
          Html.any_instance.expects(:process).once.returns(html_h1)

          subject.to_html
        end
      end

      it { should respond_to :to_html }

      it "should call RedCloth.to_html" do
        RedCloth::TextileDoc.any_instance.expects(:to_html).returns(html_h1)

        subject.to_html
      end

      it "should render simple textile" do
        subject.to_html.should match(%r(#{html_h1}))
      end

      it "should render simple textile and include stylesheets" do
        subject.to_html.should
          match(%r(<html>.*<head>.*<style [^>]*>h1 { color: #000; }.*</style>.*</head>.*<body>.*#{html_h1}.*</body>.*</html>)m)
      end
    end

    describe "#to_pdf" do
      before(:each) do
        pdfkit_instance = mock()
        pdfkit_instance.stubs(:to_pdf).returns true
        PDFKit = mock() unless defined?(PDFKit)
        PDFKit.stubs(:new).returns(pdfkit_instance)
      end

      it { should respond_to :to_pdf }

      describe "call stack" do

        it "should call to_html" do
          Html.any_instance.expects(:process).returns(html_h1).once

          subject.to_pdf
        end

        it "should create a new Pdf object" do
          pdf = mock
          pdf.stubs(:process).returns(true)
          Pdf.expects(:new).returns(pdf).once

          subject.to_pdf
        end
      end
    end
  end
end
