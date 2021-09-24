#' AcidBase
#'
#' Low-level base functions imported by Acid Genomics packages.
#'
#' @keywords internal
#'
#' @importClassesFrom AcidGenerics Annotated AsIs
#'
#' @importFrom AcidGenerics grepl gsub head metadata paste tail
#' @importFrom AcidCLI abort alert alertWarning toInlineString
#' @importFrom goalie allAreAtomic allAreDirs allHaveAccess assert bapply
#'   extPattern hasLength hasNames hasNoDuplicates isADir isAFile isAURL isAny
#'   isCharacter isFlag isInt isPositive isScalar isString isSubset
#'   isSystemCommand
#' @importFrom methods .hasSlot getClassDef is isGeneric selectMethod setMethod
#'   setOldClass signature slot slotNames
#' @importFrom processx run
#' @importFrom stats var
#' @importFrom utils capture.output download.file unzip zip
"_PACKAGE"



#' Shared parameter documentation
#'
#' @name params
#'
#' @param width `integer(1)`.
#'   Width.
#' @param x Object.
#'
#' @return No value.
NULL
