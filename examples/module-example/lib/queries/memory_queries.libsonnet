local grafana = import '../g.libsonnet';
local variables = import '../variables/main.libsonnet';

local prometheusQuery = grafana.query.prometheus;

{
  memUsage:
    [
      prometheusQuery.new(
        '$' + variables.dashboard.datasource.name,
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
        '$' + variables.dashboard.datasource.name,
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

}