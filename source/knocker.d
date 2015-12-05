/**
 * The MIT License (MIT)
 * 
 * Copyright (c) 2015 Richard Andrew Cattermole
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import std.socket;
import std.conv;

int main(string[] args) {
	import core.memory;
	GC.disable;

	if (args.length < 3) {
		import std.process : environment;
		
		string KNOCK_KNOCK_PORTS = environment.get("KNOCK_KNOCK_PORTS");
		if (KNOCK_KNOCK_PORTS is null || args.length < 2) {
			import std.stdio : writeln;
			writeln(args[0], " <hostname> <ports...>");
			return 1;
		} else {
			import std.string : split;
			args ~= KNOCK_KNOCK_PORTS.split;
		}
	}

	string hostname = args[1];
	Address[] addresses;

	foreach(i, arg; args[2 .. $]) {
		addresses ~= getAddress(hostname, arg.to!ushort)[0];
	}

	foreach(address; addresses)
		knock(address);

	return 0;
}

void knock(Address address) {
	try {
		TcpSocket socket = new TcpSocket();
		socket.blocking = false;
		socket.connect(address);
		socket.close;
	} catch (Exception e) {}
}
