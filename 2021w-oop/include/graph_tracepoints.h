#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER graph_provider

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./graph_tracepoints.h"

#if !defined(_GRAPH_TRACEPOINTS_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _GRAPH_TRACEPOINTS_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
    graph_provider,
    traversal_start,
    TP_ARGS(
        const char*, algorithm,
        unsigned long, start_index,
        unsigned long, total_nodes
    ),
    TP_FIELDS(
        ctf_string(algorithm, algorithm)
        ctf_integer(unsigned long, start_index, start_index)
        ctf_integer(unsigned long, total_nodes, total_nodes)
    )
)

TRACEPOINT_EVENT(
    graph_provider,
    traversal_end,
    TP_ARGS(
        const char*, algorithm,
        double, duration_ms,
        int, nodes_visited
    ),
    TP_FIELDS(
        ctf_string(algorithm, algorithm)
        ctf_float(double, duration_ms, duration_ms)
        ctf_integer(int, nodes_visited, nodes_visited)
    )
)

TRACEPOINT_EVENT(
    graph_provider,
    node_visit,
    TP_ARGS(
        const char*, node_name,
        unsigned long, node_id
    ),
    TP_FIELDS(
        ctf_string(node_name, node_name)
        ctf_integer(unsigned long, node_id, node_id)
    )
)

#endif /* _GRAPH_TRACEPOINTS_H */

#include <lttng/tracepoint-event.h>