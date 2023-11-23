local datasourceName = 'prometheus';

// Defines variables associated to dashboards
{
  datasource: {
    name: 'datasource',
    type: 'datasource',
    query: datasourceName,
    current: {
      text: 'Prometheus',
      value: 'prometheus',
    },
  },

  job: {
    name: 'job',
    type: 'query',
    datasource: '${datasource}',
    refresh: 1,
    query: 'label_values(up, job)',
  },

  lastSixHours: {
    time: {
      from: 'now-6h',
      to: 'now',
    },
  },
  
}
