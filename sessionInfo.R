# ## session info
# ## document software details at the beginning of the project
# library("devtools")
# library("knitr")
# 
# my_session_info <- devtools::session_info()
# 
# writeLines(text = {
#   paste(sep = "\n", collapse = "",
#         paste0(rep("-", 80), collapse = ""),
#         paste(paste0(rep("-", 32), collapse = ""),
#               "R environment",
#               paste0(rep("-", 33), collapse = "")),
#         paste0(rep("-", 80), collapse = ""),
#         paste(knitr::kable(data.frame(setting = names(my_session_info$platform),
#                                       value = as.character(my_session_info$platform))), collapse = "\n"),
#         paste0(rep("-", 80), collapse = ""),
#         paste(paste0(rep("-", 35), collapse = ""),
#               "packages",
#               paste0(rep("-", 35), collapse = "")),
#         paste0(rep("-", 80), collapse = ""),
#         paste(knitr::kable(my_session_info$packages), collapse = "\n")
#   )
# }, con = "session_info.txt")