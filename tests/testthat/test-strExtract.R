stringr::str_extract(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "[a-z]+"
)
# [1] "apples" "bag"    "bag"    "milk"   NA
stringr::str_extract(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "\\d"
)
# "4" NA  NA  "2" NA
