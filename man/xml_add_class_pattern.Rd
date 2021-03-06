% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add-class.R
\name{xml_add_class_pattern}
\alias{xml_add_class_pattern}
\title{Add class to certain XML nodes}
\usage{
xml_add_class_pattern(xpath, pattern, new_class, path = "docs")
}
\arguments{
\item{xpath}{A string containing an xpath (1.0) expression.}

\item{pattern}{Regular expression for nodes' text of interest.}

\item{new_class}{String for class to add.}

\item{path}{Path to folder with html files.}
}
\value{
Full file paths of modified files (invisibly).
}
\description{
Function for processing (rewrite) all html files in specific folder
(recursively) by adding certain class to those nodes which satisfy XPATH
expression and with text matching regular expression.
}
