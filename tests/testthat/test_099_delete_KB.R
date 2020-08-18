library(mongolite)
library(jsonlite)

testthat::context("Deleting")

 kb_database <- 'testthat_test_kb'
 ##Atlas connections


 creds <- readRDS("../../credentials/creds.RDS")
 database_path <- "cluster0.4sd7p.mongodb.net"
 database_url <- paste0("mongodb+srv://",creds$user,":",creds$pass,"@cluster0.4sd7p.mongodb.net")

 kb<-mongo( database_url,db =   kb_database,collection = "admin")

 # kb <- create_KB(kb_database,creds,valdoc,database_url)

  #expect_equal(class(kb),c("mongo","jeroen","environment"))

  d<- kb$run( '{"dropDatabase": 1}' )

  expect_equal(d$ok,1)


  #Local mongo server

  database_url <- "mongodb://localhost"

   kb <-mongo(database_url,db = kb_database)

 # kb <- create_KB(kb_database,creds,valdoc,database_url)

  #expect_equal(class(kb),c("mongo","jeroen","environment"))

  d<-   kb$run( '{"dropDatabase": 1}' )

  expect_equal(d$ok,1)
