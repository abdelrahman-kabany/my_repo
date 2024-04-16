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
    capinfos -c "$pcap_file" | grep "Number of packets" | awk '{print $4}'
    echo "======================================================================="
    # get all protocols number of frames and total bytes
    echo "get all protocols number of frames and total bytes"
    tshark -r "$pcap_file" -qz io,phs
    echo "======================================================================="
    echo "Top 5 source IP addresses"
    echo "The format is : "number_of_frames IP_address""
    # get top 5 source IPs
    tshark -r "$pcap_file" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5
    echo "======================================================================="
    echo "Top 5 destination IP addresses"
    echo "The format is : "number_of_frames IP_address""
    # get top 5 destination IPs
    tshark -r "$pcap_file" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5
    echo "======================================================================="

}
analyze_traffic