library(mongolite)
library(jsonlite)


testthat::context("Creating")
 kb_database <- 'testthat_test_kb'
 ##Atlas connections


 creds <- readRDS("../../credentials/creds.RDS")
 database_path <- "cluster0.4sd7p.mongodb.net"

 database_url <- paste0("mongodb+srv://",creds$user,":",creds$pass,"@cluster0.4sd7p.mongodb.net")


  kb <- create_KB(kb_database,creds,valdoc,database_url)


  expect_equal(kb$info()$stats$ok,1)



  #Local mongo server

  database_url <- "mongodb://localhost"

  kb <- create_KB(kb_database,creds,valdoc,database_url)


  print(class(kb))

  expect_equal(class(kb),c("mongo","jeroen","environment"))


