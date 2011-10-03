require 'spec_helper'

module Format
  describe Pdf do
    let(:html_h1) { '<h1>Heading 1</h1>' }
    let(:html_ruby) { %(<pre lang=\"ruby\"><code>def say_hi\n  &quot;Hello, world!&quot;\nend\n</code></pre>\n) }

    subject { Pdf.new(html_h1, stylesheets: "/path/to/file.css") }

    before(:each) do
      File.stubs(:read).with('/path/to/file.css').returns('h1 { color: #000; }')
    end

    describe "#new" do
      it "should require html" do
        -> { Pdf.new }.should raise_error ArgumentError, "wrong number of arguments (0 for 1)"
      end

      it "should set @html" do
        h = Pdf.new(html_h1)
        h.instance_variable_get("@html").should == html_h1
      end
    end

    describe "#process" do
      it { should respond_to :process }

      describe "call stack" do
        it "should create a new PDFKit object" do
          pdf = mock
          pdf.stubs(:to_pdf).returns(true)
          PDFKit.expects(:new).with(html_h1, page_size: 'Letter').returns(pdf).once

          subject.process
        end

        it "should call to_pdf on the created PDFKit object" do
          pdf = mock
          pdf.expects(:to_pdf).returns(true).once
          PDFKit.expects(:new).with(html_h1, page_size: 'Letter').returns(pdf).once

          subject.process
        end

      end
    end

  end
end
