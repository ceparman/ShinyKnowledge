#Parsing functions used by calc_scores

parse_row <- function(x) {  df <- suppressWarnings( data.frame( doc = str_split(x$docs,","),x[which(names(x) != "docs")] ) )

names(df)[1] <- "doc"

return(df)
}


parse_rows <- function(values) {
  r<- data.frame()

  for (i in 1:nrow(values)){

    r<- rbind(r,parse_row(values[i,]))


  }
  r
}

