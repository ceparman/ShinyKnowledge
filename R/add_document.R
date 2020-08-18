

#' @title add_document
#' @description add a quesion to the KB
#' @param collection_connection mongo connections to collection
#' @param document_text document test
#' @param meta_data meta data key value pairs in a list format.
#' @return returns MONGO insert details or error message
#' @details
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'
#'kb_database <- 'test_kb'
#'creds <- readRDS("../../credentials/creds.RDS")
#'database_path <- "cluster0.4sd7p.mongodb.net"
#'collection <- "documentdb"
#'collection_connection<- create_collection_connection(kb_database,creds,database_path,collection)
#'meta_data <-list(category="admin",source="web")
#'document_text <-"This is a document to parse and search"
#'result <- add_document(db_connection,document_text,meta_data,keywords)
#'result
#'  }
#' }
#' @rdname add_document
#' @export

add_document <- function(kb_database,creds,database_url,document_text,meta_data){

collection <- "documentsdb"

document_connection <- create_collection_connection(kb_database,database_url,collection)


return <- tryCatch({

#create hash for document

q_id <- digest::digest(document_text)

#add the document text

entry <- as.data.frame(meta_data,stringsAsFactors = F)

entry$text <- document_text

entry$q_id <- q_id

document_connection$insert(entry)


} ,error=function(cond){ return( paste0("Error adding quesion to database ",document_connection$info()$stats$ns)
                                 )
                       }
)

#add words
collection <- "wordsdb"

words_connection <- create_collection_connection(kb_database,database_url,collection)

terms <- as.list(stem_phrase(document_text))


return <- lapply(terms,function(x) {add_word(words_connection,x,q_id)} )


print(return)

q_id


}



# kb_database <- 'test_kb'
# creds <- readRDS("../../credentials/creds.RDS")
# database_path <- "cluster0.4sd7p.mongodb.net"
# collection <- "documentsdb"
# collection_connection <- create_collection_connection(kb_database,creds,database_path,collection)
# meta_data <-list(category="admin",source="web")
# document_text <-"This is a document to parse and search"
# result <- add_document(collection_connection,document_text,meta_data,keywords)
# result
