% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/high.R
\name{high_pipe}
\alias{high_pipe}
\title{Highlight the pipe}
\usage{
high_pipe(path = "docs", new_class = "pp")
}
\arguments{
\item{path}{Path to folder with html files.}

\item{new_class}{String for class to add.}
}
\value{
Full file paths of modified files (invisibly).
}
\description{
Function to process all html files at certain path by adding class "pp" to
"\<span\>" nodes which contain "\%>\%" inside text.
}
