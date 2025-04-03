#!/bin/bash

for f in *.csv.txt; do
  mv "$f" "$(echo "$f").csv";
done