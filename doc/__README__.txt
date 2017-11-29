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
Requirements: 
A netx 90 hardware with JTAG port and an NXJTAG-USB.
OpenOCD>=0.10.0, available from http://www.freddiechopin.info/en/download/category/4-openocd
OpenOCD must be on the PATH.
A flasher to write a boot image into the internal flash, e.g. the command line flasher >=v1.4.1
https://github.com/muhkuh-sys/org.muhkuh.tools-flasher/releases/tag/v1.4.1

First, we build a boot image that includes the snippet.

Open "test\build_bootimage.bat" in an editor and make sure that PATH_GCC points to an installation of GCC 4.7.2 or similar.

Open a shell in the test directory and run the command 
build_bootimage.bat 
This creates the boot image
hboot_netx90_mpw_disable_redundandy_pages.bin

Flash the boot image into the internal flash of the netx90 hardware.
Make sure the redundancy pages are turned off. After flashing, duplicate sector 0 into the redundancy pages.
When using the command line flasher v1.4.1, the commands are as follows:
Open a shell in the flasher directory.
lua5.1 netx90mpw_iflash.lua disable_redundancy_pages
lua5.1 cli_flash.lua -b 2 -u 0 -cs 0 <dir>\test\hboot_netx90_mpw_disable_redundandy_pages.bin
where <dir> is the directory the git repository for the snipped has been cloned to.
lua5.1 netx90mpw_iflash.lua copy_page_0

The boot image does the following:
- breakpoint (jump to a return instruction in ROM)
- execute the snippet
- breakpoint
- blinki

Now power-cycle the hardware. The blinki program should be running.

Open a shell in the test subdirectory.
Run the command
test_disable_redundancy_pages.bat

The test resets the netX 90 and shows the configuration of the redundancy pages 
- right after the reset: the redundancy pages should be disabled
- at the first breakpoint, after the ROM code has set up the redundancy pages: the redundancy pages should be enabled
- at the second breakpoint, after the snippet has been executed: the redundancy pages should be disabled