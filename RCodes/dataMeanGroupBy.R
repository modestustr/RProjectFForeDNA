dataMeanGroupBy <- function(data, group_indices, sta_param, naTrim = FALSE) {
  data %>%
    group_by(across(all_of(group_indices))) %>%
    summarize(mean_copy = mean(!! rlang::sym(sta_param), na.rm = naTrim))
}
