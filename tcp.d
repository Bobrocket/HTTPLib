module httplib.tcp;

import std.socket;
private import std.stdio;

class tcp
{
	private Socket tcp_sock;
	
	this(string addr, ushort port)
	{
		//Port boundaries :3
		if (port == 0) port = 1;

		tcp_sock = new TcpSocket(new InternetAddress(addr, port));
	}

	this(string addr, ushort port, int timeout)
	{
		//Port boundaries :3
		if (port == 0) port = 1;
		//if (port < 65536) port = 65536;

		tcp_sock = new TcpSocket(new InternetAddress(addr, port));
		tcp_sock.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVTIMEO, dur!("seconds")(timeout));
	}

	public void send(string data)
	{
		tcp_sock.send(data);
	}

	public string receive()
	{
		int result;
		char[4096] buffer;
		result = tcp_sock.receive(buffer);

		if (result == Socket.ERROR)
		{
			writeln("Socket error: " ~ tcp_sock.getErrorText());
			return null;
		}
		if (result == 0) //No more data
		{
			debug { writeln("Receive operation finished"); }
			return null;
		}
		string res = cast(string) buffer[0 .. result];
		return res;
	}

	public void close()
	{
		tcp_sock.shutdown(SocketShutdown.BOTH);
		tcp_sock.close();
	}
}