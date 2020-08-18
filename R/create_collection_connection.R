#' @title Create a coonnection to a collection
#' @description Creates a connection for a specific collection in a database/
#' @param kb_database Database name.
#' @param database_url database_url full url for db.  i.e mongodb+srv://xxx:xxx@cluster0.4sd7p.mongodb.net/admin or mongodb://localhost/test
#' @param collection collection names
#' @return Returns the mondo connection environment
#' @details
#' @examples
#' \dontrun{
#' if(interactive()){
#'   c<-create_collection_connection(kb_database,database_url,collection)
#'   c$insert(entry)
#'  }
#' }
#' @rdname create_collection_connection
#' @export

create_collection_connection <- function(kb_database,database_url,collection){

url_path = database_url

tryCatch({

connection  <- mongo(db=kb_database,url = url_path ,collection = collection)
return(connection)

} ,error=function(cond){return(paste0("Error creating connection to collection ",collection," in database ",kb_database )
                               )}

)



}
