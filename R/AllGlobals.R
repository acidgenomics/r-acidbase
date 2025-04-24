## barcodePattern ==============================================================

#' Single-sell barcode pattern
#'
#' Trailing number is to match cellranger output.
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @return `character(1)`.
#'
#' @examples
#' barcodePattern
barcodePattern <- ")_([ACGT_]{6,})(_[0-9]+)?$"


## genomeMetadataNames =========================================================

#' Slot names in metadata containing genome information
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @return `character`.
#'
#' @examples
#' genomeMetadataNames
genomeMetadataNames <- c("organism", "genomeBuild", "ensemblRelease")


## lanePattern =================================================================

#' Sequencing lane grep pattern
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @return `character(1)`.
#'
#' @examples
#' lanePattern
lanePattern <- "_L([[:digit:]]{3})"


## metadataDenylist ============================================================

#' Sample metadata denylist
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @details
#' `sampleId` (`sampleID` for older datasets) is set automatically for
#' multiplexed / cell-level data.
#'
#' @return `character`.
#'
#' @examples
#' metadataDenylist
metadataDenylist <- sort(c(
    ## Automatic / used internally:
    ## > "sampleID",
    ## > "sampleId",
    "interestingGroups",
    "revcomp",
    "rowname",
    ## interestingGroups variants:
    "interestinggroups",
    "intgroup",
    ## sampleId, sampleName variants:
    "ID",
    "Id",
    "id",
    "name",
    "names",
    "sample",
    "samples",
    "sampleid",
    "sampleNames",
    "samplename",
    "samplenames"
))


## metricsCols =================================================================

#' Quality control metric columns
#'
#' Column names returned by `calculateMetrics()`.
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @details
#' Previously: `"nGene"`, `"log10GenesPerUMI"`.
#'
#' @return `character`.
#'
#' @examples
#' metricsCols
metricsCols <- c(
    "nCount",
    "nFeature",
    "nCoding",
    "nMito",
    "log10FeaturesPerCount",
    "mitoRatio"
)


## updateMessage ===============================================================

#' Update message
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @return `character(1)`.
#'
#' @examples
#' message(updateMessage)
updateMessage <- "Run 'updateObject()' to update your object."
