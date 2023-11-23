local grafana = import '../g.libsonnet';
local variables = import '../variables/main.libsonnet';

local prometheusQuery = grafana.query.prometheus;

{
  cpuUsage:
    prometheusQuery.new(
      '$' + variables.dashboard.datasource.name,
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

  loadUsage:
    [
      prometheusQuery.new(
        '$' + variables.dashboard.datasource.name,
        'node_load1{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        1m load average
      |||),
      prometheusQuery.new(
        '$' + variables.dashboard.datasource.name,
        'node_load5{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        5m load average
      |||),
      prometheusQuery.new(
        '$' + variables.dashboard.datasource.name,
        'node_load15{}'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        15m load average
      |||),
      prometheusQuery.new(
        '$' + variables.dashboard.datasource.name,
        'count(node_cpu_seconds_total{mode="idle"})'
      )
      + prometheusQuery.withIntervalFactor(2)
      + prometheusQuery.withLegendFormat(|||
        logical cores
      |||),
    ],

}