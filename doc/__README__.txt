Netx 90 MPW Disable redundancy pages

This is a HBoot snippet for the netX 90 MPW that disables the redundancy pages on all three internal flash units.

Building
=========
Open a shell in the top directory and run the command 
python mbs/mbs

This creates a directory hierarchy containing the snippet under 
targets/snippets


Testing
=========
Requires a netx 90 hardware with JTAG port and NXJTAG-USB.

We first build a boot image including the snippet.

Open "test\build_bootimage.bat" in an editor and make sure that PATH_GCC points to an installation of GCC 4.7.2 or similar.

Open a shell in the test directory and run the command 
build_bootimage.bat 
This creates the boot image
hboot_netx90_mpw_disable_redundandy_pages.bin

Flash the boot image into the internal flash of the netx90 hardware.
Make sure the redundancy pages are turned off. After flashing, duplicate sector 0 into the redundancy pages.

The boot image does the following:
- breakpoint (jump to a return instruction in ROM)
- execute the snippet
- breakpoint
- blinki

Now power-cycle the hardware. The blinki program should be running.

Make sure that OpenOCD>=0.10.0 is be on the path. 
Run the command
test_disable_redundancy_pages.bat

The test resets the netX 90 and shows the configuration of the redundancy pages 
- right after the reset: the redundancy pages should be disabled
- at the first breakpoint, after the ROM code has set up the redundancy pages: the redundancy pages should be enabled
- at the second breakpoint, after the snippet has been executed: the redundancy pages should be disabled