# 概述
iperf-test.sh 脚本是一个基于 iperf 的网络测速工具，使用 iperf 默认的配置进行测试，同时列出多次测试的统计信息

# 依赖
iperf
bc

# 使用方法
修改 iperf-test.sh 脚本中的 IP 为目标 IP(目标 IP 设备需要使用 iperf -s 先启动 iperf 的服务端)，并按需修改 TIMES 为所需测试次数，修改 TIME 为每次测试时长，单位为秒，修改 SCALE 为所需保留的小数点数。

修改好之后直接执行脚本

