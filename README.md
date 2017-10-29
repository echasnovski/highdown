
<!-- README.md is generated from README.Rmd. Please edit that file -->
highdown
========

Customize code highlighting for [pkgdown](https://hadley.github.io/pkgdown/index.html) site.

Installation
------------

You can install `highdown` from github with:

``` r
# install.packages("devtools")
devtools::install_github("echasnovski/highdown")
```

Usage
-----

`pkgdown` code highlighting is done with parsing text inside appropriate HTML tags (`<pre>`, `<code>`) and wrapping certain strings in `<span></span>` tag with appropriate class. `highdown` is designed to be applied after building `pkgdown` site with `pkgdown::build_site()`.

### With highlight.js

At the moment, the most flexible way of customizing code highlighting is with use of JavaScipt library [highlight.js](https://highlightjs.org/). Typical usage:

-   Copy file 'inst/extra.js' from this package to 'pkgdown/extra.js' at the root of your package (which is the current way of adding custom JavaScript to package with `pkgdown`). This file contains code for initializing highlight.js and registration of R language parsing rules. To customize parsing rules edit this file.
-   Edit CSS rules in 'pkgdown/extra.css' (from package with `pkgdown`) based on highlight.js classes. File 'inst/extra.css' contains code from [Idea](https://github.com/isagalaev/highlight.js/blob/master/src/styles/idea.css) style along with R default classes.
-   Build site with `pkgdown::build_site()`.
-   Run `highdown::tweak_ref_pages()` (with working directory being package root) to enable code highlighting on Reference pages. **Note** that as for 2017-10-27 this still can cause incorrect highlighting if some actual code is placed just after comment.

### With adding tag class

If, for some reason, using custom JavaScript is not appropriate, there is a solution via `<span>` tags class modification. The idea is to find certain nodes in HTML page with text matching certain regular expression (say, `"%>%"` for pipe operator) and add certain class to it (say, "pp"). This can make styling with custom CSS possible.

Typical usage:

-   Run `pkgdown::build_site()`.
-   Run function `highdown::xml_add_class_pattern(xpath, pattern, new_class)` with appropriate arguments to add class `new_class` to those nodes which satisfy XPATH expression `xpath` and with text matching regular expression `pattern`.
-   Add CSS rules for styling.

Also there is a function to highlight pipe operator: `high_pipe()`. Basically, its a wrapper for `xml_add_class_pattern("//pre//span", "%>%", "pp")`. After applying it, one should add CSS rules for class "pp", for example ".pp {font-weight: bold;}".
