#!/bin/bash

# LTTng tracing script for graph traversal analysis

echo "=== Graph Traversal LTTng Instrumentation ==="

# Create tracing session
lttng create graph-session --output=./traces

# Enable userspace events
lttng enable-event --userspace graph_provider:*

# Start tracing
lttng start

echo "Tracing started. Run your graph program now..."
echo "Press Enter when done to stop tracing and analyze results"
read

# Stop tracing
lttng stop
lttng destroy

echo "=== Trace Analysis ==="

# Basic trace analysis
echo "1. Traversal Events:"
babeltrace ./traces | grep "traversal_start\|traversal_end"

echo -e "\n2. Node Visit Count:"
babeltrace ./traces | grep "node_visit" | wc -l

echo -e "\n3. Performance Summary:"
babeltrace ./traces | grep "traversal_end" | awk '{
    if ($0 ~ /DFS/) dfs_time = $NF; 
    if ($0 ~ /BFS/) bfs_time = $NF;
} END {
    if (dfs_time) print "DFS Duration: " dfs_time " ms";
    if (bfs_time) print "BFS Duration: " bfs_time " ms";
}'

echo -e "\n4. Full trace available in: ./traces"
echo "Use 'babeltrace ./traces' for detailed analysis"