// Imports
local cpuQueries = import 'cpu_queries.libsonnet';
local memoryQueries = import 'memory_queries.libsonnet';

// Combine
{
  cpu: cpuQueries,
  memory: memoryQueries,
}