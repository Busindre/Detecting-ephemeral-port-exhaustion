# Bashscript to detect ephemeral ports exhaustion

#### Ephemeral ports: http://www.ncftp.com/ncftpd/doc/misc/ephemeral_ports.html
#### Script:

## The Ephemeral Port Range.

The ephemeral port range limits the maximum number of connections from one machine to a specific service on a remote machine! The TCP/IP protocol uses the connection's 4-tuple to distinguish between connections, so if the ephemeral port range is only 4000 ports wide, that means that there can only be 4000 unique connections from a client machine to a remote service at one time.

A port range of 4000 may seem large, but it is actually small for 21st century computing demands when you consider that a TCP connection must expire through the TIME_WAIT state before it is really completed.  For example, even if both sides of a connection properly close their ends of the connection, due to TCP's error control, each side must wait until the TIME_WAIT state is expired before the connection's resources can really be disposed.  The TIME_WAIT state is twice the MSL (maximum segment lifetime) which, depending on the IP stack, is usually configured to be 240 seconds total.  That means that you could have only 4000 connections per 240 second window, and in practice this can be exhausted.

The simple script shows the range of ports was configured, which are currently in use and how many ports are still free. Modifying it to work in Nagios / Icinga is trivial and very useful.
