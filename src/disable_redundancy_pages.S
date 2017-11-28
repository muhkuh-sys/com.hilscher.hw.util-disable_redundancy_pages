
#define Addr_NX90_iflash_cfg0_com                0xFF001C00
#define Addr_NX90_iflash_cfg1_com                0xFF001C80
#define Addr_NX90_iflash_cfg2                    0xFF401400

#define REL_Adr_NX90_iflash_reset                0x00000030
#define DFLT_VAL_NX90_iflash_reset               0x00000000
#define MSK_NX90_iflash_reset_reset              0x00000001

#define REL_Adr_NX90_iflash_red_cfg0             0x00000034
#define DFLT_VAL_NX90_iflash_red_cfg0            0x00000001

#define REL_Adr_NX90_iflash_red_cfg1             0x00000038
#define DFLT_VAL_NX90_iflash_red_cfg1            0x00000001

	.text
	.syntax unified
	.thumb
	.global start
	.thumb_func
start:
	ldr r0, =Addr_NX90_iflash_cfg0_com
	ldr r1, =Addr_NX90_iflash_cfg1_com
	ldr r2, =Addr_NX90_iflash_cfg2
	ldr r3, =DFLT_VAL_NX90_iflash_red_cfg0
	str r3, [r0, #REL_Adr_NX90_iflash_red_cfg0]
	str r3, [r1, #REL_Adr_NX90_iflash_red_cfg0]
	str r3, [r2, #REL_Adr_NX90_iflash_red_cfg0]
	ldr r3, =DFLT_VAL_NX90_iflash_red_cfg1
	str r3, [r0, #REL_Adr_NX90_iflash_red_cfg1]
	str r3, [r1, #REL_Adr_NX90_iflash_red_cfg1]
	str r3, [r2, #REL_Adr_NX90_iflash_red_cfg1]
	dsb
	isb
	ldr r3, =MSK_NX90_iflash_reset_reset
	str r3, [r0, #REL_Adr_NX90_iflash_reset]
	str r3, [r1, #REL_Adr_NX90_iflash_reset]
	str r3, [r2, #REL_Adr_NX90_iflash_reset]
	ldr r3, =DFLT_VAL_NX90_iflash_reset
	str r3, [r0, #REL_Adr_NX90_iflash_reset]
	str r3, [r1, #REL_Adr_NX90_iflash_reset]
	str r3, [r2, #REL_Adr_NX90_iflash_reset]
	dsb
	isb
	bx lr

	.end

