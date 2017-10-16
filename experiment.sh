# Note that ran sum.c multiple times, 108ms was the lowest time for summing 32KB amost 10000 times
# that means .0108ms for use SSE instructions
grep Time foo.txt | cut -d' ' -f5 | gawk '{s+=$1} END {print s}'
