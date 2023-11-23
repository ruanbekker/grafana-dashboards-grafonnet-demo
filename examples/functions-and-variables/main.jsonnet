local g = import 'g.libsonnet';

local dashboard = g.dashboard;
local row = g.panel.row;
local util = g.util;

local panels    = import './panels.libsonnet';
local variables = import './variables.libsonnet';
local queries   = import './queries.libsonnet';

// Custom variables
local dashboard_name = 'My Dashboard';
local dashboard_uid = 'my-dashboard';
local dashboard_description = 'Dashboard generated with jsonnet';
local dashboard_timezone = 'browser';
local dashboard_tags = ['Basic', 'Jsonnet'];

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
  dashboard.new(name)
  + dashboard.withUid(uid)
  + dashboard.withDescription(description)
  + dashboard.withTags(tags)
  + dashboard.withTimezone(timezone)
  + dashboard.graphTooltip.withSharedCrosshair()
  + dashboard.withVariables([
    variables.datasource,
    variables.job,
  ])
  + dashboard.withPanels(panelGrid);

// Function to create a panel grid
local createPanelGrid() =
  util.grid.makeGrid([
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
  ], panelWidth=24);

// Generates the dashboard
createDashboard(
  dashboardConfig.name,
  dashboardConfig.uid,
  dashboardConfig.description,
  dashboardConfig.timezone,
  dashboardConfig.tags,
  createPanelGrid()
)