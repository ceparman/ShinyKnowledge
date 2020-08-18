


stem_phrase <- function(phrase,options=NULL) {


  suppressWarnings({
    corp <- Corpus(VectorSource(phrase))
    corp <- tm_map(corp, removePunctuation)
    corp <- tm_map(corp, content_transformer(tolower))
    corp <- tm_map(corp, function(x)removeWords(x,stopwords()))
    corp <- tm_map(corp,stemDocument)
    })

  t.matrix <- TermDocumentMatrix(corp)
  terms<- dimnames(t.matrix)$Terms

  terms
}

