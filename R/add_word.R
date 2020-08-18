#' @title add_word
#' @description adds or update an entry in the words collections
#' @param collection_connection connection to wordsdb collection
#' @param word word to be added/updated
#' @param q_id q_id of the question source
#' @param score_factor score factor used if new entry, Default: 1
#' @param options TBD, Default: NULL
#' @return add count, modified count (should be 1), or error message
#' @details
#' @examples
#' \dontrun{
#' if(interactive()){
#'  add_word(words_connection,"word",q_id)
#'  }
#' }
#' @rdname add_word
#' @export

add_word<- function(collection_connection,word,q_id,score_factor=1,options=NULL){



#Is word in the database?


query <- collection_connection$find( paste0('{"word":"',word,'"}') )

l <- as.character(nrow(query))

switch( l ,

"0"={
  entry <- data.frame(
    word = word,
    docs= q_id,
    score_factor = score_factor
  )

  r<- collection_connection$insert(entry)
  r$nInserted

  },

"1" = {

  docs <- paste(c(query$docs,q_id),collapse=",")

  score_factor <-  round(  1/ sqrt((str_count(docs,",")+1)),4)

  r<-  collection_connection$update(paste0('{"word":"',word,'"}'),
     paste0('{"$set":{"docs":"',docs,'","score_factor":',score_factor,'}}')
     )



  r$modifiedCount

  },

 errorCondition("Same word repeated in database")

)

}






#
# kb_database <- 'test_kb'
# database_path <- "mongodb://localhost"
# collection <- "wordsdb"
# collection_connection <- create_collection_connection(kb_database,creds,database_path,collection)
# word <- "par"
# q_id <- "ccc7359621953a12986af07f5155f3e9"
# result <- add_word(collection_connection,word,q_id)
# result
