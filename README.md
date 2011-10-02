# Transmuter [![Build Status](http://travis-ci.org/TechnoGate/transmuter.png)](http://travis-ci.org/TechnoGate/transmuter)

Transmuter is a command line tool to convert Markdown files into HTML or PDF
files, it can also be used to convert HTML files to PDF, it uses in the
backgound [Redcarper](https://github.com/tanoku/redcarpet),
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
