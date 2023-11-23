local grafana = import '../g.libsonnet';
local common = import 'common.libsonnet';

{
  memoryUsage(title, targets):
    common.timeSeriesBase(title, targets)
    + grafana.panel.timeSeries.standardOptions.withUnit('bytes')
    + grafana.panel.timeSeries.fieldConfig.defaults.custom.scaleDistribution.withType('log')
    + grafana.panel.timeSeries.fieldConfig.defaults.custom.scaleDistribution.withLog(2)
    + grafana.panel.timeSeries.standardOptions.withOverrides([
      // Memory-specific overrides
    ]),
}
