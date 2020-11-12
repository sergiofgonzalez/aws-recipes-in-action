# Networking on AWS &raquo; Basic Networking Concepts
> basic networking concepts needed to interact with AWS network services

## Public, Private IP Addresses and CIDR notation
When working on a local network, you will notice that you are getting addresses like `192.168.1.*`. For example, my laptop is using `192.168.1.34` and my desktop `192.168.1.44` &mdash; those are private ip address, and are only valid for the local network. When accessing the internet, all requests are redirected to the gateway, which in my case is `192.168.1.1` which performs a procedure known as *Name Address Translation* and uses your public gateway address, which can be found in http://api.ipify.org/.

Let's dive a little deeper around these concepts.

An IPv4 address is a 32-digit string of 1s and 0s, but it is typically expressed in *dotted decimal notation*, in which dots separate four decimal numbers from 0 to 255. Each decimal number represents 8 bits of the 32 bit address (`w.x.y.z`).

Each bit of a unique IPv4 address has a defined value. However, IPv4 address prefixes express ranges of IPv4 addresses in which zero or more of the high-order bits are fixed at specific values and the rest of the low-order variable bits are set to zero. Adress prefixes are commonly expressed using the Prefix Length Notation: `StartingAddress/PrefixLength`, where `StartingAddress` is the dotted decimal expression of the first mathematically possible address in range, with the fixed bits at their defined values and the remaining bits to 0, and `PrefixLength` is the number of high-order bits in the address that are fixed.

For example, the IPv4 address prefix 131.107.0.0/16 specifies a range of 65_536 addresses starting from 131.107.0.0. This notation is also known as Classless Inter-Domain Routing notation or CIDR for short.

## Modern Internet Addresses
Since 1993, IPv4 addresses are assigned using CIDR instead of classes.
If you want direct connectivity to the Internet you must use public addresses. If you want to indirect (proxied or translated) connectivity to the Internet you can use either public or private addresses.
ICANN (The Internet Corporation for Assigned Names and Numbers) assigns CIDR-based address prefixes that are guaranteed to be unique on the Internet. For this addresses the value of w in `w.x.y.z` ranges from 1 to 126 and from 128 to 223, with the exception of the private addresses prefixes.
For this reason, a private network should never use those ranges.

In private networks, not all the hosts require direct connectivity to the internet: only routers, servers, proxies, firewalls... do require such access but laptops, desktops, tablets, phones, etc. can proxy their access to the Internet.
For private networks, the Internet designers reserved a portion of the IPv4 address spaces for private address, and those are never assigned as public addresses, so that public and private addresses never overlap.

The following ranges are reserved for address space:
+ `10.0.0.0/8` &mdash; which allows addresses from 10.0.0.1 to 10.255.255.254 (24 host bits)
+ `172.16.0.0/12` &mdash; which allows addresses from 172.16.0.1 to 172.31.255.254 (20 host bits)
+ `192.168.0.0/16` &mdash; which allows addresses from 192.168.0.1 to 192.168.255.254 (16 host bits)

The following IPv4 addresses are also reserved:
+ `0.0.0.0` &mdash; unspecified IPv4 address (indicates absence of an address)
+ `127.0.0.1` &mdash; the IPv4 loopback address (enables a node lo send packets to itself)

Apart from that, there are specific rules you should follow when assigning addresses and subnet prefixes in an organization:
1. The subnet prefix must be unique within the IPv4 network
2. The subnet prefix cannot begin with the numbers 0 or 127
3. The host ID must be unique within a subnet
4. You cannot use the all-zeros or all-ones host IDs

According to that, given an address prefix use the following standard practice to get the range of valid host IDs:
+ For the first IPv4 address, set all the host bits to 0, except for the low order bit which must be set to 1
+ For the last IPv4 address, set all the host bits in the address to 1, except for the low order bit, which must be set to 0

For example, for 192.168.16.0/20:
+ The first valid IPv4 address is 192.168.16.1
+ The last valid IPv4 address is 192.168.31.254, as y=16=00010000

## Summary
+ IPv4 address is expressed in dotted decimal notation as w.x.y.z
+ IPv4 ranges are expressed in CIDR notation as w.x.y.z/N where N is the number of high-order bits which are fixed
+ Public IPv4 addresses are: w.x.y.z with w=1-126 and 128-223
+ Private IPv4 addresses are:
  + `10.0.0.0/8`
  + `172.16.0.0/12`
  + `192.168.0.0/16`
+ Given a IPv4 address range:
  + Set all the host bits to 0, except for the low order bit which must be set to 1
  + Set all the host bits to 1, except for the low order bit, which must be set to 0
+ The address range `0.0.0.0/0` is satisfied by every possible IP address
+ An address range `w.x.y.z/32` is satisfied by a single IP address (w.x.y.z)
