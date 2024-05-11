# WCH-link with OpenOCD instruction

![img](/docs/Screenshot_20240510_150229.png)

* This instruction testing only wtih WCH-LinkE

## Installing and connection

1. Download or build from source [OpenOcd](https://github.com/openocd-org/openocd).
I preferred to use the prebuilt binary from this [repo](https://github.com/xpack-dev-tools/openocd-xpack).

1. Add to sys env PATH path to some_path/xpack-openocd-0.12.0-3/bin/

1. Check openocd working

    ```bash
    openocd --help
    ```

    ![result](/docs/Screenshot_20240510_151836.png)

1. Create in PATH_TO/xpack-openocd-VERSION/openocd/scripts

1. Next, need .cfg file for adapter and target.
The target .cfg file more likely already exists in directory  openocd/scripts/target.
For a WCH link compatible with cms-dap.cfg, but I modify it a little. Check it: [wch-cmsis-dap.cfg](/interface/wch-cmsis-dap.cfg). I recommend copying this file to the openocd_root/openocd/scripts/interface folder.
Next, we try to connect to target using SWD transport and target, in my case this is stm32f4.

    ```bash
    openocd -f "interface/wch-cmsis-dap.cfg" -f "target/stm32f4x.cfg"
    ```

    ![connection_result](/docs/Screenshot_20240511_113043.png)

## Manual working

For testing some scripts and etc may be helpfull manual working with adapter.

* A telnet connection must be established to send a [command](https://openocd.org/doc/html/General-Commands.html)to the adapter. By default this is port 4444.
After connecting the adapter to the target, run the script below:

```bash
telnet localhost 4444
```

After then, you may send [command](https://openocd.org/doc/html/General-Commands.html) to the adapter.

![example](/docs/gif/Kooha-2024-05-11-11-47-20.gif)

* If using degub output with RTT, need to find, start and connect to RTT server.
Run commands below from the telnet connection. Check [15.6 Real Time Transfer (RTT)](https://openocd.org/doc/html/General-Commands.html).

```bash
rtt setup 0x20000000 2048 "SEGGER RTT"
rtt start
rtt server start 9090 0
```

![example](/docs/gif/Kooha-2024-05-11-11-54-19.gif)

I was created to specify a script for these commands and run it when connected.
Check the file [rtt.tcl](/debug/rtt.tcl).

* GDB connection uses port 3333 by default.

## Visual Studio Code integration

I'm using the CMake build system and I get some variables from it.
For debugging need plugin [cortex-debug)](https://github.com/Marus/cortex-debug).
Check [launch.json](/vscode/launch.json).

![example](/docs/gif/Kooha-2024-05-11-12-08-27.gif)

For flashing, I wrote a special task in [tasks.json](/vscode/tasks.json).

![example](/docs/gif/Kooha-2024-05-11-12-14-34.gif)
