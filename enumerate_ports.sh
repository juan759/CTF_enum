#!/bin/bash

target=''
verbose=false

print_usage() {
  printf "Usage: Target IP is missing. Use -t flag."
  echo "For verbose results include the -v flag."
}

while getopts 't:v' flag; do
  case "${flag}" in
    t) target=${OPTARG} ;;
    v) verbose=true ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -z "$target" ]; then
  print_usage
  exit 1
fi

if [ "$verbose" = true ]; then
  echo "[+]Running Rustscan to obtain the ports..."
  ports=$(rustscan -a $target -g| grep -o '\[[0-9,]*\]'|sed 's/[][]//g')
  echo "[+]Open ports are $ports"
  echo "[+]Running NMAP..."
  nmap -T5 -p $ports -sV -oA nmap_results -v
else
  ports=$(rustcan -a $target -g| grep -o '\[[0-9,]*\]'|sed 's/[][]//g')
  nmap -T5 -p $ports -sV -oA nmap_results
fi
  