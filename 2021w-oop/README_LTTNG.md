# LTTng Instrumentation for Graph Traversal

## Setup

1. Install LTTng (optional):
```bash
sudo apt-get install lttng-tools lttng-modules-dkms liblttng-ust-dev
```

2. Build options:
```bash
# Normal build (no instrumentation)
make

# Build with LTTng instrumentation
make lttng

# Or use flag directly
make LTTNG=1
```

## Usage

1. Start tracing:
```bash
./trace_analysis.sh
```

2. Run the program in another terminal:
```bash
./output/main
```

3. Return to tracing terminal and press Enter to stop and analyze

## Tracepoints

- `traversal_start`: Algorithm start with parameters
- `traversal_end`: Algorithm completion with performance metrics  
- `node_visit`: Each node visited during traversal

## Analysis

View traces with:
```bash
babeltrace ./traces
```

Filter specific events:
```bash
babeltrace ./traces | grep "traversal_start"
babeltrace ./traces | grep "node_visit"
```