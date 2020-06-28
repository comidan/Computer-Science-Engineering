# Fundamentals of the Internet and Networks

## Topics

### INTRODUCTION TO INTERNETWORKING

- What types of networks exist: General principles and classification of telecommunications networks

- How network communication is managed: the concept of communication protocol, layered architectural models, packet switching and circuit switching

 

### CHARACTERIZATION OF COMMUNICATION SYSTEMS

- How information travels on the net: notes on the characterization of signals (the concept of signal bandwidth, numeric signals)

- Where information travels online: notes on the characterization of transmission media (the channel band, transfer delay, the concept of channel capacity)

- How I measure a telecommunications network: the concept of throughput, delays in telecommunications networks (transmission time, transfer delay, processing time, queuing time)

 

### APPLICATION PROTOCOLS

- Network application architectures: client-server approach and peer-to-peer approach

- Examples of client-server application protocols: HTTP, FTP, SMTP, DNS

- Peer-to-peer architectures: BitTorrent

 

### THE TRANSPORT LEVEL

- Characterization of the communication service between application processes; untrusted transport: the UDP (segment format) protocol

- Reliable transport: the TCP protocol (segment format, connection opening, flow control, congestion control and error control)

 

### THE LEVEL OF NETWORKING

- The Internet Protocol (IP): services offered by IP, format of IPv4 packets

- Management of IP addresses: formats and notations of IPv4 addresses, classes and special addresses, planning of an IPv4 address space, subnetting and supernetting techniques, automatic assignment of IP addresses: the Dynamic Host Control Protocol (DHCP)

- Private addressing and translation of IP addresses (NAT, NAPT)

- the Internet Control Message Protocol (ICMP)

- Notes on IPv6

 

### FORWARDING AND ROADING ON THE INTERNET

- Direct and indirect forwarding

- Use of routing tables

- Routing on shortest paths, the construction of the shortest path tree

- Link state routing and distance vector routing

- Examples of protocols: RIP, OSPF, BGP

 

### LOCAL NETWORKS AND LINE LEVEL

- The problem of multiple access

- Addressing in local networks

- The Address Resolution Protocol (ARP)

- Interconnection of local networks with bridge / switch

- The Ethernet / 802.3 standard: principles and functioning

- The IEEE 802.11 standard (WiFi): principles and functioning

 

 

### Laboratory activities

- NETWORK TRAFFIC ANALYSIS: In this part, students will have the opportunity to familiarize themselves with tools for analyzing traffic on the net. The activity requires the use of traffic inspection tools such as WireShark (https://www.wireshark.org) that allow you to capture packets circulating on the net and view their contents in a structured way.

- APPLICATION PROTOCOLS AND SOCKET PROGRAMMING: In this part, students will be able to become familiar with the standard application protocols used for network communication between application processes. They will also learn the basics of programming communication interfaces (sockets) using a simplified approach based on the python language.

- NETWORK CONFIGURATION: In this part, students will practice planning and configuring local networks through network emulation tools such as PacketTracer which allows the creation of network scenarios, the configuration of network devices (interfaces, tables and routing protocols) and verification their functionality.
