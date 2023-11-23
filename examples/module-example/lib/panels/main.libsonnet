// Imports
local commonPanel = import 'common.libsonnet';
local cpuPanel = import 'cpu.libsonnet';
local memoryPanel = import 'memory.libsonnet';

{
  common: commonPanel,
  cpu: cpuPanel,
  memory: memoryPanel,
}