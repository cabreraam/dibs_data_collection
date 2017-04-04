#include "perf_routines.h"

long
perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
  int group_fd, unsigned long flags)
{

  int ret;

  ret = syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);

  return ret;
}

int
perf_event_create(struct perf_event_attr* pe, unsigned int perf_type, 
 size_t perf_size, unsigned long int perf_config, 
 unsigned int start_ctr_disabled, unsigned int exclude_kernel, 
 unsigned int exclude_hv) {
  memset(pe, 0, perf_size);
  pe->type = perf_type;
  pe->size = perf_size;
  pe->config = perf_config;
  pe->disabled = start_ctr_disabled;
  pe->exclude_kernel = exclude_kernel;
  pe->exclude_hv = exclude_hv;

  return 0;
}

