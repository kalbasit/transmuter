# Transmuter [![Build Status](http://travis-ci.org/TechnoGate/transmuter.png)](http://travis-ci.org/TechnoGate/transmuter)

Transmuter is a command line tool to convert Markdown files into HTML or PDF
files, it can also be used to convert HTML files to PDF, it uses in the
backgound
[Redcarpet](https://github.com/tanoku/redcarpet),
[RedCloth](http://redcloth.org),
[Albino](https://github.com/github/albino) and
[PDFkit](https://github.com/jdpace/PDFKit).

<a href='http://www.pledgie.com/campaigns/16086'><img alt='Click here to lend your support to: Transmuter and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/16086.png?skin_name=chrome' border='0' /></a>

# Installation

To install Transmuter use the command

```bash
$ gem install transmuter
```

You also need to install (as a requirements),
[*pygments*](http://pygments.org/) (needed by Albino) and
[*WKHTMLTOPDF*](http://wkhtmltopdf.googlecode.com/) (needed by PDFkit)

## Pygments

You can install pygments using *easy_install* provided by Python

```bash
$ sudo easy_install pygments
```

## WKHTMLTOPDF

1. Install by hand (recommended):

    <https://github.com/jdpace/PDFKit/wiki/Installing-WKHTMLTOPDF>

2.  Try using the wkhtmltopdf-binary gem (mac + linux i386)

        gem install wkhtmltopdf-binary

# Usage

You should check the help

```bash
$ transmute --help
```

To Generate a PDF from a markdown file with the default CSS:

```bash
$ transmute file.md
```

To Generate an HTML from a markdown file with the default CSS:

```bash
$ transmute file.md -t html
```

To Generate an HTML from a markdown file with custom CSS:

```bash
$ transmute file.md -t html -s custom.css
```

Custom CSS files can be be multiple path separated by a space, for example:

```bash
$ transmute file.md -t html -s custom1.css custom2.css
```

# License

## This code is free to use under the terms of the MIT license.

Copyright (c) 2011 Wael Nasreddine <wael.nasreddine@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.