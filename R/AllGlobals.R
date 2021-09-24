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



## formalsList =================================================================
## FIXME Consider moving this to AcidPlots, removing, or reworking.

#' Shared list of optional default formals
#'
#' These can be overwritten using the `options` function.
#'
#' @export
#' @note Updated 2021-09-09.
#'
#' @seealso
#' - https://ggplot2.tidyverse.org/reference/scale_colour_continuous.html
#' - https://ggplot2.tidyverse.org/reference/scale_colour_discrete.html
#'
#' @examples
#' head(formalsList)
formalsList <- list(
    ## FIXME Consider taking this out in future release.
    ## FIXME Default should contain the actual function.
    "color.continuous" = quote(
        getOption(
            x = "acid.color.continuous",
            default = getOption(
                x = "ggplot2.continuous.colour",
                default = AcidPlots::scale_color_synesthesia_c()
            )
        )
    ),
    ## FIXME Consider taking this out in future release.
    ## FIXME Default should contain the actual function.
    "color.discrete" = quote(
        getOption(
            x = "acid.color.discrete",
            default = getOption(
                x = "ggplot2.discrete.colour",
                default = AcidPlots::scale_color_synesthesia_d()
            )
        )
    ),
    ## FIXME Consider taking this out in future release.
    ## FIXME Default should contain the actual function.
    "fill.continuous" = quote(
        getOption(
            x = "acid.fill.continuous",
            default = getOption(
                x = "ggplot2.continuous.fill",
                default = AcidPlots::scale_fill_synesthesia_c()
            )
        )
    ),
    ## FIXME Consider taking this out in future release.
    ## FIXME Default should contain the actual function.
    "fill.discrete" = quote(
        getOption(
            x = "acid.fill.discrete",
            default = getOption(
                x = "ggplot2.discrete.fill",
                default = AcidPlots::scale_fill_synesthesia_d()
            )
        )
    ),
    "flip" = quote(
        getOption(x = "acid.flip", default = TRUE)
    ),
    "heatmap.color" = quote(
        getOption(
            x = "acid.heatmap.color",
            default = AcidPlots::blueYellow
        )
    ),
    "heatmap.correlation.color" = quote(
        getOption(
            x = "acid.heatmap.correlation.color",
            default = viridis::viridis
        )
    ),
    "heatmap.legend.color" = quote(
        getOption(
            x = "acid.heatmap.legend.color",
            default = AcidPlots::synesthesia
        )
    ),
    "heatmap.quantile.color" = quote(
        getOption(
            x = "acid.heatmap.quantile.color",
            default = viridis::viridis
        )
    ),
    "label" = quote(
        getOption(x = "acid.label", default = FALSE)
    ),
    "legend" = quote(
        getOption(x = "acid.legend", default = TRUE)
    ),
    ## FIXME Remove, move to pipette?
    "overwrite" = quote(
        getOption("acid.overwrite", default = TRUE)
    ),
    "point.size" = quote(
        getOption(x = "acid.point.size", default = 3L)
    ),
    "quiet" = quote(
        getOption("acid.quiet", default = FALSE)
    )
)



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
