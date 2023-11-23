local grafana = import '../g.libsonnet';
local common = import 'common.libsonnet';

{
  cpuUsage(title, targets):
    common.timeSeriesBase(title, targets)
    + grafana.panel.timeSeries.standardOptions.withUnit('percent')
    + grafana.panel.timeSeries.fieldConfig.defaults.custom.scaleDistribution.withType('linear')
    + grafana.panel.timeSeries.standardOptions.withOverrides([
      // CPU-specific overrides
    ]),
}
