x <- c(
    "aaa aa a",
    "aa a",
    "a",
    "b",
    "b bb",
    "b bb bbb",
    "b aa"
)
stringi::stri_extract_all_fixed(x, pattern = "a")
stringi::stri_extract_all_regex(x, pattern = "a+")
stringi::stri_extract_first_fixed(x, pattern = "a")
stringi::stri_extract_first_regex(x, pattern = "a+")

strExtractAll(
    x = c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    pattern = "[a-z]+"
)
strExtractAll(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "\\d"
)

stringr::str_extract_all(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "[a-z]+"
)
## [[1]]
## [1] "apples" "x"
##
## [[2]]
## [1] "bag"   "of"    "flour"
##
## [[3]]
## [1] "bag"   "of"    "sugar"
##
## [[4]]
## [1] "milk" "x"
##
## [[5]]
## [1] NA
##
stringr::str_extract_all(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "\\d"
)
## [[1]]
## [1] "4"
##
## [[2]]
## character(0)
##
## [[3]]
## character(0)
##
## [[4]]
## [1] "2"
##
## [[5]]
## [1] NA
##
