# SPDX-License-Identifier: GPL-2.0-or-later

proc log_info {message} {
    echo "Info : $message"
}

proc run_rtt {} {
    log_info {run RTT}
    rtt setup 0x20000000 2048 "SEGGER RTT"
    rtt start
    rtt server start 9090 0
}

lappend post_init_commands {run_rtt}
