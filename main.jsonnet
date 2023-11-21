local g = import 'g.libsonnet';

local row = g.panel.row;

local panels    = import './panels.libsonnet';
local variables = import './variables.libsonnet';
local queries   = import './queries.libsonnet';

g.dashboard.new('Basic Dashboard')
+ g.dashboard.withUid('basic-grafonnet-example')
+ g.dashboard.withDescription(|||
  Dashboard generated with jsonnet
|||)
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withVariables([
  variables.datasource,
  variables.job,
])
+ g.dashboard.withPanels(
  g.util.grid.makeGrid([
    row.new('CPU and Memory')
    + row.withCollapsed(false)
    + row.withPanels([
      panels.timeSeries.cpuUsage('CPU Usage', queries.cpuUsage),
      panels.timeSeries.memoryUsage('Memory Usage', queries.memUsage),
    ]),
    row.new('Load')
    + row.withCollapsed(false)
    + row.withPanels([
      panels.timeSeries.short('Load Average', queries.loadUsage),
    ]),
  ], panelWidth=24)
)
