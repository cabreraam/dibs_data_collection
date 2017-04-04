// This should be included any time you want to profile a program with
// perf_event_open


#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>
#include <string.h>
#include <stdio.h>

typedef struct perf_event_attr perf_event_attr;
typedef unsigned int u32;
typedef unsigned long int u64;

long
perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
  int cpu, int group_fd, unsigned long flags);

int
perf_event_create(struct perf_event_attr* pe, unsigned int perf_type, 
  size_t perf_size, unsigned long int perf_config, 
  unsigned int start_ctr_disabled, unsigned int exclude_kernel, 
  unsigned int exclude_hv);
  
