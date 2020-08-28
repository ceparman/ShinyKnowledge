

#' @title add_document
#' @description add a quesion to the KB
#' @param documents_connection mongo connection to documents collection
#' @param words_connection mongo connection to words collection
#' @param document_text document test
#' @param meta_data meta data key value pairs in a list format.
#' @return returns MONGO insert details or error message
#' @details
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'
#'  }
#' }
#' @rdname add_document
#' @export

add_document <- function(documents_connection,words_connection,document_text,meta_data){



return <- tryCatch({

#create hash for document

d_id <- digest::digest(document_text)

#add the document text

entry <- as.data.frame(meta_data,stringsAsFactors = F)

entry$text <- document_text

entry$d_id <- d_id

documents_connection$insert(entry)


} ,error=function(cond){ return( paste0("Error adding quesion to database ",documents_connection$info()$stats$ns)
                                 )
                       }
)

#add words

terms <- as.list(stem_phrase(document_text))


return <- lapply(terms,function(x) {add_word(words_connection,x,d_id)} )



d_id


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
