# knocker
Knocks on some random ports given to it. Compatible with [Knockd](http://www.zeroflux.org/projects/knock).

Will check for the environment variable ``KNOCK_KNOCK_PORTS`` for the ports to send to.

## Usage
```sh
$ dub run knocker -- host.na.me 8888 444 222 ; ssh user@host.na.me
```

## License
MIT
