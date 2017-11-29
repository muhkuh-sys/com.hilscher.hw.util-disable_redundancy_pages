setlocal

set PATH_GCC=%USERPROFILE%\.mbs\depack\org.gnu.gcc\gcc-arm-none-eabi\gcc-arm-none-eabi-4.7.2_2
set PYTHONPATH=..\mbs\site_scons

python ..\mbs\site_scons\hboot_image_compiler ^
	-n NETX90_MPW ^
	-c %PATH_GCC%\bin\arm-none-eabi-objcopy.exe ^
	-d %PATH_GCC%\bin\arm-none-eabi-objdump.exe ^
	-r %PATH_GCC%\bin\arm-none-eabi-readelf.exe ^
	-p ..\mbs\site_scons\hboot_netx90_mpw_patch_table.xml ^
	-S ..\targets\snippets ^
	bootimage/netx90_mpw_hboot_demo.xml ^
	hboot_netx90_mpw_disable_redundandy_pages.bin 

