# Helper function to plot tables
plot_table <- function(data_source, head = FALSE) {
  require(magrittr, quietly = TRUE, warn.conflicts = FALSE)
  require(dplyr, quietly = TRUE, warn.conflicts = FALSE)
  require(tinytable, quietly = TRUE, warn.conflicts = FALSE)

  data_frame <-
    data_source %>%
    as.data.frame()

  if (
    "description" %in% colnames(data_frame) ||
      "notes" %in% colnames(data_frame)
  ) {
    data_frame <-
      data_frame %>%
      dplyr::select(
        !dplyr::any_of(c("description", "notes"))
      )
  }

  if (
    isTRUE(head)
  ) {
    data_frame <-
      head(data_frame)
  }

  data_frame %>%
    pander::pandoc.table()
}
