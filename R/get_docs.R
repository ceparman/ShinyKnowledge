#' @title Get docs from a list of d_id
#' @description  Get a set of documents based on d_id
#' @param docs_connection Connections to docsdb collection
#' @param d_ids d_ids as  character vector
#' @return Data frame with doc q_id and score
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'
#'  }
#' }
#' @rdname calc_scores
#' @export

get_docs <- function(docs_connection,d_ids){



search <-  paste0( '{"d_id":  {"$in" :', jsonlite::toJSON(d_ids),' }}')

docs <-docs_connection$find(search)

docs

}


# kb_database <- 'test_kb'
# database_url <- "mongodb://localhost"
# words_connection <- create_collection_connection(kb_database = kb_database,database_url = database_url,collection = "wordsdb")
# words <- c("search","differ")
# docs <- calc_scores(words_connection,words,scale_factor = NULL )
#
# d_ids <- paste(docs$doc)
#
# docs_connection <- create_collection_connection(kb_database = kb_database,database_url = database_url,collection = "questionsdb")
#
# get_docs(docs_connection,d_ids)

