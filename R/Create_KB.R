
#' @title create_KB
#' @description Creates tables for ShinyKnowledge
#' @param kb_database Database name.
#' @param valdoc validation json doc that used in creating metadata table
#' @param database_url full url for db.  i.e mongodb+srv://xxx:xxx@cluster0.4sd7p.mongodb.net/admin or mongodb://localhost/test
#' @return returns "created KB successful" if sucsessful or error message if function fails.
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  KB <- create_KB(kb_database,valdoc,database_url)
#'  }
#' }
#' @rdname create_KB
#' @export

create_KB <- function(kb_database,valdoc,database_url)
{

return_val <-   tryCatch({

#create database


url_path = paste0(database_url,"/admin")

db <- mongo(db=kb_database,url = url_path )

#create documents collection

#Drop it if it exists
tryCatch({
eval( parse(text = paste0("db$run(",jsonlite::toJSON( '{"drop":"documentsdb"}'  ,auto_unbox = T),")" )
)
)
}, error = function(x){})

#Create empty document  collection

  eval( parse(text = paste0("db$run(", jsonlite::toJSON( '{"create":"documentsdb"}'  ,auto_unbox = T),")" )
  )
  )




#create words collection

#Drop it if it exists


  tryCatch({
  eval( parse(text = paste0("db$run(",jsonlite::toJSON( '{"drop":"wordsdb"}'  ,auto_unbox = T),")" )
  )
  )
  }, error = function(x) {}
)

 #Create empty words collection

 eval( parse(text = paste0("db$run(",jsonlite::toJSON( '{"create":"wordsdb"}'  ,auto_unbox = T),")" )
 )
 )



  #create indexes to be added

db$run( '{"createIndexes":"documentsdb","indexes":[{"key":{"d_id":1},"name":"d_id","unique":"true"}]  }' )

db$run( '{"createIndexes":"wordsdb","indexes":[{"key":{"word":1},"name":"word","unique":"true"}]  }' )

}, error=function(cond){return(
                        paste0("Error creating KB. error",cond )

)}


) #end try-Catch





db

}
