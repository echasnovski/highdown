#' Highlight the pipe
#'
#' Function to process all html files at certain path by adding class "pp" to
#' "<span>" nodes which contain "%>%" inside text.
#'
#' @inheritParams xml_add_class_pattern
#'
#' @return Full file paths of modified files (invisibly).
#'
#' @export
high_pipe <- function(path = "docs", new_class = "pp") {
  xml_add_class_pattern("//pre//span", "%>%", new_class, path)
}
