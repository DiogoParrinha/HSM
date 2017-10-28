# HSM Software

This readme explains how you can debug the software that runs on the HSM.

Steps:
1. Make sure FlashPro5 is installed, guaranteeing that the hardware drivers are also installed.
2. Install SoftConsole 4.0 from Microsemi.
3. Create a new project (you may need to search for a tutorial on how to do it, such as the document: "SoftConsole v4.0 and Libero SoC v11.7 Tutorial"
4. Import all files.
5. Build (with configuration set to Debug).
	a. You may need to set the optimization flag to -Os to consume less space)
	b. To use the FPGA's LSRAMs you need to use the linker script debug-in-microsemi-smartfusion2-esram-lsram-working2.ld available in: \HSM\CMSIS\startup_gcc
	c. More information on how this works is available here: "SmartFusion2 - Distributing and Running Code from Multiple Memory Regions"
	d. The bitstream is ready to use the LSRAMs of the FPGA fabric for extended memory, depending on the linker script.
5. Connect the board and debug.