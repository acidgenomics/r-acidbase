#' AcidBase
#'
#' Low-level base functions imported by Acid Genomics packages.
#'
#' @keywords internal
#'
"_PACKAGE"



## Classes =====================================================================

#' @importClassesFrom BiocGenerics AsIs
#' @importClassesFrom S4Vectors Annotated DFrame
NULL



## S4 generics and methods =====================================================

#' @importFrom AcidGenerics coerceToList euclidean foldChangeToLogRatio
#' geometricMean headtail intersectAll intersectionMatrix keepOnlyAtomicCols
#' logRatioToFoldChange matchNested rankedMatrix sem showHeader zscore
#' @importFrom BiocGenerics dims duplicated grepl match unlist unique unlist
#' @importFrom S4Vectors head metadata metadata<- na.omit tail
NULL



## Standard functions ==========================================================

#' @importFrom IRanges CharacterList
#' @importFrom goalie allAreAtomic allAreDirs allHaveAccess allAreMatchingFixed
#' allAreMatchingRegex assert bapply compressExtPattern extPattern hasDims
#' hasLength hasNames hasNoDuplicates isADir isAFile isAGitRepo isASystemCommand
#' isAUrl isAny isCharacter isDuplicate isFlag isInRange isInstalled isInt
#' isPositive isScalar isString isSubset isSystemCommand requireNamespaces
#' @importFrom methods .hasSlot getClassDef is isGeneric selectMethod
#' setClassUnion setMethod setOldClass signature slot slotNames
NULL
