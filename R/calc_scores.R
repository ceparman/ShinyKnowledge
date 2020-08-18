#' @title Find doc scores for terms
#' @description  Finds scores for documents form a list of terms
#' @param words_connection Connections to wordsdb collection
#' @param words terms to look up as a character string
#' @param scale_factor TBD Default: NULL
#' @return Data frame with doc q_id and score
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'
#'kb_database <- 'test_kb'
#'database_url <- "mongodb://localhost"
#'words_connection <- create_collection_connection(kb_database = kb_database,database_url = database_url,collection = "wordsdb")
#'
#'words <- c("search","differ")
#'
#'calc_scores(words_connection,words,scale_factor = NULL )
#'  }
#' }
#' @rdname calc_scores
#' @export

calc_scores <- function(words_connection,words,scale_factor = NULL ){



 search <-  paste0( '{"word":  {"$in" :', toJSON(words),' }}')

 values <- words_connection$find(search)




result <- parse_rows(values)


result %>% group_by(doc) %>% summarise( score = sum(score_factor))

}


# kb_database <- 'test_kb'
#
# database_url <- "mongodb://localhost"
# words_connection <- create_collection_connection(kb_database = kb_database,database_url = database_url,collection = "wordsdb")
#
# words <- c("search","differ")
#
#
#
# calc_scores(words_connection,words,scale_factor = NULL )
#
#
#
#
