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
