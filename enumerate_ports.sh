#!/bin/bash

target=''
verbose=false
current_directory=''

print_usage() {
  echo "################################################"
  printf "Usage: Target IP is missing. Use -t flag."
  echo "For verbose results include the -v flag."
  echo "################################################"
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

if [ -d ./results ]; then
  current_directory='./results/'
else
  mkdir ./results
  current_directory='./results/'
fi  


if [ "$verbose" = true ]; then
  echo "################################################"
  echo "[+]Running Rustscan to obtain the ports..."
  ports=$(rustscan -a $target -g| grep -o '\[[0-9,]*\]'|sed 's/[][]//g')
  echo "################################################"

  echo "[+]Open ports are $ports"
  echo "[+]Running NMAP..."
  echo "################################################"
  current_directory+=$target
  nmap $target -T5 -p $ports -sV -oA $current_directory -v
else
  ports=$(rustscan -a $target -g| grep -o '\[[0-9,]*\]'|sed 's/[][]//g')
  current_directory+=$target
  nmap $target -T5 -p $ports -sV -oA $current_directory
fi
