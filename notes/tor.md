# Tor Config Example

Path: `/usr/local/etc/tor/torrc`

```
AvoidDiskWrites 1

ExcludeNodes {cn},{hk},{mo},{sg},{th},{pk},{by},{ru},{ir},{vn},{ph},{my},{cu}
ExcludeExitNodes {cn},{hk},{mo},{sg},{th},{pk},{by},{ru},{ir},{vn},{ph},{my},{cu}

SocksPort 9050
ControlPort 9051
CookieAuthentication 1

# pip install obfsproxy stem
ClientTransportPlugin obfs2,obfs3,scramblesuit exec /usr/local/bin/obfsproxy managed
ClientTransportPlugin fte exec /usr/local/bin/fteproxy --managed

UseBridges 1
# Get Tor Bridges from https://bridges.torproject.org/bridges and append them below
```
