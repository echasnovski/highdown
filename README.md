
<!-- README.md is generated from README.Rmd. Please edit that file -->
highdown
========

Customize code highlighting for pkgdown site.

Installation
------------

You can install `highdown` from github with:

``` r
# install.packages("devtools")
devtools::install_github("echasnovski/highdown")
```

Usage
-----

`pkgdown` code highlighting is done with parsing text inside appropriate HTML tags (`<pre>`, `<code>`) and wrapping certain strings in `<span></span>` tag with appropriate class. `highdown` is designed to be applied after building `pkgdown` site with `pkgdown::build_site()`. The idea is to find certain nodes in HTML page with text matching certain regular expression (say, `"%>%"` for pipe operator) and add certain class to it (say, "pp"). This can make styling with custom CSS possible.

Typical usage:

-   Run `pkgdown::build_site()`.
-   Run function `highdown::xml_add_class_pattern(xpath, pattern, new_class)` with appropriate arguments to add class `new_class` to those nodes which satisfy XPATH expression `xpath` and with text matching regular expression `pattern`.
-   Add CSS rules for styling.

Also there is a function to highlight pipe operator: `high_pipe()`. Basically, its a wrapper for `xml_add_class_pattern("//pre//span", "%>%", "pp")`. After applying it, one should add CSS rules for class "pp", for example ".pp {font-weight: bold;}".
