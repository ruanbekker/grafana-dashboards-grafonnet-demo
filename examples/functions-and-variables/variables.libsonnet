local g = import './g.libsonnet';
local var = g.dashboard.variable;

{
  datasource:
    var.datasource.new('datasource', 'prometheus')
    + var.datasource.withRegex('(P|p)rometheus'),

  job:
    var.query.new('job')
    + var.query.withDatasourceFromVariable(self.datasource)
    + var.query.queryTypes.withLabelValues(
      'job',
      'up{}',
    )
    + var.query.withRefresh(1),
}
