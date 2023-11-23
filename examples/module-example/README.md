# module example

## Directory Structure

```bash
├── dashboards
│   └── example.jsonnet
├── jsonnetfile.json
└── lib
    ├── g.libsonnet
    ├── panels
    │   ├── common.libsonnet
    │   ├── cpu.libsonnet
    │   ├── main.libsonnet
    │   └── memory.libsonnet
    ├── queries
    │   ├── basic_queries.libsonnet
    │   ├── cpu_queries.libsonnet
    │   ├── main.libsonnet
    │   └── memory_queries.libsonnet
    └── variables
        ├── dashboard_variables.libsonnet
        └── main.libsonnet
```

## Usage

Define the variables for your dashboard in `dashboards/example.jsonnet` :

```libsonnet
// Custom variables
local dashboard_name = 'My Custom Dashboard';
local dashboard_uid = 'my-custom-dashboard';
local dashboard_description = 'Dashboard generated with jsonnet';
local dashboard_timezone = 'browser';
local dashboard_tags = ['custom-service', 'demo'];
```

Install the dependencies:

```bash
jb install
```

Generate the dashboard:

```bash
jsonnet -J ./vendor dashboards/example.jsonnet -o dashboard.json
```