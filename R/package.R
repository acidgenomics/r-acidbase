#' AcidBase
#'
#' Low-level base functions imported by Acid Genomics packages.
#'
#' @keywords internal
#'
#' @importClassesFrom BiocGenerics AsIs
#' @importClassesFrom S4Vectors Annotated
#'
#' @importFrom AcidCLI abort alert alertWarning toInlineString
#' @importFrom S4Vectors as.data.frame head metadata metadata<- tail
#' @importFrom goalie allAreAtomic allAreDirs allHaveAccess assert bapply
#'   compressExtPattern extPattern hasLength hasNames hasNoDuplicates isADir
#'   isAFile isAURL isAny isCharacter isFlag isInt isPositive isScalar isString
#'   isSubset isSystemCommand
#' @importFrom methods .hasSlot getClassDef is isGeneric selectMethod
#'   setClassUnion setMethod setOldClass signature slot slotNames
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
