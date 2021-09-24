## barcodePattern ==============================================================
#' Single-sell barcode pattern
#'
#' Trailing number is to match cellranger output.
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' barcodePattern
barcodePattern <- ")_([ACGT_]{6,})(_[0-9]+)?$"



## genomeMetadataNames =========================================================
#' Slot names in metadata containing genome information
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' genomeMetadataNames
genomeMetadataNames <- c("organism", "genomeBuild", "ensemblRelease")



## lanePattern =================================================================
#' Sequencing lane grep pattern
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' lanePattern
lanePattern <- "_L([[:digit:]]{3})"



## metadataDenylist ============================================================
#' Sample metadata denylist
#'
#' @export
#' @note `sampleId` (`sampleID` for older datasets) is set automatically for
#'   multiplexed/cell-level data.
#' @note Updated 2021-02-25.
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
#' @note Previously: "nGene", "log10GenesPerUMI".
#' @note Updated 2019-08-21.
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
#' @note Updated 2019-08-21.
#'
#' @examples
#' message(updateMessage)
updateMessage <- "Run 'updateObject()' to update your object."
