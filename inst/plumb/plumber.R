library(plumber)


#* @apiTitle Plumber RAN


#* @serializer contentType list(type="text/plain")
#* @get /src/contrib/PACKAGES


function(){
    tmp <- tempfile()
    PACKAGE <- readLines("src/contrib/PACKAGES")
    for (i in seq_along(PACKAGE)){
    write(PACKAGE[i], tmp, append = TRUE)
    }
    readBin(tmp, "raw", n=file.info(tmp)$size)
}


#* @serializer contentType list(type="application/x-tar")
#* @get /src/contrib/attempt_0.3.0.9000.tar.gz
function(){
    tmp <- tempfile()
    file.copy(normalizePath("src/contrib/attempt_0.3.0.9000.tar.gz"), tmp)
    readBin(tmp, "raw", n=file.info(tmp)$size)
}


#* @serializer contentType list(type="application/x-tar")
#* @get /src/contrib/shinipsum_0.0.0.9000.tar.gz
function(){
    tmp <- tempfile()
    file.copy(normalizePath("src/contrib/shinipsum_0.0.0.9000.tar.gz"), tmp)
    readBin(tmp, "raw", n=file.info(tmp)$size)
}


