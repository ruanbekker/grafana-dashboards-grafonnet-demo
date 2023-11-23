local grafana = import '../g.libsonnet';

{
  timeSeriesBase(title, targets): 
    grafana.panel.timeSeries.new(title)
    + grafana.panel.timeSeries.queryOptions.withTargets(targets)
    + grafana.panel.timeSeries.queryOptions.withInterval('1m')
    + grafana.panel.timeSeries.options.legend.withDisplayMode('table')
    + grafana.panel.timeSeries.options.legend.withCalcs([
      'lastNotNull',
      'max',
    ])
    + grafana.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + grafana.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never'),
}
