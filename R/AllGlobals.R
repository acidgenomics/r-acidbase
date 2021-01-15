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
#' Shared list of optional default formals
#'
#' These can be overwritten using the `options` function.
#'
#' @export
#' @note Updated 2020-08-25.
#'
#' @seealso
#' - https://ggplot2.tidyverse.org/reference/scale_colour_continuous.html
#' - https://ggplot2.tidyverse.org/reference/scale_colour_discrete.html
#'
#' @examples
#' head(formalsList)
formalsList <- list(
    color.continuous = quote(
        getOption(
            x = "acid.color.continuous",
            default = getOption(
                x = "ggplot2.continuous.colour",
                default = AcidPlots::scale_color_synesthesia_c()
            )
        )
    ),
    color.discrete = quote(
        getOption(
            x = "acid.color.discrete",
            default = getOption(
                x = "ggplot2.discrete.colour",
                default = AcidPlots::scale_color_synesthesia_d()
            )
        )
    ),
    compress.remove = quote(
        getOption("acid.compress.remove", default = TRUE)
    ),
    decompress.remove = quote(
        getOption("acid.compress.remove", default = TRUE)
    ),
    export.compress = quote(
        getOption("acid.export.compress", default = FALSE)
    ),
    export.dir = quote(
        getOption("acid.export.dir", default = ".")
    ),
    export.ext = quote(
        getOption("acid.export.ext", default = "csv")
    ),
    export.sparse.ext = quote(
        getOption("acid.export.sparse.ext", default = "mtx")
    ),
    export.quiet = quote(
        getOption("acid.export.quiet", default = FALSE)
    ),
    fill.continuous = quote(
        getOption(
            x = "acid.fill.continuous",
            default = getOption(
                x = "ggplot2.continuous.fill",
                default = AcidPlots::scale_fill_synesthesia_c()
            )
        )
    ),
    fill.discrete = quote(
        getOption(
            x = "acid.fill.discrete",
            default = getOption(
                x = "ggplot2.discrete.fill",
                default = AcidPlots::scale_fill_synesthesia_d()
            )
        )
    ),
    flip = quote(
        getOption(x = "acid.flip", default = TRUE)
    ),
    heatmap.color = quote(
        getOption(
            x = "acid.heatmap.color",
            default = AcidPlots::blueYellow
        )
    ),
    heatmap.correlation.color = quote(
        getOption(
            x = "acid.heatmap.correlation.color",
            default = viridis::viridis
        )
    ),
    heatmap.legend.color = quote(
        getOption(
            x = "acid.heatmap.legend.color",
            default = AcidPlots::synesthesia
        )
    ),
    heatmap.quantile.color = quote(
        getOption(
            x = "acid.heatmap.quantile.color",
            default = viridis::viridis
        )
    ),
    import.make.names = quote(
        getOption("acid.import.make.names", default = syntactic::makeNames)
    ),
    import.metadata = quote(
        getOption("acid.import.metadata", default = FALSE)
    ),
    label = quote(
        getOption(x = "acid.label", default = FALSE)
    ),
    legend = quote(
        getOption(x = "acid.legend", default = TRUE)
    ),
    load.dir = quote(
        getOption("acid.load.dir", default = ".")
    ),
    overwrite = quote(
        getOption("acid.overwrite", default = TRUE)
    ),
    point.size = quote(
        getOption(x = "acid.point.size", default = 3L)
    ),
    quiet = quote(
        getOption("acid.quiet", default = FALSE)
    ),
    save.compress = quote(
        getOption("acid.save.compress", default = TRUE)
    ),
    save.dir = quote(
        getOption("acid.save.dir", default = ".")
    ),
    save.ext = quote(
        getOption("acid.save.ext", default = "rds")
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



## metadataBlacklist ===========================================================
#' Sample metadata blacklist
#'
#' @export
#' @note `sampleId` (`sampleID` for older datasets) is set automatically for
#'   multiplexed/cell-level data.
#' @note Updated 2021-01-14.
#'
#' @examples
#' metadataBlacklist
metadataBlacklist <- sort(c(
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
