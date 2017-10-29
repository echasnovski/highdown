#' Add class to certain XML nodes
#'
#' Function for processing (rewrite) all html files in specific folder
#' (recursively) by adding certain class to those nodes which satisfy XPATH
#' expression and with text matching regular expression.
#'
#' @param xpath A string containing an xpath (1.0) expression.
#' @param pattern Regular expression for nodes' text of interest.
#' @param new_class String for class to add.
#' @param path Path to folder with html files.
#'
#' @return Full file paths of modified files (invisibly).
#'
#' @export
xml_add_class_pattern <- function(xpath, pattern, new_class, path = "docs") {
  html_files <- list.files(
    path = "docs",
    pattern = "\\.html",
    recursive = TRUE,
    full.names = TRUE
  )

  lapply(html_files, function(file) {
    page <- xml2::read_html(file, encoding = "UTF-8")

    matched_nodes <- xml_find_all_patterns(page, xpath, pattern)
    if (length(matched_nodes) == 0) {
      return(NA)
    }

    xml_add_class(matched_nodes, new_class)

    xml2::write_html(page, file, format = FALSE)
  })

  invisible(html_files)
}

xml_add_class <- function(x, new_class) {
  output_class <- paste(xml2::xml_attr(x, "class"), new_class)
  mapply(xml2::xml_set_attr, x, output_class, MoreArgs = list(attr = "class"))

  invisible(x)
}

xml_find_all_patterns <- function(x, xpath, pattern, ns = xml2::xml_ns(x)) {
  res <- xml2::xml_find_all(x, xpath, ns)
  is_matched <- grepl(pattern, xml2::xml_text(res))

  res[is_matched]
}
