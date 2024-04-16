#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file=$1

# Function to extract information from the pcap file
analyze_traffic() 
{
    echo "------------------ Network Traffic Analysis Report --------------------"
    echo "======================================================================="
    echo "Total packets : "
    # command to extract the total number of packets
    tcpdump -r "$pcap_file" -nn -tttt 'tcp' | wc -l
    echo "======================================================================="
    # get all protocols number of frames and total bytes
    echo "get http and https/tls number of frames"
    echo "The number of HTTP packets is "
    tshark -r "$pcap_file" -Y "http" | wc -l
    echo "The number of HTTPS/TLS packets is "
    tshark -r "$pcap_file" -Y "tls" | wc -l
    echo "======================================================================="
    echo "Top 5 source IP addresses"
    echo "The format is : "number_of_frames IP_address""
    # get top 5 source IPs
    tshark -r "$pcap_file" -Y "tcp" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5
    echo "======================================================================="
    echo "Top 5 destination IP addresses"
    echo "The format is : "number_of_frames IP_address""
    # get top 5 destination IPs
    tshark -r "$pcap_file" -Y "tcp" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5
    echo "======================================================================="
    echo "----------------------------End of report------------------------------"
    touch report.txt

}
analyze_traffic > report.txt