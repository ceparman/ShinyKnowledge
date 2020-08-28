
testthat::context("adding questions")



kb_database <- 'testthat_test_kb'

database_url <- "mongodb://localhost"

#kb <- create_KB(kb_database,valdoc,database_url)

documents_connection <- create_collection_connection(kb_database,database_url,"documentsdb")
words_connection <-create_collection_connection(kb_database,database_url,"wordsdb")

meta_data <-list(category="admin",source="web")


document_text <-"This is a question to parse and search is more different"
result <- add_document(documents_connection,words_connection,document_text,meta_data)

expect_equal(result,digest::digest(document_text))

document_text <-"This is a question to parse and search"
result <- add_document(documents_connection,words_connection,document_text,meta_data)
expect_equal(result,digest::digest(document_text))


document_text  <-"This is a question to parse and search is different with new words"

result <- add_document(documents_connection,words_connection,document_text,meta_data)
expect_equal(result,digest::digest(document_text))
