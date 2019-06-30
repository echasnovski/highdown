# tweak_after_pkgdown -----------------------------------------------------
#' Tweak site after `pkgdown::build_site()`
#'
#' This consecutively runs [tweak_ref_pages()] and [tweak_articles_toc].
#'
#' @return `tweak_after_pkgdown()` returns `TRUE` invisibly after success.
#'
#' @export
tweak_after_pkgdown <- function() {
  tweak_ref_pages()
  tweak_articles_toc()

  invisible(TRUE)
}


# tweak_ref_pages ---------------------------------------------------------
#' Tweak Reference pages
#'
#' Function to tweak all Reference pages in `pkgdown` site. For now it adds
#' child node <code class = "r"> to all <pre> nodes to make highlight.js work.
#' __Note__ that this function should be run with working directory being
#' package root. Also __note__ that it will rewrite pages.
#'
#' @return Full file paths of (possibly) modified files (invisibly).
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


# tweak_articles_toc ------------------------------------------------------
#' Tweak articles' Table Of Contents
#'
#' This function adds "toc-lev{x}" classes to all elements of TOC, where `{x}`
#' is items "hierarchy" level. For example, if TOC elements are generated with
#' "h2" and "h3" headers, then it adds "toc-lev1" to "h2" headers and "toc-lev2"
#' to "h3" headers. **Note** that levels are actually determined by empirical
#' hack which exploits how 'pkgdown' handles TOC with headers of several orders.
#'
#' @details **Notes**:
#' - This is often used with `padding-left: 20px;` (move elements to the right
#' by 20 pixels) CSS property of `toc-lev2` class in CSS file of package site
#' (usually 'pkgdown/extra.css'); `padding-left: 40px;` for `toc-lev3`, etc.
#' - To enable having elements of different header order, use "depth: 3" (or
#' more) property of "toc" element in '_pkgdown.yml'.
#'
#' @return Full file paths of (possibly) modified files (invisibly).
#'
#' @export
tweak_articles_toc <- function() {
  article_files <- list.files(
    path = "docs/articles/",
    pattern = "\\.html",
    recursive = FALSE,
    full.names = TRUE
  )

  # Add "toc-lev{x}" classes to all elements of TOC entries at level x. So first
  # level entry will have class "toc-lev1", second - "toc-lev2", etc.
  lapply(article_files, add_toc_levels)

  invisible(article_files)
}

add_toc_levels <- function(path) {
  page <- xml2::read_html(path)

  toc_items <- page %>%
    # Find table of contents by id
    xml2::xml_find_first(xpath = "//*[@id='tocnav']") %>%
    # Find all <li> (list elements) with "linkable" descendants which are
    # assumed to represent TOC entries
    xml2::xml_find_all(xpath = "descendant::li[descendant::a[@href]]")

  toc_level <- vapply(toc_items, function(item) {
    length(xml2::xml_find_all(
      item, xpath = "ancestor::*[contains(@class, 'nav-stacked')]"
    ))
  }, numeric(1))

  toc_class <- paste0("toc-lev", toc_level)

  # Add appropriate classes
  lapply(seq_along(toc_items), function(i) {
    xml2::xml_set_attr(toc_items[i], attr = "class", value = toc_class[i])
  })

  xml2::write_html(page, path)
}
