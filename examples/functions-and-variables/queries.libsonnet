local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  cpuUsage:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (job) (
            rate(
                process_cpu_seconds_total{
                    job=~"$job"
                }
            [$__rate_interval]) * 100
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      CPU Usage: {{job}}
    |||),

  memUsage:
    [
      prometheusQuery.new(
        '$' + variables.datasource.name,
        |||
          sum by (job) (
            process_virtual_memory_bytes{job=~"$job"}
          )
        |||
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        virtual - {{container}}
      |||),
      prometheusQuery.new(
        '$' + variables.datasource.name,
        |||
          sum by (job) (
            process_resident_memory_bytes{job=~"$job"}
          )
        |||
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        resident - {{container}}
      |||),
    ],

  loadUsage:
    [
      prometheusQuery.new(
        '$' + variables.datasource.name,
        'node_load1{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        1m load average
      |||),
      prometheusQuery.new(
        '$' + variables.datasource.name,
        'node_load5{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        5m load average
      |||),
      prometheusQuery.new(
        '$' + variables.datasource.name,
        'node_load15{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        15m load average
      |||),
      prometheusQuery.new(
        '$' + variables.datasource.name,
        'count(node_cpu_seconds_total{mode="idle"})'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        logical cores
      |||),
    ],

}
