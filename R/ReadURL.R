#####################################
# Author : Himansu Sahoo
# getData function that takes the URL as a parameter
# appends a custom header into the http request
# If response type is JSON, transform it into a list
# use caching mechanism to read from cache for the second call
#####################################

rm(list=ls())
library("httr")
library("R.cache")

getData <- function(url){
	key <- list(url)
	resp <- loadCache(key)
	if(is.null(resp)) {
		cat(" making the HTTP call for ...", url, "\n")
		resp <- GET(url, add_headers(customeheader = "CS")) # response object, add customheader
		saveCache(resp, key=key, comment="response")
	}
	body <- ""
	if (http_type(resp) == "application/json"){
		body <- content(resp, as="parsed") # if response type is JSON, parsed it to a list 
	}else{
		body <- content(resp, as="text") # return text representation of the response body
	}

	return(body)
}

