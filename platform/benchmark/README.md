## 测试结果说明

`AS_2.txt`

```
cleanup.sh	1.70	0.68	0:06.51	36%

folder_setup.sh	0.09	0.06	0:00.14	106%

dns_config.sh	0.09	0.02	0:00.11	105%

vpn_config.sh	0.67	0.08	0:00.75	100%

goto_scripts.sh	0.12	0.04	0:00.14	115%

save_configs.sh	0.12	0.03	0:00.12	123%

container_setup.sh	4.27	0.96	0:49.31	10%
```


| 位置 | format | 说明                                                         |
| ---- | ------ | ------------------------------------------------------------ |
| 1    |        | 表头，执行的脚本名字                                         |
| 2    | %e     | (Not in tcsh(1).)  Elapsed real time (in seconds).           |
| 3    | %U     | Total number of CPU-seconds that the process spent in user mode. |
| 4    | %S     | Total number of CPU-seconds that the process spent in kernel mode. |
| 5    | %P     | Percentage of the CPU that this job got, computed as (%U + %S) / %E. |

