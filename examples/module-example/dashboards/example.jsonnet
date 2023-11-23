// Imports
local grafana = import '../lib/g.libsonnet';
local variables = import '../lib/variables/main.libsonnet';
local queries = import '../lib/queries/main.libsonnet';
local panels = import '../lib/panels/main.libsonnet';

// Custom variables
local dashboard_name = 'My Custom Dashboard';
local dashboard_uid = 'my-custom-dashboard';
local dashboard_description = 'Dashboard generated with jsonnet';
local dashboard_timezone = 'browser';
local dashboard_tags = ['custom-service', 'demo'];

// Example usage of the createDashboard function
local dashboardConfig = {
  name: dashboard_name,
  uid: dashboard_uid,
  description: dashboard_description,
  timezone: dashboard_timezone,
  tags: dashboard_tags,
};

// Define a function for creating a dashboard
local createDashboard(name, uid, description, timezone, tags, panelGrid) = 
  grafana.dashboard.new(name)
  + grafana.dashboard.withUid(uid)
  + grafana.dashboard.withDescription(description)
  + grafana.dashboard.withTags(tags)
  + grafana.dashboard.withTimezone(timezone)
  + grafana.dashboard.graphTooltip.withSharedCrosshair()
  + grafana.dashboard.withVariables([
    variables.dashboard.datasource,
    variables.dashboard.job,
  ])
  + grafana.dashboard.withPanels(panelGrid)
  + variables.dashboard.lastSixHours ;

local createPanelGrid() =
  grafana.util.grid.makeGrid([
    grafana.panel.row.new('System Metrics')
    + grafana.panel.row.withCollapsed(false)
    + grafana.panel.row.withPanels([
      panels.cpu.cpuUsage('CPU Usage', queries.cpu.cpuUsage),
      panels.memory.memoryUsage('Memory Usage', queries.memory.memUsage),
    ]),
    // ... more rows here ...
  ], panelWidth=24);

// Function to generate the dashboard
createDashboard(
  dashboardConfig.name,
  dashboardConfig.uid,
  dashboardConfig.description,
  dashboardConfig.timezone,
  dashboardConfig.tags,
  createPanelGrid()
)