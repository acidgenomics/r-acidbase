#' Git branch strings
#'
#' @name gitBranch
#' @note Updated 2022-05-02.
#'
#' @param repo `character(1)`.
#' Git repository directory path.
#'
#' @param remote `character(1)`.
#' Remote name.
#'
#' @return `character(1)`.
#' Git branch name.
#'
#' @seealso
#' - `koopa::git_default_branch` (shell).
#' - `git branch` (shell).
#' - git2r package.
#'
#' @examples
#' ## > repo <- file.path("~", "git", "monorepo", "r-packages", "r-koopa")
#' ## > gitCurrentBranch(repo)
#' ## ## [1] "develop"
#' ## > gitDefaultBranch(repo)
#' ## ## [1] "main"
NULL



#' @rdname gitBranch
#' @export
gitCurrentBranch <- function(repo = getwd()) {
    assert(
        isAGitRepo(repo),
        isASystemCommand("git")
    )
    x <- shell(
        command = "git",
        args = c("branch", "--show-current"),
        print = FALSE,
        wd = repo,
        returnStdout = TRUE
    )
    assert(isString(x))
    x
}



#' @rdname gitBranch
#' @export
gitDefaultBranch <-
    function(repo = getwd(),
             remote = "origin") {
        assert(
            isAGitRepo(repo),
            isString(remote),
            isASystemCommand("git")
        )
        x <- shell(
            command = "git",
            args = c("remote", "show", remote),
            print = FALSE,
            wd = repo,
            returnStdout = TRUE
        )
        assert(isCharacter(x))
        pattern <- "^[[:space:]]+HEAD branch: ([^[:space:]]+)$"
        x <- grep(pattern = pattern, x = x, value = TRUE)
        x <- sub(pattern = pattern, replacement = "\\1", x = x)
        assert(isString(x))
        x
    }
