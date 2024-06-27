# CTF_enum
When being in a CTF many times, time itself is an enemy. With this simple script I reduce the amount of time I need to enumerate a machine, by automating the process. 

## The first part
It is a simple NMAP command to enumerate all ports on a machine, since this is a CTF we don't mind being loud. 

## The second part
It is a simple command to enumerate again open ports in a machine wiht the tool Rustscan.

## Usage example
All it takes to use the tool is an IP.
```
$chmod +x enumerate_ports.sh
$./enumerate_ports -t <IP_attacking>
```