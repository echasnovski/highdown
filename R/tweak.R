#' Tweak Reference pages
#'
#' Function to tweak all Reference pages in `pkgdown` site. For now it adds
#' child node <code class = "r"> to all <pre> nodes to make highlight.js work.
#' __Note__ that this function should be run with working directory being
#' package root.
#'
#' @export
tweak_ref_pages <- function() {
  ref_files <- list.files(
    path = "docs/reference/",
    pattern = "\\.html",
    recursive = TRUE,
    full.names = TRUE
  )

  lapply(ref_files, add_code_node)

  invisible(ref_files)
}

add_code_node <- function(x) {
  page <- paste0(readLines(x), collapse = "\n")

  page <- gsub('(<pre.*?>)', '\\1<code class = "r">', page)
  page <- gsub('<\\/pre>', '<\\/code><\\/pre>', page)

  invisible(writeLines(page, x))
}

