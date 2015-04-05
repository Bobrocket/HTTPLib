module httplib.http;

import httplib.tcp;
private import std.stdio;
private import std.string;

class http
{
	private string headers;
	private tcp socket;
	private const string clrf = "\r\n";

	this(string addr)
	{
		socket = new tcp(addr, 80);
		addheader("Host", addr);
	}

	this (string addr, int timeout)
	{
		socket = new tcp(addr, 80, timeout);
		addheader("Host", addr);
	}

	public void addheader(string key, string val)
	{
		headers ~= format("%s: %s", key, val);
		headers ~= clrf;
	}

	public string httpget(string resource)
	{
		string head = "GET " ~ resource ~ " HTTP/1.1" ~ clrf;
		head ~= headers;
		head ~= clrf;
		
		headers = ""; //Reset our headers for future requests

		socket.send(head);

		string response = "";
		string result;
		do
		{
			result = socket.receive();
			response ~= result;
		}
		while (result != null);
		return response;
	}

	public string httpget(string resource, string header)
	{
		string head = "GET " ~ resource ~ " HTTP/1.1" ~ clrf;
		head ~= header;
		head ~= clrf;

		socket.send(head);

		string response = "";
		string result;
		do
		{
			result = socket.receive();
			response ~= result;
		}
		while (result != null);
		return response;
	}

	public string[] parsereq(string response)
	{
		return response.split(clrf ~ clrf);
	}

	public string responsebody(string response)
	{
		string[] parts = parsereq(response);
		return parts[1 .. parts.length].join();
	}

	public string responseheaders(string response)
	{
		return parsereq(response)[0];
	}

	public void close()
	{
		socket.close();
	}
}