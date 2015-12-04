import std.socket;
import std.conv;

int main(string[] args) {
	import core.memory;
	GC.disable;

	if (args.length < 2) {
		import std.stdio : writeln;
		writeln(args[0], " <hostname> <ports...>");
		return 1;
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
