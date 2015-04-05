# HTTPLib
A simple way to send and manipulate HTTP requests with the D language.

# Basic Requests
You can simply send a request like this:

quickhttp client = new quickhttp();
string response = client.downloadstring("http://tunnelsnake.com/");

This will send a GET request to http://tunnelsnake.com/ with no headers apart from the Host header.

# Adding headers
You can add headers like this:

quickhttp client = new quickhttp();
client.addheader("Accept", "*/*");
client.addheader("User-Agent", "HTTPLib example 1.0");
string response = client.downloadstring("http://tunnelsnake.com/");

This will send a GET request to http://tunnelsnake.com/ with the Accept and User-Agent headers.

# Manipulating responses
You can manipulate the responses (e.g get just the body or the headers) like this:

USING QUICKHTTP
quickhttp client = new quickhttp();
string response = client.downloadstring("http://tunnelsnake.com/");
string body = (new http("")).responsebody(response);
string headers = (new http("")).responseheaders(response);

USING HTTP
http client = new http("tunnelsnake.com");
string response = client.httpget("/");
string body = client.responsebody(response);
string headers = client.responseheaders(response);
