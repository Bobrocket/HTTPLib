module httplib.quickhttp;

import httplib.http;
private import std.stdio;
private import std.string;
private import std.array;
private import std.algorithm;

class quickhttp
{
	alias get downloadstring;
	private string headers = "";;
	private const string clrf = "\r\n";

	this()
	{
	}

	public void addheader(string key, string val)
	{
		headers ~= format("%s: %s", key, val);
		headers ~= clrf;
	}

	public string get(string resource)
	{
		string x = "";
		if (resource.startsWith("http://")) x = resource.replaceFirst("http://", "");
		if (resource.startsWith("https://")) x = resource.replaceFirst("https://", "");
		http ht;
		if (resource.indexOf("/") == -1)
		{
			ht = new http(resource);
			addheader("Host", resource);
			return ht.httpget("/", headers);
		}
		else
		{
			int index = x.indexOf("/");
			string res = x[index .. $];
			string host = x.replace(res, ""); //For some reason, x[0 .. index] would return the entire string? So we use the replace function to extract the host
			ht = new http(host);
			addheader("Host", host);
			return ht.httpget(res, headers);
		}
	}
}