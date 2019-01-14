#include "/mnt/Lucifer/yanzi/Android/nexmon/buildtools/b43/debug/include/spr.inc"
#include "/mnt/Lucifer/yanzi/Android/nexmon/buildtools/b43/debug/include/shm.inc"
#include "/mnt/Lucifer/yanzi/Android/nexmon/buildtools/b43/debug/include/cond.inc"
#include "../include/macros.inc"
#define phy_reg_read_to_shm(addr,target) \
 mov addr, r33 \
 calls L52 \
 or SPR_Ext_IHR_Data, 0x0, [target]
#define phy_reg_write(addr,value) \
 mov addr, r33 \
 mov value, r34 \
 calls L54
#define RX_HDR_LEN 32
#define RX_HDR_BASE 0x8c0
#define RX_HDR_OFFSET(off) (RX_HDR_BASE + off)
#define RX_HDR_RxFrameSize RX_HDR_OFFSET(0)
#define RX_HDR_NexmonExt RX_HDR_OFFSET(1)
#define RX_HDR_PhyRxStatus_0 RX_HDR_OFFSET(2)
#define RX_HDR_PhyRxStatus_1 RX_HDR_OFFSET(3)
#define RX_HDR_PhyRxStatus_2 RX_HDR_OFFSET(4)
#define RX_HDR_PhyRxStatus_3 RX_HDR_OFFSET(5)
#define RX_HDR_PhyRxStatus_4 RX_HDR_OFFSET(6)
#define RX_HDR_PhyRxStatus_5 RX_HDR_OFFSET(7)
#define RX_HDR_RxStatus1 RX_HDR_OFFSET(8)
#define RX_HDR_RxStatus2 RX_HDR_OFFSET(9)
#define RX_HDR_RxTSFTime RX_HDR_OFFSET(10)
#define RX_HDR_RxChan RX_HDR_OFFSET(11)
#define RX_HDR_NEXMON_SrcMac0 RX_HDR_OFFSET(12)
#define RX_HDR_NEXMON_SrcMac1 RX_HDR_OFFSET(13)
#define RX_HDR_NEXMON_SrcMac2 RX_HDR_OFFSET(14)
#define SHM_CSI_COLLECT 0x8b0
#define SHM_CSI_COPIED 0x8b1
#define CMP_FRM_CTRL_FLD 0x8b2
#define CMP_DURATION 0x8b3
#define CMP_DST_MAC_0 0x8b4
#define CMP_DST_MAC_1 0x8b5
#define CMP_DST_MAC_2 0x8b6
#define CMP_DST_MAC_SAVE_0 0x8b7
#define CMP_DST_MAC_SAVE_1 0x8b8
#define CMP_DST_MAC_SAVE_2 0x8b9
#define COUNTER 0x8ba
%arch 15
%start entry
entry:
 mov 0x0, SPR_GPIO_OUT
 jmp L791
L0:
 jnzx 0, 1, SPR_PHY_HDR_Parameter, 0x0, L1
 jmp L888
L1:
 jext COND_PSM(0), L3
 jext 0x4C, L3
 jnzx 0, 4, r20, 0x0, L3
 jnzx 0, 10, r43, 0x0, L3
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L2
 jext COND_PSM(0), L3
 jnzx 0, 3, r46, 0x0, L3
 jnzx 0, 5, r44, 0x0, L3
 jnzx 0, 3, r45, 0x0, L3
 jnzx 0, 8, r44, 0x0, L3
L2:
 jnzx 0, 9, [SHM_HOST_FLAGS2], 0x0, L3
 mov 0xFFFF, SPR_MAC_MAX_NAP
 mov 0x7360, SPR_BRWK0
 mov 0x1, SPR_BRWK1
 mov 0x730F, SPR_BRWK2
 mov 0xE57, SPR_BRWK3
 nap
L3:
 mov 0x0, SPR_MAC_MAX_NAP
 jnext EOI(COND_PHY6), L4
L4:
 jzx 0, 10, SPR_IFS_0x32, 0x0, L5
 or SPR_TSF_WORD0, 0x0, [0xC1D]
L5:
 nap2
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L33
 jzx 0, 8, r63, 0x0, L6
 jdn SPR_TSF_WORD0, [0xAEE], L6
 orx 0, 8, 0x0, r63, r63
 mov 0x0, [0xAE0]
L6:
 calls L991
 jzx 0, 5, r63, 0x0, L7
 jdn SPR_TSF_WORD0, [0xAE3], L7
 orx 0, 5, 0x0, r63, r63
 jmp L385
L7:
 je [0xB0D], 0x0, L8
 jnzx 0, 1, r63, 0x0, L33
 jdn SPR_TSF_WORD0, [0xB0D], L33
 orx 0, 9, 0x1, r43, r43
 calls L1113
L8:
 jzx 0, 9, [SHM_HOST_FLAGS3], 0x0, L9
 jnzx 0, 3, [SHM_HOST_FLAGS3], 0x0, L10
L9:
 orx 0, 0, 0x0, r63, r63
 mov 0x0, [0xB14]
L10:
 sr [0xB32], 0x6, r34
 add [0xB31], r34, r35
 jl SPR_TSF_WORD1, r35, L11
 or [0xB2F], 0x0, [0xB2A]
L11:
 orx 0, 14, 0x0, r63, r63
 je [0xB29], 0x0, L12
 sub. SPR_TSF_WORD0, [0xB29], r35
 subc SPR_TSF_WORD1, [0xB2D], r34
 jne r34, 0x0, L12
 jge r35, [0xB2A], L12
 orx 0, 14, 0x1, r63, r63
L12:
 jzx 0, 15, r63, 0x0, L13
 sub SPR_TSF_WORD0, [0xB0B], r34
 jl r34, [0xB0A], L13
 orx 0, 15, 0x0, r63, r63
 mov 0x0, [0xB0B]
L13:
 je [0xAF3], 0x0, L16
 sub SPR_TSF_WORD0, [0xAF3], r33
 jge r33, [0xAEC], L14
 je [0xB02], 0x0, L16
 sub SPR_TSF_WORD0, [0xB02], r33
 jge r33, [0xAEC], L15
 jmp L16
L14:
 mov 0x0, [0xAF4]
 mov 0x0, [0xAF3]
L15:
 mov 0x0, [0xB02]
 mov 0x0, [0xAFA]
L16:
 jzx 0, 5, r44, 0x0, L17
 jzx 0, 0, SPR_TXE0_CTL, 0x0, L17
 calls L727
L17:
 jnzx 0, 8, r44, 0x0, L33
 jne [0xAF5], 0x0, L33
 jnzx 0, 4, r45, 0x0, L18
 jzx 0, 3, [SHM_HOST_FLAGS3], 0x0, L23
L18:
 or [0xAE4], 0x0, r34
 jnzx 0, 0, [0xB2E], 0x0, L19
 or [0xAFA], 0x0, r33
 jge r33, [0xB19], L31
 je r33, 0x0, L19
 je [0xB33], 0x0, L19
 or [0xB33], 0x0, r34
L19:
 je [0xAF4], 0x0, L20
 sub SPR_TSF_WORD0, [0xAF4], r33
 jge r33, r34, L31
 add r33, [0xAE1], r33
 jge r33, r34, L31
L20:
 jzx 0, 3, r46, 0x0, L23
 je [0xAE0], 0x0, L23
 sub SPR_TSF_WORD0, [0xAE8], r33
 add [0xAE0], 0xA, r34
 jle r33, r34, L21
 orx 0, 3, 0x0, r46, r46
 mov 0x0, [0xB24]
 mov 0x0, [0xAE0]
 jmp L23
L21:
 sub [0xAE0], r33, r33
 sr [0xAE0], 0x1, r34
 jg [0xAE1], r34, L22
 or [0xAE1], 0x0, r34
L22:
 jges r33, r34, L23
 jmp L31
L23:
 jnzx 0, 4, r45, 0x0, L30
 jnzx 1, 1, [SHM_HOST_FLAGS5], 0x0, L29
 jzx 0, 3, r45, 0x0, L33
 jzx 0, 9, [SHM_HOST_FLAGS3], 0x0, L24
 jzx 0, 0, r63, 0x0, L29
L24:
 jnzx 0, 1, [SHM_HOST_FLAGS1], 0x0, L29
 je [0xB02], 0x0, L25
 jnzx 0, 0, [0xB2E], 0x0, L25
 or [0xB04], 0x0, r59
 jg [0xAFA], r59, L33
 jmp L29
L25:
 jzx 0, 6, r45, 0x0, L26
 je [0xAF7], 0x43, L33
 jmp L29
L26:
 jnzx 0, 8, [SHM_HOST_FLAGS3], 0x0, L27
 jnzx 0, 12, [SHM_HOST_FLAGS3], 0x0, L28
L27:
 je [0xAF4], 0x0, L29
 jnzx 0, 2, [0xB43], 0x0, L29
L28:
 sub SPR_TSF_WORD0, [0xAEB], r33
 sub SPR_BTCX_RFACT_DUR_Timer, [0xB11], r34
 sub r33, r34, r33
 jges r33, [0xAF2], L29
 jdnz SPR_TSF_WORD0, [0xAED], L33
 jnzx 0, 5, r45, 0x0, L33
L29:
 calls L1120
 jmp L33
L30:
 je SPR_BTCX_CUR_RFACT_Timer, 0xFFFF, L29
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L31
 jnzx 0, 5, r45, 0x0, L31
 jzx 0, 2, [SHM_HOST_FLAGS3], 0x0, L33
 jdn SPR_TSF_WORD0, [0xAEE], L33
 jnand 0xFF, SPR_AQM_FIFO_Ready, L33
 jnzx 0, 3, r46, 0x0, L33
L31:
 jnzx 1, 1, [SHM_HOST_FLAGS5], 0x0, L33
 jnzx 0, 5, r44, 0x0, L33
 jnzx 0, 1, [SHM_HOST_FLAGS1], 0x0, L33
 jnzx 0, 9, r43, 0x0, L33
 jnzx 0, 2, r46, 0x0, L33
 jext COND_NEED_RESPONSEFR, L32
 jzx 0, 0, SPR_TXE0_CTL, 0x0, L32
 calls L727
L32:
 orx 0, 7, 0x1, [0xB42], [0xB42]
 orx 0, 3, 0x0, r45, r45
 orx 0, 9, 0x1, r43, r43
 mov 0x0, [0xAF5]
 or SPR_TSF_WORD0, 0x0, [0xAF6]
L33:
 orx 0, 0, 0x0, SPR_PSM_COND, SPR_PSM_COND
 jnext EOI(COND_RADAR), L34
 orx 0, 0, 0x0, r45, r45
L34:
 jext EOI(COND_PHY0), L35
L35:
 jext EOI(COND_PHY1), L36
L36:
 mov 0x6000, SPR_TSF_GPT0_VALLO
 or [SHM_DEFAULTIV], 0x0, SPR_TSF_GPT0_VALHI
 mov 0xC000, SPR_TSF_GPT0_STAT
 jnext COND_MACEN, L708
 jext COND_TX_FLUSH, L732
L37:
 jext EOI(COND_TX_NOW), L218
 jext EOI(COND_TX_POWER), L352
 jext EOI(COND_TX_UNDERFLOW), L689
 jext COND_TX_DONE, L373
 jext COND_TX_PHYERR, L688
L38:
 jnzx 1, 1, SPR_BRWK0, 0x0, L50
L39:
 jext EOI(COND_RX_WME8), L466
L40:
 jext EOI(COND_RX_PLCP), L478
 jext 0x39, L572
 jext COND_PSM(3), L499
 jext COND_RX_FIFOFULL, L703
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L703
 jext COND_RX_COMPLETE, L572
 jext COND_TX_PMQ, L401
 jext EOI(COND_RX_BADPLCP), L716
 calls L990
 jext COND_4_C7, L0
 jext EOI(0x10), L338
 jzx 0, 12, r44, 0x0, L42
 jzx 0, 2, SPR_IFS_STAT, 0x0, L42
L41:
 orx 0, 12, 0x0, r44, r44
 calls L348
L42:
 jext COND_TX_NAV, L437
L43:
 calls L818
 calls L942
 jzx 3, 0, [0xBF7], 0x0, L44
 calls L945
L44:
 jzx 0, 13, [SHM_HOST_FLAGS1], 0x0, L45
 jzx 0, 2, SPR_IFS_STAT, 0x0, L45
 jdn SPR_TSF_WORD0, [0xBFE], L45
 mov 0x256, r33
 or [SHM_RADAR], 0x0, r34
 calls L54
L45:
 jext COND_4_C4, L48
 jnext EOI(COND_TX_TBTTEXPIRE), L47
 orx 0, 12, 0x1, SPR_BRC, SPR_BRC
 jnext 0x3E, L47
 jgs r8, 0x0, L46
 or [SHM_DTIMP], 0x0, r8
L46:
 sub r8, 0x1, r8
L47:
 jext 0x4C, L83
 calls L975
 js 0x3, SPR_MAC_CMD, L89
L48:
 jext EOI(COND_RX_ATIMWINEND), L749
 jnand SPR_TXE0_CTL, 0x1, L92
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L49
 jnext EOI(0x34), L49
 orx 1, 4, 0x0, SPR_PHY_HDR_Parameter, SPR_PHY_HDR_Parameter
 mov 0x20, SPR_MAC_CMD
L49:
 je [0x3CA], 0x0, L131
 calls L1158
 jmp L131
L50:
 jext COND_RX_IFS2, L51
 jnext COND_RX_IFS1, L39
L51:
 orx 1, 1, 0x0, SPR_BRWK0, SPR_BRWK0
 jmp L217
L52:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L52
 orx 1, 13, 0x3, r33, SPR_Ext_IHR_Address
L53:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L53
 rets
L54:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L54
 or r34, 0x0, SPR_Ext_IHR_Data
 orx 1, 13, 0x2, r33, SPR_Ext_IHR_Address
 rets
L55:
 mov 0x1800, SPR_PSM_0x76
 mov 0x600, SPR_PSM_0x74
 orx 5, 8, 0x2F, r35, SPR_PSM_0x6a
L56:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L56
 rets
 mov 0x1800, SPR_PSM_0x76
 mov 0x600, SPR_PSM_0x74
 orx 5, 8, 0x1F, r35, SPR_PSM_0x6a
L57:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L57
 rets
L58:
 mov 0x14, [0x006]
 jnzx 0, 1, r1, 0x0, L59
 orx 11, 4, 0x0, r0, r0
 jzx 1, 0, r1, 0x0, L66
 mov 0xF0, r33
 add r0, r33, SPR_BASE5
 mov 0xE0, r33
 add r0, r33, SPR_BASE4
 mov 0x1, [0x86B]
 jmp L67
L59:
 srx 2, 0, r0, 0x0, r33
 jzx 0, 0, r1, 0x0, L60
 srx 3, 0, r0, 0x0, r33
L60:
 sl r33, 0x1, r34
 add r33, r34, r33
 add [0x056], r33, SPR_BASE3
 jnzx 0, 12, [SHM_HOST_FLAGS2], 0x0, L61
 or [0x02,off3], 0x0, SPR_BASE2
 or [0x00,off2], 0x0, SPR_BASE2
 mov 0x1, [0x86B]
 jmp L68
L61:
 or SPR_BASE3, 0x0, SPR_BASE2
 jnzx 0, 0, r1, 0x0, L62
 srx 1, 3, r0, 0x0, r33
 jmp L64
L62:
 mov 0x571, r34
 jle SPR_BASE2, r34, L63
 or r34, 0x0, SPR_BASE2
L63:
 mov 0x0, r33
L64:
 jne r33, 0x2, L65
 add r33, 0x1, r33
L65:
 sl r33, 0x2, r33
 add r33, [0x874], r33
 add r33, 0x1E, [0x006]
 mov 0x2, [0x86B]
 jmp L68
L66:
 mov 0x110, r33
 add r0, r33, SPR_BASE5
 mov 0x100, r33
 add r0, r33, SPR_BASE4
 mov 0xC0, [0x006]
 mov 0x0, [0x86B]
L67:
 or [0x00,off5], 0x0, SPR_BASE2
 or [0x00,off4], 0x0, SPR_BASE3
L68:
 rets
L69:
 orx 1, 1, SPR_TXE0_PHY_CTL, 0x0, SPR_TDCCTL
 jzx 0, 4, SPR_TXE0_PHY_CTL, 0x0, L70
 orx 0, 3, 0x1, SPR_TDCCTL, SPR_TDCCTL
L70:
 or [0x03,off6], 0x0, SPR_TDC_PLCP0
 or [0x04,off6], 0x0, SPR_TDC_PLCP1
 sub SPR_AQM_Agg_Len_Low, 0x4, SPR_TDC_Frame_Length0
 jzx 0, 2, [0x0A,off0], 0x0, L71
 or SPR_AQM_Agg_Len_Low, 0x0, SPR_TDC_Frame_Length0
 or SPR_AQM_Agg_Len_High, 0x0, SPR_TDC_Frame_Length1
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L71
 or [0x05,off6], 0x0, SPR_TDC_Frame_Length1
L71:
 jzx 0, 6, SPR_TXE0_PHY_CTL2, 0x0, L73
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L72
 orx 1, 12, 0x1, [0x04,off6], SPR_TDC_PLCP1
 jmp L73
L72:
 orx 0, 3, 0x1, [0x03,off6], r33
 orx 2, 10, 0x1, r33, SPR_TDC_PLCP0
L73:
 orx 0, 0, 0x1, SPR_TDCCTL, SPR_TDCCTL
 rets
L74:
 sub SPR_RXE_FRAMELEN, 0x4, r33
 or SPR_RXE_Copy_Length, 0x0, r35
 jl r33, r35, L75
 sr r35, 0x1, r35
 jmp L76
L75:
 sr r33, 0x1, r35
L76:
 mov 0x7E5, r33
 add r35, r33, r35
L77:
 orx 14, 0, SPR_BASE5, 0x0, r33
 jge r33, r35, L81
 jnzx 0, 15, SPR_BASE5, 0x0, L78
 srx 7, 0, [0x00,off5], 0x0, r33
 srx 7, 8, [0x00,off5], 0x0, r34
 jmp L79
L78:
 srx 7, 8, [0x00,off5], 0x0, r33
 srx 7, 0, [0x01,off5], 0x0, r34
L79:
 je r33, r36, L80
 rr r34, 0x1, r34
 add. SPR_BASE5, r34, SPR_BASE5
 or SPR_BASE5, 0x0, 0x0
 addc. SPR_BASE5, 0x1, SPR_BASE5
 jmp L77
L80:
 rr r34, 0x1, r34
 add. SPR_BASE5, r34, r33
 addc. r33, 0x1, r33
 orx 14, 0, r33, 0x0, r33
 jle r33, r35, L82
L81:
 mov 0xFFFF, r36
L82:
 rets
L83:
 jnand 0xE3, SPR_BRC, L0
 jnext 0x3D, L85
 jext 0x3E, L85
L84:
 mov 0x1008, r33
 nand SPR_BRC, r33, SPR_BRC
 jmp L0
L85:
 jnzx 0, 0, r45, 0x0, L3
 jzx 1, 0, SPR_MAC_CMD, 0x0, L84
 calls L727
 or [0x066], 0x0, SPR_TXE0_PHY_CTL
 or [0x067], 0x0, SPR_TXE0_PHY_CTL1
 or [0x068], 0x0, SPR_TXE0_PHY_CTL2
 mov 0x20, r18
 mov 0x24, SPR_TXE0_TS_LOC
 or [SHM_BTSFOFF], 0x0, SPR_TSF_0x3a
 orx 2, 0, 0x1, SPR_BRC, SPR_BRC
 jext 0x43, L87
 orx 0, 3, 0x1, SPR_BRC, SPR_BRC
 mov 0x4, SPR_MAC_IRQLO
 mov 0x0, SPR_TSF_RANDOM
 jext 0x3D, L88
 orx 0, 8, 0x0, r20, r20
 or SPR_IFS_BKOFFTIME, 0x0, r15
 or r5, 0x0, r16
 jzx 0, 0, SPR_TSF_0x0e, 0x0, L86
 orx 0, 10, 0x0, SPR_BRC, SPR_BRC
 orx 0, 2, 0x1, 0x0, SPR_MAC_CMD
L86:
 orx 14, 1, r3, 0x1, r33
 and SPR_TSF_RANDOM, r33, SPR_IFS_BKOFFTIME
L87:
 jext 0x3D, L88
 mov 0x4D95, SPR_TXE0_CTL
 jmp L0
L88:
 and SPR_TSF_RANDOM, [0x151], SPR_IFS_BKOFFTIME
 mov 0x4993, SPR_TXE0_CTL
 jmp L0
L89:
 jnand 0x20, SPR_BRC, L0
 srx 1, 9, r20, 0x0, r33
 orx 1, 0, r33, 0x0, SPR_MAC_CMD
 mov 0x2, SPR_MAC_IRQLO
 srx 1, 0, SPR_MAC_CMD, 0x0, r33
 orx 1, 9, r33, r20, r20
 jmp L0
 rets
L90:
 mov 0x3, r35
 jnzx 0, 1, r20, 0x0, L91
 mov 0x0, r35
L91:
 mov 0x1720, r33
 calls L52
 orx 1, 0, r35, SPR_Ext_IHR_Data, r34
 calls L54
 mov 0x173E, r33
 calls L52
 orx 0, 12, r35, SPR_Ext_IHR_Data, r34
 orx 1, 4, 0x0, r34, r34
 calls L54
 rets
L92:
 jnand 0x1F, SPR_BRC, L0
 calls L978
 jnzx 0, 7, SPR_TXE0_STATUS, 0x0, L0
 jzx 0, 5, [SHM_HOST_FLAGS4], 0x0, L94
 or SPR_TSF_WORD0, 0x0, r33
 srx 15, 8, r33, SPR_TSF_WORD1, r35
 jnzx 0, 6, r63, 0x0, L93
 add [0x03E], r35, [0x876]
 orx 0, 6, 0x1, r63, r63
L93:
 jdpz r35, [0x876], L95
L94:
 jzx 0, 12, [0x01,off0], 0x0, L96
 srx 7, 8, SPR_TSF_WORD0, 0x0, r33
 orx 7, 8, SPR_TSF_WORD1, r33, r33
 jdnz r33, [0x08,off0], L96
L95:
 calls L727
 orx 3, 4, 0x5, [0x09,off0], [0x09,off0]
 add [0x876], 0x4, [0x876]
 jmp L207
L96:
 calls L208
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L97
 jext 0x28, L0
 jnand SPR_AQM_FIFO_Ready, 0x10, L0
 and SPR_AQM_FIFO_Ready, 0xF, r0
 je r0, [0x16E], L0
 calls L727
 jmp L3
L97:
 jzx 0, 3, SPR_AQM_FIFO_Ready, 0x0, L0
 je [SHM_TXFCUR], 0x3, L0
 calls L727
 mov 0x3, [SHM_TXFCUR]
 calls L98
 jmp L3
L98:
 or [SHM_TXFCUR], 0x0, SPR_TXE0_SELECT
 orx 3, 0, [SHM_TXFCUR], 0x0, SPR_TXE0_FIFO_PRI_RDY
 mov 0x584, r33
 mul [SHM_TXFCUR], 0x20, 0x0
 add r33, SPR_PSM_0x5a, SPR_BASE0
 jnzx 0, 0, [0x0A,off0], 0x0, L103
 mov 0x0, r50
 sl SPR_BASE0, 0x1, SPR_TXE0_AGGFIFO_CMD
 mov 0x14, SPR_TXE0_FIFO_Write_Pointer
 orx 8, 7, 0x102, r50, SPR_TXE0_FIFO_Head
L99:
 jnext COND_TX_BUSY, L99
L100:
 jext COND_TX_BUSY, L100
 orx 0, 0, 0x1, [0x0A,off0], [0x0A,off0]
 jne [0x0D,off0], 0x0, L101
 jne [0x0E,off0], 0x0, L101
 or SPR_TSF_WORD0, 0x0, [0x0D,off0]
 or SPR_TSF_WORD1, 0x0, [0x0E,off0]
L101:
 or [SHM_SFFBLIM], 0x0, [0x1C,off0]
 jzx 0, 8, [0x01,off0], 0x0, L102
 or [SHM_LFFBLIM], 0x0, [0x1C,off0]
L102:
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L103
 jg [SHM_TXFCUR], 0x3, L103
 add 0x180, [SHM_TXFCUR], SPR_BASE5
 srx 3, 4, [0x00,off5], 0x0, [0x1C,off0]
 jzx 0, 8, [0x01,off0], 0x0, L103
 srx 3, 12, [0x00,off5], 0x0, [0x1C,off0]
L103:
 rets
L104:
 srx 7, 0, [0x04,off0], 0x0, SPR_WEP_IV_Key
 add SPR_WEP_IV_Key, 0x8, r35
 sub [0x05,off0], 0x4, r34
 jle r35, r34, L105
 or r34, 0x0, r35
L105:
 srx 3, 2, [0x01,off0], 0x0, [0x680]
 srx 7, 8, [0x04,off0], 0x0, r34
 mov 0x7C, [0x1E,off0]
 jzx 0, 0, [0x01,off0], 0x0, L107
 mov 0x14, [0x1E,off0]
 calls L121
 mov 0x3, SPR_SHMDMA_Control
L106:
 jnzx 0, 0, SPR_SHMDMA_Control, 0x0, L106
 jge r34, r35, L112
 sub r35, r34, SPR_TXE0_FIFO_Write_Pointer
 mov 0xD70, r33
 add r33, r34, SPR_TXE0_AGGFIFO_CMD
 jmp L109
L107:
 add 0x68, r35, SPR_TXE0_FIFO_Write_Pointer
 jle r34, r35, L108
 add 0x68, r34, SPR_TXE0_FIFO_Write_Pointer
L108:
 mov 0xD08, SPR_TXE0_AGGFIFO_CMD
L109:
 mov 0x14, SPR_TXE0_FIFO_Read_Pointer
 orx 8, 7, 0x103, 0x0, SPR_TXE0_FIFO_Head
L110:
 jnext COND_TX_BUSY, L110
L111:
 jext COND_TX_BUSY, L111
L112:
 mov 0xC00, SPR_BASE5
 srx 2, 4, [0x6AC], 0x0, r38
 add SPR_BASE5, r38, SPR_BASE5
 srx 7, 0, [0x00,off5], 0x0, [0x1F,off0]
 mov 0x0, r33
 jzx 0, 4, [0x02,off0], 0x0, L113
 srx 7, 8, [0x00,off5], 0x0, r33
 add r33, SPR_WEP_IV_Key, r33
 jne r38, 0x2, L113
 sr SPR_WEP_IV_Key, 0x1, r35
 mov 0x6B8, SPR_BASE5
 add SPR_BASE5, r35, SPR_BASE5
 or [0x3D6], 0x0, r35
 jne [0x02,off5], r35, L206
L113:
 jl r34, r33, L115
 jnzx 0, 0, [0x01,off0], 0x0, L114
 add [0x1E,off0], r34, [0x1E,off0]
L114:
 orx 7, 8, r34, [0x1E,off0], [0x1E,off0]
 jmp L117
L115:
 add [0x1E,off0], r33, [0x1E,off0]
 jzx 0, 0, [0x01,off0], 0x0, L116
 sub [0x1E,off0], r34, [0x1E,off0]
L116:
 orx 7, 8, r33, [0x1E,off0], [0x1E,off0]
L117:
 and [0x6B8], 0x88, r33
 jne r33, 0x88, L118
 orx 0, 13, 0x1, r20, r20
L118:
 jnzx 0, 0, [0x01,off0], 0x0, L120
 jzx 0, 1, [0x01,off0], 0x0, L119
 calls L121
 mov 0x1, SPR_SHMDMA_Control
 jmp L120
L119:
 mov 0xFFFF, [0x680]
L120:
 calls L125
 rets
L121:
 srx 3, 2, [0x01,off0], 0x0, r33
 mul r33, [SHM_ACKCTSPHYCTL], r33
 mov 0x684, SPR_SHMDMA_SHM_Address
 sr SPR_PSM_0x5a, 0x1, SPR_SHMDMA_TXDC_Address
 add r34, 0x68, r33
 add r33, 0x3, r33
 nand r33, 0x3, r33
 sr r33, 0x1, SPR_SHMDMA_Xfer_Cnt
 rets
L122:
 mov 0x31, r18
 mov 0xFFFF, SPR_TME_MASK12
 mov MAC_SUBTYPE_CONTROL_CTS, SPR_TME_VAL12
 jnzx 0, 1, [0xB43], 0x0, L123
 or [0x3C6], 0x0, SPR_TME_VAL16
 or [0x3C7], 0x0, SPR_TME_VAL18
 or [0x3C8], 0x0, SPR_TME_VAL20
 jmp L124
L123:
 or [0xB48], 0x0, SPR_TME_VAL16
 or [0xB49], 0x0, SPR_TME_VAL18
 or [0xB4A], 0x0, SPR_TME_VAL20
L124:
 rets
L125:
 mov 0x684, SPR_BASE6
 jzx 0, 1, [0x02,off0], 0x0, L126
 orx 1, 4, 0x0, [0x0B,off0], [0x0B,off0]
 jmp L129
L126:
 srx 1, 4, [0x0B,off0], 0x0, r33
 jne [0x1B,off0], 0x0, L127
 mov 0xFFFF, [0x1D,off0]
L127:
 jls [0x1D,off0], 0x0, L128
 jne r33, 0x0, L128
 jnzx 0, 5, [0x68C], 0x0, L128
 mov 0x1, r33
 orx 1, 4, 0x1, [0x0B,off0], [0x0B,off0]
L128:
 mul r33, 0xA, 0x0
 or SPR_PSM_0x5a, 0x0, r33
 add SPR_BASE6, r33, SPR_BASE6
L129:
 mov 0x4B4, SPR_BASE1
 jnzx 0, 6, [0x08,off6], 0x0, L130
 srx 2, 12, [0x68C], 0x0, r33
 sl r33, 0x4, r33
 add [SHM_EXTNPHYCTL], r33, SPR_BASE1
L130:
 or SPR_BASE1, 0x0, [0x0F,off0]
 rets
L131:
 je [0x87D], 0x0, L132
 jdnz SPR_TSF_WORD0, [0x87D], L3
 mov 0x0, [0x87D]
L132:
 je [0x87B], 0x0, L133
 jdnz SPR_TSF_WORD0, [0x87C], L3
 mov 0x0, [0x87B]
L133:
 jnand 0x2F, SPR_BRC, L0
 jext COND_TX_NOW, L3
 jnzx 0, 0, r45, 0x0, L3
 jext COND_4_C4, L137
 calls L932
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L136
 jnzx 0, 9, r43, 0x0, L134
 jzx 0, 3, r45, 0x0, L136
 calls L1100
 jzx 0, 3, r45, 0x0, L136
 jmp L0
L134:
 jzx 0, 3, r45, 0x0, L135
 jzx 0, 9, [SHM_HOST_FLAGS3], 0x0, L136
 jnzx 0, 0, r63, 0x0, L136
L135:
 calls L1087
 jmp L0
L136:
 calls L978
L137:
 jl SPR_TXE0_0x78, 0x2, L139
 or [SHM_TXFCUR], 0x0, r33
 or [SHM_TXFCUR], 0x0, r34
 jext COND_4_C4, L138
 jnext 0x28, L141
 jnzx 0, 2, SPR_IFS_STAT, 0x0, L141
 jg [SHM_TXFCUR], 0x3, L139
 mov 0x3, r34
L138:
 sl 0x1, r34, r35
 jnand SPR_AQM_FIFO_Ready, r35, L140
 sub r34, 0x1, r34
 jles r33, r34, L138
L139:
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
 jmp L0
L140:
 je r33, r34, L149
 or r34, 0x0, [SHM_TXFCUR]
 or r34, 0x0, [0x165]
 mul r34, 0x10, r33
 add 0x120, SPR_PSM_0x5a, [0x166]
 calls L965
 jmp L149
L141:
 mov 0x0, SPR_TSF_0x2a
 jext COND_4_C4, L139
 or [0x05F], 0x0, r38
 jnext 0x3E, L146
 jzx 0, 6, [SHM_HOST_FLAGS2], 0x0, L142
 jnand SPR_AQM_FIFO_Ready, 0x10, L143
L142:
 jnext 0x4A, L146
 jnand SPR_AQM_FIFO_Ready, 0x10, L143
 jne [SHM_MCASTCOOKIE], 0xFFFF, L3
 jmp L144
L143:
 mov 0x4, [SHM_TXFCUR]
 jmp L149
L144:
 jext 0x3D, L145
 jne r38, [0x05E], L145
 jzx 0, 2, SPR_MAC_CMD, 0x0, L838
L145:
 orx 0, 10, 0x0, SPR_BRC, SPR_BRC
L146:
 je r38, [0x05E], L147
 jls r39, 0x3, L151
 jzx 3, 0, SPR_AQM_FIFO_Ready, 0x0, L151
L147:
 jzx 0, 2, SPR_MAC_CMD, 0x0, L838
 jzx 3, 0, SPR_AQM_FIFO_Ready, 0x0, L838
 calls L958
 or [0x165], 0x0, [0x161]
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L148
 calls L965
L148:
 or [0x161], 0x0, [SHM_TXFCUR]
 jmp L149
L149:
 jnext COND_4_C4, L150
 jzx 0, 0, [0x0A,off0], 0x0, L150
 calls L125
 jmp L158
L150:
 calls L98
 jmp L154
L151:
 mov 0x14, r18
 or [0x05E], 0x0, SPR_BASE5
 je [SHM_PRMAXTIME], 0x0, L152
 sl [0x04,off5], 0x8, r33
 sub SPR_TSF_WORD0, r33, r33
 jle r33, [SHM_PRMAXTIME], L152
 add [0x0A6], 0x1, [0x0A6]
 jmp L436
L152:
 jg [0x86C], 0x4, L436
 orx 2, 0, 0x4, SPR_BRC, SPR_BRC
 srx 1, 0, [0x03,off5], 0x0, r1
 srx 6, 8, [0x03,off5], 0x0, r0
 calls L58
 or [0x05E], 0x0, SPR_BASE5
 or [0x00,off5], 0x0, SPR_TME_VAL16
 or [0x01,off5], 0x0, SPR_TME_VAL18
 or [0x02,off5], 0x0, SPR_TME_VAL20
 or [0x04,off3], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x05,off3], 0x0, SPR_TX_PLCP_HT_Sig1
 or [0x03,off2], 0x0, [0x681]
 orx 1, 0, r1, [SHM_TXFIFO_SIZE01], SPR_TXE0_PHY_CTL
 srx 2, 8, [SHM_CHAN], 0x0, SPR_TXE0_PHY_CTL1
 or [0x068], 0x0, SPR_TXE0_PHY_CTL2
 mov 0xC0, r33
 jge SPR_BASE3, [SHM_CCKDIRECT], L153
 mov 0x14, r33
L153:
 add r33, [0x01B], r33
 add r33, [0x00,off3], SPR_TSF_0x3a
 jmp L195
L154:
 calls L104
 jnzx 0, 3, [0x0B,off0], 0x0, L203
 calls L208
 or [0x03,off0], 0x0, r33
 jne [SHM_CHAN], r33, L155
 jmp L156
L155:
 orx 3, 4, 0x4, [0x09,off0], [0x09,off0]
 jmp L207
L156:
 or [0x07,off6], 0x0, r40
 orx 0, 6, 0x0, [0x0A,off0], [0x0A,off0]
 jzx 0, 0, [SHM_HOST_FLAGS1], 0x0, L158
 js 0x3, [0x06,off6], L158
 jnext COND_TX_NAV, L158
 add [0x07C], 0x1, [0x07C]
 orx 0, 6, 0x1, [0x0A,off0], [0x0A,off0]
 mov 0x7627, r33
 mul [0x07,off6], r33, r40
 srx 1, 0, [0x06,off6], 0x0, r36
 orx 1, 14, r36, [0x00,off6], [0x00,off6]
 srx 2, 8, [SHM_CHAN], 0x0, r33
 sr r33, r36, r33
 orx 2, 0, r33, [0x01,off6], [0x01,off6]
 js 0x3, [0x00,off6], L157
 jand 0x2, [0x00,off6], L158
 orx 0, 7, r36, [0x03,off6], [0x03,off6]
 jmp L158
L157:
 orx 1, 0, r36, [0x03,off6], [0x03,off6]
L158:
 srx 1, 0, [0x00,off6], 0x0, r1
 or [0x00,off6], 0x0, SPR_TXE0_PHY_CTL
 or [0x02,off6], 0x0, SPR_TXE0_PHY_CTL2
 or [0x00,off1], 0x0, r33
 orx 4, 10, r33, [0x01,off6], SPR_TXE0_PHY_CTL1
 srx 5, 3, [0x01,off6], 0x0, r36
 jzx 0, 6, [0x0A,off0], 0x0, L159
 srx 0, 2, [0x06,off6], 0x0, r33
 orx 0, 3, r33, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 srx 5, 3, [0x06,off6], 0x0, r36
 je r33, 0x0, L168
 srx 5, 9, [0x06,off6], 0x0, r33
 orx 5, 3, r33, SPR_TXE0_PHY_CTL1, SPR_TXE0_PHY_CTL1
 orx 5, 0, r36, [0x09,off6], [0x09,off6]
L159:
 jzx 0, 3, SPR_TXE0_PHY_CTL, 0x0, L168
 jzx 0, 6, [0x08,off6], 0x0, L160
 or [0x01,off1], 0x0, r33
 or [0x02,off1], 0x0, r34
 jne r33, [0x6BA], L161
 or [0x03,off1], 0x0, r33
 jne r34, [0x6BB], L161
 jne r33, [0x6BC], L161
L160:
 srx 1, 14, [0x00,off6], 0x0, r33
 srx 1, 12, [0x00,off1], 0x0, r34
 jle r33, r34, L162
 jnzx 0, 6, [0x08,off6], 0x0, L161
 orx 1, 4, 0x1, [0x0A,off0], [0x0A,off0]
L161:
 orx 0, 8, 0x0, [0x00,off1], [0x00,off1]
L162:
 srx 0, 8, [0x00,off1], 0x0, r33
 orx 0, 3, r33, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 je r33, 0x0, L167
 jnzx 0, 6, [0x08,off6], 0x0, L169
 mov 0x7F, r34
 jzx 0, 2, [0x05,off1], 0x0, L166
 mov 0x4A4, SPR_BASE5
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L163
 srx 2, 0, [0x02,off6], 0x0, r33
 srx 1, 3, [0x02,off6], 0x0, r35
 jzx 0, 14, [0x05,off6], 0x0, L165
 jmp L164
L163:
 srx 3, 0, [0x02,off6], 0x0, r33
 jg r33, 0x7, L166
 srx 2, 4, [0x02,off6], 0x0, r35
 jzx 0, 10, [0x04,off6], 0x0, L165
L164:
 add SPR_BASE5, 0x8, SPR_BASE5
L165:
 je r35, 0x0, L166
 add SPR_BASE5, r33, SPR_BASE5
 or [0x00,off5], 0x0, r34
L166:
 mov 0x431, r33
 calls L54
 jmp L169
L167:
 srx 5, 0, [0x09,off6], 0x0, r36
 srx 0, 6, [0x09,off6], 0x0, r33
 orx 0, 6, r33, SPR_TXE0_PHY_CTL2, SPR_TXE0_PHY_CTL2
L168:
 orx 5, 3, r36, SPR_TXE0_PHY_CTL1, SPR_TXE0_PHY_CTL1
L169:
 or [0x03,off6], 0x0, r0
 jne r1, 0x3, L170
 or [0x02,off6], 0x0, r0
L170:
 jzx 0, 14, [0x01,off0], 0x0, L177
 jext COND_4_C4, L186
 jnand [0x01,off0], 0x200, L171
 or [0x6BA], 0x0, SPR_PMQ_pat_0
 or [0x6BB], 0x0, SPR_PMQ_pat_1
 or [0x6BC], 0x0, SPR_PMQ_pat_2
 mov 0x4, SPR_PMQ_control_low
L171:
 orx 1, 2, 0x0, [0x0A,off0], [0x0A,off0]
 jzx 0, 1, SPR_TXE0_PHY_CTL, 0x0, L177
 orx 0, 2, r1, [0x0A,off0], [0x0A,off0]
 jnzx 0, 2, [0x02,off0], 0x0, L177
 jzx 0, 6, [0x01,off0], 0x0, L177
 jext 0x28, L176
 jzx 0, 10, [0x01,off0], 0x0, L172
 jnzx 0, 15, r43, 0x0, L176
 orx 0, 15, 0x0, r43, r43
L172:
 jnzx 0, 6, SPR_TXE0_FIFO_DEF1, 0x0, L176
 srx 9, 0, SPR_TXE0_FIFO_Frame_Count, 0x0, r34
 srx 7, 0, [0x6AD], 0x0, r33
 jzx 1, 4, [0x0B,off0], 0x0, L173
 srx 7, 8, [0x6AD], 0x0, r33
L173:
 jge r34, r33, L176
 jnzx 0, 11, [SHM_HOST_FLAGS2], 0x0, L3
 sl 0x1, [SHM_TXFCUR], r33
 jnand r33, SPR_TXE0_0x5e, L3
 jle 0x0, 0x1, L174
L174:
 jle 0x0, 0x1, L175
L175:
 jnand r33, SPR_TXE0_0x5e, L3
L176:
 orx 1, 2, 0x3, [0x0A,off0], [0x0A,off0]
L177:
 calls L1140
 jzx 6, 0, SPR_AQM_Agg_Stats, 0x0, L141
 calls L69
 or [0x6B9], 0x0, [0x681]
 mov 0x0, r2
 jnzx 0, 0, [0x6BA], 0x0, L180
 calls L58
 or [0x03,off2], 0x0, r2
 srx 5, 2, [0x6B8], 0x0, r18
 je r18, 0x21, L178
 jzx 0, 3, [0x0A,off0], 0x0, L179
L178:
 or [0x08,off2], 0x0, r2
L179:
 jnzx 0, 10, [0x6B8], 0x0, L180
 jnzx 0, 0, [0x6BA], 0x0, L180
 je r18, 0x29, L180
 jnzx 0, 12, [SHM_HOST_FLAGS2], 0x0, L180
 or r2, 0x0, [0x681]
L180:
 jnzx 0, 6, [0x08,off6], 0x0, L183
 jzx 0, 3, [0x00,off6], 0x0, L183
 jnzx 0, 5, [0x0A,off0], 0x0, L183
 jnzx 0, 4, [0x0A,off0], 0x0, L182
 jne [0x484], 0xFFFF, L181
 jzx 0, 8, [0x00,off1], 0x0, L182
 jmp L183
L181:
 or SPR_TSF_WORD0, 0x0, r33
 srx 15, 2, r33, SPR_TSF_WORD1, r33
 jdnz r33, [0x01,off1], L183
 add r33, [0x484], [0x01,off1]
L182:
 orx 1, 4, 0x1, [0x0A,off0], [0x0A,off0]
 orx 0, 8, 0x0, [0x00,off1], [0x00,off1]
 jmp L335
L183:
 jzx 0, 2, [0x06C], 0x0, L184
 orx 0, 15, 0x1, r43, r43
L184:
 jext 0x28, L186
 jzx 0, 14, [0x01,off0], 0x0, L186
 jzx 0, 10, [0x01,off0], 0x0, L185
 jnzx 0, 15, r43, 0x0, L186
L185:
 jnzx 0, 2, [0x08,off6], 0x0, L327
 jzx 1, 0, r1, 0x0, L186
 jnzx 0, 3, [0x08,off6], 0x0, L334
L186:
 sub SPR_AQM_Agg_Len_Low, 0x4, SPR_WEP_WKey
 orx 2, 0, 0x4, [0x0B,off0], [0x0B,off0]
 or [0x00,off6], 0x0, r1
 jzx 0, 14, [0x01,off0], 0x0, L190
 jext COND_4_C4, L192
L187:
 jnzx 0, 9, [0x01,off0], 0x0, L190
L188:
 jnzx 0, 2, SPR_PMQ_control_low, 0x0, L188
 jnzx 0, 0, [0x6BA], 0x0, L189
 jand SPR_PMQ_control_high, 0x1FC, L190
 jnand SPR_PMQ_dat_or, 0x6, L204
 jnzx 0, 5, SPR_PMQ_dat_or, 0x0, L205
 jmp L190
L189:
 jext 0x4A, L190
 jnzx 0, 1, SPR_PMQ_0x0e, 0x0, L204
L190:
 jnzx 0, 4, [0x0A,off0], 0x0, L214
L191:
 jnzx 0, 0, SPR_TDCCTL, 0x0, L191
 add [0x3D3], SPR_TDC_TX_Time, [0x3D3]
 add r2, SPR_TDC_TX_Time, [0x407]
L192:
 or SPR_TDC_PLCP0, 0x0, [0x408]
 or SPR_TDC_PLCP1, 0x0, [0x409]
 or [0x05,off6], 0x0, [0x40A]
 jnext 0x28, L193
 jg [0x407], SPR_TSF_0x2a, L141
L193:
 jnzx 1, 0, [0x0B,off0], 0x0, L194
 srx 5, 2, [0x6B8], 0x0, r18
 srx 2, 4, [0x6AC], 0x0, r38
 jne r38, 0x2, L194
 srx 5, 8, [0x6AC], 0x0, r0
 sl r0, 0x3, r0
 add [SHM_KTP], r0, SPR_BASE4
 mov 0x882, r1
 mov 0x6B0, SPR_BASE3
 add SPR_BASE3, 0x5, SPR_BASE5
 calls L911
L194:
 calls L891
L195:
 orx 1, 0, [0x86B], SPR_TXE0_PHY_CTL, r1
 calls L907
 orx 11, 3, r33, 0x0, SPR_TXE0_TIMEOUT
 jzx 0, 0, [0x06C], 0x0, L196
 orx 12, 0, [0x06D], 0x0, SPR_TXE0_TIMEOUT
L196:
 jne r18, 0x14, L197
 mov 0x491D, SPR_TXE0_CTL
 mov 0x18, SPR_TXE0_TS_LOC
 jmp L0
L197:
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L198
 jnzx 0, 15, [0x01,off0], 0x0, L198
 jext 0x28, L199
L198:
 jnext COND_4_C4, L200
L199:
 orx 1, 8, 0x3, SPR_TXE0_0x76, SPR_TXE0_0x76
 mov 0x4001, SPR_TXE0_CTL
 jmp L0
L200:
 mov 0x481D, r17
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L201
 jge [SHM_TXFCUR], 0x4, L201
 sl [SHM_TXFCUR], 0x4, r33
 add 0x120, r33, SPR_BASE5
 jg [0x04,off5], 0x1, L201
 orx 1, 1, 0x1, r17, r17
L201:
 jne r18, 0x24, L202
 mov 0x6E1D, r17
L202:
 jmp L211
L203:
 orx 3, 4, 0x3, [0x09,off0], [0x09,off0]
 jmp L207
L204:
 orx 3, 4, 0x1, [0x09,off0], [0x09,off0]
 jmp L207
L205:
 orx 3, 4, 0x8, [0x09,off0], [0x09,off0]
 jmp L207
L206:
 orx 3, 4, 0x9, [0x09,off0], [0x09,off0]
L207:
 orx 0, 3, 0x1, [0x0B,off0], [0x0B,off0]
 jmp L385
L208:
 srx 1, 0, [0x6AC], 0x0, r33
 mul r33, 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE5
 jnzx 0, 0, [0x1F,off5], 0x0, L210
 jnzx 0, 2, [0x1F,off5], 0x0, L209
 jzx 0, 7, [0x1F,off5], 0x0, L210
 je [0x21,off5], 0x0, L210
 sl 0x1, r33, r33
 jand [0x746], r33, L210
L209:
 calls L727
 orx 3, 4, 0x7, [0x09,off0], [0x09,off0]
 nap2
 jmp L207
L210:
 rets
L211:
 jext EOI(COND_RX_ATIMWINEND), L749
 jzx 0, 10, [0x01,off0], 0x0, L213
 jzx 0, 15, r43, 0x0, L213
 mov 0x4001, r17
 jzx 0, 15, [0x01,off0], 0x0, L212
 mov 0x8007, r17
L212:
 add [0x042], 0x1, [0x042]
 or [0x042], 0x0, [0xBF4]
 jmp L214
L213:
 mov 0x1, [0x042]
 jzx 0, 0, [SHM_HOST_FLAGS1], 0x0, L214
 srx 2, 11, [SHM_CHAN], 0x0, r34
 srx 1, 14, SPR_TXE0_PHY_CTL, 0x0, r33
 sub r34, 0x2, r34
 jne r33, r34, L214
 jext COND_TX_NAV, L214
 orx 1, 8, 0x1, SPR_TXE0_0x76, SPR_TXE0_0x76
L214:
 or r17, 0x0, SPR_TXE0_CTL
 jzx 0, 0, [0x06C], 0x0, L215
 orx 0, 4, 0x1, SPR_TXE0_AUX, SPR_TXE0_AUX
L215:
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L216
 sub [0x164], SPR_IFS_0x0e, SPR_IFS_BKOFFTIME
 jges SPR_IFS_BKOFFTIME, 0x0, L0
 mov 0x0, SPR_IFS_BKOFFTIME
 jmp L0
L216:
 jne SPR_IFS_BKOFFTIME, 0x0, L0
L217:
 jext EOI(COND_TX_NOW), L218
 jnzx 0, 3, SPR_IFS_STAT, 0x0, L0
 calls L910
 jmp L0
L218:
 orx 0, 0, 0x1, r45, r45
 and [SHM_TSSI_CCK_HI], 0xF, SPR_IFS_CTL_SEL_PRICRS
 add. [0x3C0], SPR_IFS_0x0e, [0x3C0]
 addc [0x3C1], 0x0, [0x3C1]
 calls L1157
 nand SPR_BRC, 0x180, SPR_BRC
 orx 0, 6, 0x0, r63, r63
 orx 0, 6, 0x1, 0x0, SPR_WEP_CTL
 orx 0, 0, 0x0, r46, r46
 mov 0x1010, r33
 nand r44, r33, r44
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L221
 jne r18, 0x10, L219
 calls L1162
L219:
 jne r18, 0x31, L221
 jzx 0, 8, r44, 0x0, L221
 jzx 0, 0, SPR_BTCX_Stat, 0x0, L221
 sub SPR_TSF_WORD0, [0xAEB], r33
 sub [0xADF], r33, r33
 jls r33, 0x41, L221
 orx 0, 7, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L220
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L220:
 jne [0xC3D], 0x0, L221
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L221:
 orx 0, 15, 0x0, r43, r43
 jne [0x042], 0x1, L222
 or SPR_TSF_WORD0, 0x0, [0x043]
L222:
 orx 0, 5, 0x1, SPR_BRC, SPR_BRC
 nand SPR_PSM_COND, 0x82, SPR_PSM_COND
 jext EOI(COND_RX_PLCP), L223
L223:
 orx 0, 4, 0x1, SPR_IFS_CTL, SPR_IFS_CTL
 or [SHM_TXFCUR], 0x0, SPR_TXE0_FIFO_PRI_RDY
 mov 0x0, r50
 orx 1, 1, 0x0, SPR_BRWK0, SPR_BRWK0
 calls L990
 orx 0, 11, 0x0, r63, r63
 jnzx 1, 0, SPR_TXE0_PHY_CTL, 0x0, L224
 orx 0, 11, 0x1, r63, r63
L224:
 mov 0x0, SPR_TXE0_WM1
 mov 0x0, SPR_TXE0_0x70
 jnext COND_PSM(1), L225
 orx 0, 14, 0x1, [SHM_TXFCUR], SPR_TXE0_FIFO_PRI_RDY
 orx 1, 7, 0x3, SPR_WEP_CTL, SPR_WEP_CTL
 orx 7, 8, 0x0, SPR_TXE0_WM0, SPR_TXE0_WM0
 mov 0xB, SPR_TXE0_0x70
 or SPR_AQM_MPDU_Len_FIFO, 0x0, SPR_WEP_WKey
 jne [0xADB], 0x1, L273
 jmp L271
L225:
 mov 0x0, SPR_TXE0_WM0
 add [0x070], 0x1, [0x070]
 je r18, 0xB5, L226
 jne r18, 0x15, L230
L226:
 jext COND_NEED_RESPONSEFR, L229
 je r18, 0x15, L227
 add [0x3DB], 0x1, [0x3DB]
 mov 0x860, SPR_SHMDMA_SHM_Address
 mov 0x16, SPR_MAC_Header_From_SHM_Length
 mov 0xB, SPR_SHMDMA_Xfer_Cnt
 jmp L228
L227:
 add [0x3D8], 0x1, [0x3D8]
 mov 0x854, SPR_SHMDMA_SHM_Address
 mov 0x13, SPR_MAC_Header_From_SHM_Length
 mov 0xA, SPR_SHMDMA_Xfer_Cnt
L228:
 mov 0x5, SPR_SHMDMA_Control
 mov 0x800B, SPR_TX_Serial_Control
 add [0x02,off1], 0x1, [0x02,off1]
 mov 0x441, r33
 mov 0x0, r34
 calls L54
 mov 0x1, SPR_TX_BF_Control
 mov 0x43C, r33
 mov 0xC, r34
 calls L54
 mov 0x3, r34
 calls L54
 orx 0, 7, 0x1, SPR_PSM_COND, SPR_PSM_COND
 je r18, 0xB5, L313
 jmp L260
L229:
 mov 0x8009, SPR_TX_Serial_Control
 add [0x3D9], 0x1, [0x3D9]
 mov 0x320, SPR_TXE0_TIMEOUT
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
 or [0x0F,off0], 0x0, SPR_BASE1
 mov 0x441, r33
 orx 4, 5, r24, [0x06,off1], r34
 orx 2, 10, SPR_TXE0_PHY_CTL1, r34, r34
 calls L54
 mov 0xFFFF, r18
 jmp L315
L230:
 jnext COND_NEED_RESPONSEFR, L245
 je r18, 0xC5, L231
 jne r18, 0x3C, L232
 or [0x4B8], 0x0, SPR_MAC_Header_From_SHM_Length
 add SPR_MAC_Header_From_SHM_Length, 0x1, r33
 mov 0x4BA, SPR_SHMDMA_SHM_Address
 sr r33, 0x1, SPR_SHMDMA_Xfer_Cnt
 mov 0x5, SPR_SHMDMA_Control
 mov 0x800F, SPR_TX_Serial_Control
 add [0x3DA], 0x1, [0x3DA]
 jmp L260
L231:
 orx 0, 12, 0x1, r44, r44
 mov 0x3FC0, SPR_TXE0_WM0
 calls L456
 mov 0x0, r34
 mov 0x10, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 add [0x3DC], 0x1, [0x3DC]
 jmp L260
L232:
 jne r18, 0x25, L235
 mov 0x8000, SPR_TXBA_Data_Select
 or SPR_TXBA_Data_Select, 0x0, 0x0
 or SPR_TXBA_Data, 0x0, SPR_TME_VAL32
 or SPR_TXBA_Data_Select, 0x0, 0x0
 or SPR_TXBA_Data, 0x0, SPR_TME_VAL34
 or SPR_TXBA_Data_Select, 0x0, 0x0
 or SPR_TXBA_Data, 0x0, SPR_TME_VAL36
 or SPR_TXBA_Data_Select, 0x0, 0x0
 or SPR_TXBA_Data, 0x0, SPR_TME_VAL38
 je SPR_TME_VAL32, 0x0, L233
 sl SPR_TXBA_Data, 0x4, SPR_TME_VAL30
L233:
 mov 0xFF80, SPR_TXE0_WM0
 mov 0xF, SPR_TXE0_WM1
 jzx 0, 1, [SHM_HOST_FLAGS2], 0x0, L234
 jzx 0, 0, [0x03,off1], 0x0, L234
 jzx 0, 1, SPR_AQM_FIFO_Ready, 0x0, L234
 orx 0, 6, 0x1, SPR_TXE0_WM0, SPR_TXE0_WM0
 mov 0x2, SPR_TME_MASK12
 mov 0x2, SPR_TME_VAL12
 add [0x3E4], 0x1, [0x3E4]
 orx 0, 15, 0x1, r43, r43
L234:
 mov 0x0, SPR_TXE0_FIFO_Head
 mov 0x0, r34
 mov 0x1C, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 add [0x0AB], 0x1, [0x0AB]
 jmp L260
L235:
 jne r18, 0x29, L236
 mov 0x980, r34
 mov 0x10, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 jmp L238
L236:
 jne r18, 0x12, L239
 jnzx 0, 11, SPR_TME_VAL12, 0x0, L237
 add r9, 0x1, r9
L237:
 orx 11, 4, r9, 0x0, SPR_TME_VAL34
 srx 2, 8, [0x794], 0x0, r38
 mul 0x18, r38, 0x0
 add 0x2C, SPR_PSM_0x5a, r34
 mov 0x18, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 add [0x074], 0x1, [0x074]
L238:
 mov 0xC0, SPR_TXE0_WM0
 mov 0x2, SPR_TXE0_WM1
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
 jnzx 0, 5, r44, 0x0, L319
 jzx 0, 8, r44, 0x0, L319
 orx 0, 7, 0x1, SPR_BRC, SPR_BRC
 or SPR_BRC, 0x0, 0x0
 mov 0x35, r14
 orx 0, 1, 0x1, r46, r46
 jmp L319
L239:
 mov 0x7C0, SPR_TXE0_WM0
 srx 0, 7, r20, 0x0, r34
 je [0x582], 0x0, L240
 or [0x582], 0x0, r34
 sr [0x746], r34, r34
L240:
 jzx 0, 0, r63, 0x0, L241
 mov 0x1, r34
L241:
 je [0xB0D], 0x0, L242
 mov 0x1, r34
L242:
 orx 0, 12, r34, SPR_TME_VAL12, SPR_TME_VAL12
 calls L456
 je [0xB0D], 0x0, L243
 add SPR_TME_VAL14, [0xB13], SPR_TME_VAL14
L243:
 mov 0x0, r34
 mov 0xA, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 je r18, 0x35, L244
 add [0x072], 0x1, [0x072]
 jmp L260
L244:
 add [0x073], 0x1, [0x073]
 jmp L260
L245:
 jnext COND_NEED_BEACON, L261
 orx 0, 3, 0x0, SPR_BRC, SPR_BRC
 add [0x075], 0x1, [0x075]
 jnext 0x3D, L256
 mov 0x0, r34
 jgs r8, 0x0, L246
 srx 0, 4, SPR_AQM_FIFO_Ready, 0x0, r34
 orx 0, 10, r34, SPR_BRC, SPR_BRC
L246:
 orx 0, 1, 0x1, SPR_TXE0_AUX, SPR_TXE0_AUX
 jnzx 0, 9, r20, 0x0, L247
 mov 0x482, r33
 jmp L248
L247:
 mov 0x202, r33
L248:
 je [SHM_DTIMP], 0x0, L256
 add r33, [SHM_TIMBPOS], r33
 mov 0x850, SPR_BASE5
 orx 1, 0, 0x2, r33, SPR_TXE0_0x64
L249:
 jnzx 0, 1, SPR_TXE0_0x64, 0x0, L249
 or SPR_TXE0_Template_Data_Low, 0x0, [0x850]
 or SPR_TXE0_Template_Data_High, 0x0, [0x851]
 add SPR_TXE0_0x64, 0x6, SPR_TXE0_0x64
L250:
 jnzx 0, 1, SPR_TXE0_0x64, 0x0, L250
 or SPR_TXE0_Template_Data_Low, 0x0, [0x852]
 or SPR_TXE0_Template_Data_High, 0x0, [0x853]
 jnand r33, 0x2, L252
 jnand r33, 0x1, L251
 orx 7, 0, r8, [0x00,off5], [0x00,off5]
 orx 0, 0, r34, [0x01,off5], [0x01,off5]
 jmp L254
L251:
 orx 7, 8, r8, [0x00,off5], [0x00,off5]
 orx 0, 8, r34, [0x01,off5], [0x01,off5]
 jmp L254
L252:
 jnand r33, 0x1, L253
 orx 7, 0, r8, [0x01,off5], [0x01,off5]
 orx 0, 0, r34, [0x02,off5], [0x02,off5]
 jmp L254
L253:
 orx 7, 8, r8, [0x01,off5], [0x01,off5]
 orx 0, 8, r34, [0x02,off5], [0x02,off5]
L254:
 or [0x00,off5], 0x0, SPR_TXE0_Template_Data_Low
 or [0x01,off5], 0x0, SPR_TXE0_Template_Data_High
 orx 1, 0, 0x1, r33, SPR_TXE0_0x64
L255:
 jnzx 0, 0, SPR_TXE0_0x64, 0x0, L255
 or [0x02,off5], 0x0, SPR_TXE0_Template_Data_Low
 or [0x03,off5], 0x0, SPR_TXE0_Template_Data_High
 add SPR_TXE0_0x64, 0x5, SPR_TXE0_0x64
L256:
 orx 0, 1, 0x1, SPR_TXE0_WM1, SPR_TXE0_WM1
 add r9, 0x1, r9
 orx 11, 4, r9, 0x0, SPR_TME_VAL34
 mov 0x200, r34
 or [SHM_BTL0], 0x0, SPR_TXE0_FIFO_Write_Pointer
 jnzx 0, 9, r20, 0x0, L257
 mov 0x480, r34
 or [SHM_BTL1], 0x0, SPR_TXE0_FIFO_Write_Pointer
L257:
 calls L465
 mov 0x8000, SPR_TX_Serial_Control
 orx 0, 8, 0x1, r20, r20
 orx 0, 12, 0x0, SPR_BRC, SPR_BRC
 jext 0x3D, L258
 jnzx 0, 0, SPR_TSF_0x0e, 0x0, L259
 or r15, 0x0, SPR_IFS_BKOFFTIME
 mov 0x0, r15
 or r16, 0x0, r5
 or r3, 0x0, r16
 jmp L259
L258:
 or r3, 0x0, r5
 jnzx 0, 0, SPR_TSF_0x0e, 0x0, L259
 and SPR_TSF_RANDOM, r5, SPR_IFS_BKOFFTIME
L259:
 mov 0x8, SPR_MAC_IRQLO
 orx 0, 6, 0x1, r20, r20
L260:
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
 jext COND_NEED_BEACON, L318
 jzx 0, 12, r43, 0x0, L319
 orx 0, 13, 0x1, r43, r43
 mov 0x0, SPR_TXE0_CTL
 mov 0x0, SPR_IFS_CTL1
 calls L729
 jmp L401
L261:
 jext 0x42, L284
 jne [SHM_TXFCUR], 0x7, L262
 orx 0, 2, 0x1, SPR_BRC, SPR_BRC
 jmp L284
L262:
 jge [SHM_TXFCUR], 0x4, L263
 orx 0, 7, 0x1, SPR_PSM_COND, SPR_PSM_COND
L263:
 orx 0, 0, 0x1, r46, r46
 srx 1, 0, [0x6AC], 0x0, [0x583]
 jand 0x3, [0x0B,off0], L266
 sl r18, 0x2, SPR_TME_VAL12
 mov 0xFFFF, SPR_TME_MASK12
 or [0x3D3], 0x0, SPR_TME_VAL14
 mov 0xC0, SPR_TXE0_WM0
 mov 0x7C, SPR_TXE0_FIFO_Read_Pointer
 jzx 0, 0, [0x01,off0], 0x0, L264
 mov 0x14, SPR_TXE0_FIFO_Read_Pointer
L264:
 jzx 0, 0, [0x0B,off0], 0x0, L265
 add SPR_TXE0_FIFO_Read_Pointer, 0x6, SPR_TXE0_FIFO_Read_Pointer
 mov 0xA, SPR_TXE0_FIFO_Write_Pointer
 orx 8, 7, 0x10B, r50, SPR_TXE0_FIFO_Head
 mov 0x8001, SPR_TX_Serial_Control
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
 mov 0x0, r14
 jmp L321
L265:
 add [0x071], 0x1, [0x071]
 mov 0x10, SPR_TXE0_FIFO_Write_Pointer
 orx 8, 7, 0x10B, r50, SPR_TXE0_FIFO_Head
 mov 0x8001, SPR_TX_Serial_Control
 jmp L302
L266:
 orx 4, 10, 0x11, [SHM_TXFCUR], SPR_TXE0_FIFO_PRI_RDY
 mov 0x0, [0x13,off0]
 srx 7, 0, [0x04,off0], 0x0, SPR_WEP_IV_Key
 add SPR_WEP_IV_Key, 0xC, SPR_WEP_IV_Key
 mov 0x0, SPR_TME_VAL12
 mov 0x0, SPR_TME_MASK12
 srx 0, 0, [0x02,off0], 0x0, r33
 xor r33, 0x1, r33
 orx 0, 14, r33, SPR_TXE0_CTL, SPR_TXE0_CTL
 jnext COND_PSM(7), L268
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L268
 jzx 0, 0, [SHM_HOST_FLAGS4], 0x0, L267
 sub [SHM_SLOTT], 0x2, SPR_IFS_slot
 orx 7, 8, 0x2, SPR_IFS_slot, SPR_IFS_slot
L267:
 jext 0x28, L268
 or [0x162], 0x0, SPR_BASE4
 add [0x08,off4], 0x1, [0x08,off4]
 je [0x00,off4], 0x0, L268
 or SPR_TSF_WORD0, 0x0, SPR_TSF_0x24
 or [0x00,off4], 0x0, SPR_TSF_0x2a
L268:
 jne [0x042], 0x1, L269
 je [0xBF4], 0x0, L269
 mov 0xBEC, SPR_BASE4
 sub [0xBF4], 0x1, r33
 and r33, 0x7, r33
 add SPR_BASE4, r33, SPR_BASE4
 add [0x00,off4], 0x1, [0x00,off4]
L269:
 jzx 0, 2, [0x0A,off0], 0x0, L280
 jzx 0, 3, [0x0A,off0], 0x0, L270
 orx 0, 1, 0x1, SPR_PSM_COND, SPR_PSM_COND
L270:
 or SPR_AQM_MPDU_Len_FIFO, 0x0, SPR_WEP_WKey
 srx 6, 0, SPR_AQM_Agg_Stats, 0x0, [0xADB]
 mov 0xBA3, SPR_BASE5
 add SPR_BASE5, [0xADB], SPR_BASE5
 add [0x00,off5], 0x1, [0x00,off5]
 add [SHM_BEACPHYCTL], 0x1, [SHM_BEACPHYCTL]
 mov 0xA, SPR_TXE0_0x70
 jne [0xADB], 0x1, L273
L271:
 orx 0, 3, 0x0, SPR_TXE0_0x70, SPR_TXE0_0x70
 jzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L272
 srx 2, 12, SPR_TDC_VHT_MAC_PAD, 0x0, r33
 srx 11, 0, SPR_TDC_VHT_MAC_PAD, 0x0, SPR_TXE0_0x7e
 orx 2, 8, r33, SPR_TXE0_0x70, SPR_TXE0_0x70
L272:
 mov 0x7, SPR_TXE0_SELECT
L273:
 srx 5, 0, SPR_AQM_IDX_FIFO, 0x0, r50
 je r50, 0x0, L278
 jne [0x1A,off0], 0x0, L278
 mov 0x1840, SPR_TXE0_AGGFIFO_CMD
 mov 0x4, SPR_TXE0_FIFO_Write_Pointer
 orx 8, 7, 0x102, r50, SPR_TXE0_FIFO_Head
L274:
 jnext COND_TX_BUSY, L274
L275:
 jext COND_TX_BUSY, L275
 or [0x00,off0], 0x0, r33
 xor r33, [0xC20], r33
 jzx 0, 9, r33, 0x0, L278
 add [0xC1C], 0x1, [0xC1C]
 or r50, 0x0, [0x1A,off0]
 nand SPR_BRC, 0xA0, SPR_BRC
 mov 0x0, SPR_TXE0_0x7e
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
 mov 0x75, SPR_WEP_CTL
 mov 0x0, SPR_WEP_CTL
L276:
 jnext EOI(COND_TX_UNDERFLOW), L276
 calls L928
 add [SHM_TXFCUR], 0x76, SPR_BASE5
 add [0x00,off5], 0x1, [0x00,off5]
 jext EOI(COND_TX_POWER), L277
L277:
 jmp L3
L278:
 sl SPR_WEP_WKey, 0x4, SPR_TXE0_0x72
 srx 1, 12, SPR_WEP_WKey, 0x0, r33
 orx 1, 2, r33, SPR_TXE0_0x72, SPR_TXE0_0x72
 jzx 0, 2, [0x02,off0], 0x0, L279
 or SPR_TXE0_0x72, 0x1, SPR_TXE0_0x72
L279:
 je [0xADB], 0x1, L280
 add SPR_WEP_WKey, 0x7, r33
 nand r33, 0x3, r33
 jge r33, SPR_AQM_Min_MPDU_Length, L280
 sub SPR_AQM_Min_MPDU_Length, r33, r34
 sr r34, 0x2, SPR_TXE0_0x7e
L280:
 jnzx 0, 0, SPR_TXE0_0x70, 0x0, L281
 calls L460
L281:
 orx 0, 15, 0x1, [SHM_TXFCUR], SPR_TXE0_FIFO_PRI_RDY
 or SPR_TXE0_FIFO_PRI_RDY, 0x0, 0x0
 srx 3, 0, SPR_AQM_TX_Control_FIFO, 0x0, r33
 jl r33, [0x1C,off0], L282
 jges [0x1D,off0], r50, L282
 or r50, 0x0, [0x1D,off0]
L282:
 jl r33, [0x13,off0], L283
 or r33, 0x0, [0x13,off0]
 or r50, 0x0, [0x14,off0]
L283:
 jle r33, 0x1, L284
 srx 1, 0, r18, 0x0, r33
 je r33, 0x1, L284
 orx 0, 11, 0x1, SPR_TME_VAL12, SPR_TME_VAL12
 orx 0, 11, 0x1, SPR_TME_MASK12, SPR_TME_MASK12
L284:
 jzx 0, 1, [SHM_HOST_FLAGS2], 0x0, L285
 or [0x042], 0x0, r33
 jl r33, [0x069], L285
 orx 0, 0, 0x1, SPR_TME_VAL12, SPR_TME_VAL12
 orx 0, 0, 0x1, SPR_TME_MASK12, SPR_TME_MASK12
 add [0x3E3], 0x1, [0x3E3]
L285:
 jnzx 0, 7, SPR_TXE0_WM0, 0x0, L286
 or [0x681], 0x0, SPR_TME_VAL14
 orx 0, 7, 0x1, SPR_TXE0_WM0, SPR_TXE0_WM0
L286:
 add r39, 0x1, r39
 jext 0x42, L299
 mov 0x0, r39
 srx 2, 4, [0x6AC], 0x0, r38
 jzx 0, 4, [0x02,off0], 0x0, L292
 jne r50, 0x0, L287
 sl [0x3D4], 0x4, [0x07,off0]
L287:
 je r38, 0x5, L288
 jne r38, 0x2, L291
L288:
 mov 0x6B2, SPR_BASE5
 sr SPR_WEP_IV_Key, 0x1, r33
 add SPR_BASE5, r33, SPR_BASE5
 je r38, 0x2, L289
 add. [0x3D5], r50, [0x00,off5]
 jmp L290
L289:
 add. [0x3D5], r50, r33
 orx 7, 0, r33, [0x01,off5], [0x01,off5]
 sr r33, 0x8, r33
 orx 7, 0, r33, [0x00,off5], [0x00,off5]
L290:
 addc. [0x3D6], 0x0, [0x02,off5]
 addc [0x3D7], 0x0, [0x03,off5]
L291:
 add [0x3D4], r50, r33
 orx 11, 4, r33, [0x6C3], [0x6C3]
 jmp L295
L292:
 jzx 0, 11, [0x01,off0], 0x0, L295
 jnzx 0, 11, SPR_TME_VAL12, 0x0, L294
 jzx 0, 14, [0x01,off0], 0x0, L293
 add r9, 0x1, r9
L293:
 orx 11, 4, r9, [0x6C3], [0x07,off0]
L294:
 or [0x07,off0], 0x0, SPR_TME_VAL34
 orx 0, 1, 0x1, SPR_TXE0_WM1, SPR_TXE0_WM1
L295:
 mov 0x1, SPR_TX_Serial_Control
 srx 7, 0, [0x1E,off0], 0x0, SPR_TXE0_FIFO_Read_Pointer
 jzx 7, 8, [0x1E,off0], 0x0, L297
 srx 7, 8, [0x1E,off0], 0x0, SPR_MAC_Header_From_SHM_Length
 jnext COND_PSM(1), L296
 sl r50, 0x4, r34
 add [0x07,off0], r34, [0x6C3]
L296:
 orx 0, 1, 0x1, SPR_TX_Serial_Control, SPR_TX_Serial_Control
 mov 0x6B8, SPR_SHMDMA_SHM_Address
 add SPR_MAC_Header_From_SHM_Length, 0x1, r33
 sr r33, 0x1, SPR_SHMDMA_Xfer_Cnt
 mov 0x5, SPR_SHMDMA_Control
 sub SPR_WEP_WKey, 0x4, r33
 jne SPR_MAC_Header_From_SHM_Length, r33, L297
 orx 0, 3, 0x1, SPR_TX_Serial_Control, SPR_TX_Serial_Control
 jmp L298
L297:
 orx 8, 7, 0x109, r50, SPR_TXE0_FIFO_Head
L298:
 orx 0, 15, 0x1, SPR_TX_Serial_Control, SPR_TX_Serial_Control
 jmp L302
L299:
 jne [0x86C], 0x0, L300
 add r9, 0x1, r9
 jmp L301
L300:
 orx 0, 11, 0x1, 0x0, SPR_TME_VAL12
 orx 0, 11, 0x1, 0x0, SPR_TME_MASK12
 or SPR_TXE0_WM0, 0x40, SPR_TXE0_WM0
L301:
 orx 11, 4, r9, 0x0, SPR_TME_VAL34
 orx 0, 1, 0x1, SPR_TXE0_WM1, SPR_TXE0_WM1
 orx 2, 8, 0x7, SPR_TXE0_WM0, SPR_TXE0_WM0
 mov 0x700, r34
 or [SHM_PRTLEN], 0x0, SPR_TXE0_FIFO_Write_Pointer
 calls L465
 mov 0x8001, SPR_TX_Serial_Control
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
 jmp L315
L302:
 srx 0, 9, SPR_MAC_CTLHI, 0x0, r33
 je [0x583], 0x0, L303
 or [0x583], 0x0, r33
 sr [0x746], r33, r33
 jmp L304
L303:
 jnext COND_4_C4, L304
 srx 0, 7, r20, 0x0, r33
L304:
 or r33, 0x0, r34
 jzx 0, 0, r63, 0x0, L305
 mov 0x1, r34
L305:
 je [0xB0D], 0x0, L306
 mov 0x1, r34
L306:
 jnzx 1, 0, r18, 0x0, L307
 je r18, 0x34, L307
 mov 0x0, r34
L307:
 jne [0x583], 0x0, L308
 orx 0, 7, r33, r20, r20
L308:
 orx 0, 3, r33, [0x09,off0], [0x09,off0]
 orx 0, 12, r34, SPR_TME_VAL12, SPR_TME_VAL12
 orx 0, 12, 0x1, SPR_TME_MASK12, SPR_TME_MASK12
 orx 0, 6, 0x1, SPR_TXE0_WM0, SPR_TXE0_WM0
 srx 1, 0, r18, 0x0, r33
 je r33, 0x1, L313
 jnzx 0, 4, SPR_WEP_CTL, 0x0, L314
 jne [SHM_TXFCUR], 0x4, L311
 or [SHM_MCASTCOOKIE], 0x0, r34
 jne r34, 0xFFFF, L309
 srx 9, 0, SPR_TXE0_FIFO_Frame_Count, 0x0, r33
 je r33, 0x1, L310
L309:
 jne r34, [0x06,off0], L311
L310:
 orx 0, 10, 0x0, SPR_BRC, SPR_BRC
 orx 0, 13, 0x0, SPR_TME_VAL12, SPR_TME_VAL12
 orx 0, 13, 0x1, SPR_TME_MASK12, SPR_TME_MASK12
L311:
 je r38, 0x0, L313
 or r38, 0x0, SPR_WEP_CTL
 srx 5, 8, [0x6AC], 0x0, r0
 sl r0, 0x3, r0
 add [SHM_KTP], r0, SPR_BASE4
 jne r38, 0x2, L312
 mov 0x880, SPR_BASE4
 jzx 0, 13, [0x01,off0], 0x0, L312
 orx 0, 13, 0x1, SPR_WEP_CTL, SPR_WEP_CTL
 add r0, [0x059], r35
L312:
 calls L916
 orx 4, 4, 0x11, SPR_WEP_CTL, SPR_WEP_CTL
 jmp L314
L313:
 orx 0, 4, 0x1, 0x0, SPR_WEP_CTL
L314:
 mov 0x0, SPR_TSF_RANDOM
 jext COND_4_C7, L320
 mov 0x0, r14
 je r18, 0x2D, L315
 je r18, 0xB5, L315
 jzx 0, 7, [0x01,off0], 0x0, L317
L315:
 orx 0, 7, 0x1, SPR_BRC, SPR_BRC
 or SPR_BRC, 0x0, 0x0
 mov 0x25, r14
 je r18, 0x21, L316
 jext COND_PSM(1), L316
 mov 0x31, r14
 je r18, 0x2D, L316
 mov 0xC5, r14
 je r18, 0xB5, L319
 mov 0x38, r14
 je r18, 0xFFFF, L319
 mov 0x35, r14
L316:
 jge [SHM_TXFCUR], 0x7, L319
 jzx 0, 6, [0x08,off6], 0x0, L319
 or [0x0F,off0], 0x0, SPR_BASE1
 je r14, 0x31, L319
 mov 0x442, r33
 mov 0xA, r34
 calls L54
 mov 0x443, r33
 srx 4, 0, [0x00,off1], 0x0, r34
 calls L54
 orx 0, 8, 0x0, [0x00,off1], [0x00,off1]
 jmp L319
L317:
 orx 0, 2, 0x1, r43, r43
 or r3, 0x0, r5
 calls L909
L318:
 mov 0x0, r12
 mov 0x0, r13
L319:
 jnext COND_4_C7, L321
L320:
 orx 0, 15, 0x1, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
L321:
 mov 0x0, SPR_IFS_CTL1
 or r18, 0x0, r21
 jne SPR_TXE0_FIFO_PRI_RDY, 0x7, L322
 orx 0, 6, 0x1, r21, r21
L322:
 jne [0xC08], 0x0, L323
 or r18, 0x0, [0xC15]
L323:
 jnext COND_PSM(1), L325
L324:
 calls L990
 jnext EOI(COND_TX_POWER), L324
 jmp L352
L325:
 jzx 0, 10, r43, 0x0, L326
 orx 0, 15, 0x1, SPR_TSF_GPT2_STAT, SPR_TSF_GPT2_STAT
L326:
 jmp L0
L327:
 orx 2, 0, 0x2, [0x0B,off0], [0x0B,off0]
 mov 0x2D, r18
L328:
 orx 1, 0, [0x08,off6], 0x4, SPR_TXE0_PHY_CTL
 srx 0, 4, [0x08,off6], 0x0, r33
 orx 0, 4, r33, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 srx 0, 0, [0x08,off6], 0x0, [0x86B]
 srx 3, 8, [0x08,off6], 0x0, r33
 mov 0x100, SPR_BASE5
 mov 0xC0, [0x006]
 jzx 0, 0, [0x08,off6], 0x0, L329
 mov 0xE0, SPR_BASE5
 mov 0x14, [0x006]
L329:
 add SPR_BASE5, r33, SPR_BASE5
 or [0x00,off5], 0x0, SPR_BASE3
 or [0x00,off5], 0x0, SPR_BASE2
 srx 2, 8, [SHM_CHAN], 0x0, r34
 orx 2, 0, r34, [0x07,off3], SPR_TXE0_PHY_CTL1
 jnzx 0, 0, [0x08,off6], 0x0, L331
 je r18, 0x31, L330
 or [0x0C,off3], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x0D,off3], 0x0, SPR_TX_PLCP_HT_Sig1
 jmp L333
L330:
 or [0x01,off3], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x02,off3], 0x0, SPR_TX_PLCP_HT_Sig1
 jmp L333
L331:
 srx 1, 14, [0x00,off6], 0x0, r34
 orx 1, 14, r34, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 orx 2, 0, [0x01,off6], SPR_TXE0_PHY_CTL1, SPR_TXE0_PHY_CTL1
 or [0x01,off3], 0x0, SPR_TX_PLCP_HT_Sig0
 je r18, 0x31, L332
 orx 10, 5, 0x14, [0x01,off3], SPR_TX_PLCP_HT_Sig0
L332:
 mov 0x0, SPR_TX_PLCP_HT_Sig1
L333:
 add r2, [SHM_EDCFSTAT], [0x3D3]
 add r2, [0x03,off3], r2
 je r18, 0x31, L187
 or [0x3D3], 0x0, r33
 add r33, [0x03,off3], [0x3D3]
 add r2, [0x09,off3], r2
 jmp L187
L334:
 orx 2, 0, 0x1, [0x0B,off0], [0x0B,off0]
 mov 0x31, r18
 jmp L328
L335:
 or [0x02,off2], 0x0, SPR_TX_PLCP_HT_Sig1
 orx 10, 5, 0x1A, [0x01,off2], SPR_TX_PLCP_HT_Sig0
 mov 0x862, SPR_BASE5
 mov 0xB5, r18
 jne [0x04,off1], 0x15, L336
 mov 0x15, r18
 orx 10, 5, 0x17, [0x01,off2], SPR_TX_PLCP_HT_Sig0
 mov 0x856, SPR_BASE5
 sl [0x0C,off1], 0x8, [0x85C]
 srx 7, 8, [0x0C,off1], 0x0, [0x85D]
L336:
 srx 1, 14, [0x00,off6], 0x0, r33
 orx 1, 14, r33, 0x5, SPR_TXE0_PHY_CTL
 orx 1, 12, r33, [0x00,off1], [0x00,off1]
 srx 2, 0, [0x01,off6], 0x0, r33
 orx 2, 0, r33, [0x07,off2], SPR_TXE0_PHY_CTL1
 or [0x6BA], 0x0, [0x00,off5]
 or [0x6BB], 0x0, [0x01,off5]
 or [0x6BC], 0x0, [0x02,off5]
 jne r18, 0xB5, L337
 add SPR_BASE5, 0x3, SPR_BASE5
L337:
 or [0x6BD], 0x0, [0x03,off5]
 or [0x6BE], 0x0, [0x04,off5]
 or [0x6BF], 0x0, [0x05,off5]
 orx 5, 2, [0x03,off1], 0x0, [0x06,off5]
 calls L891
 mov 0x481D, r17
 jmp L187
L338:
 add [0x3DF], 0x1, [0x3DF]
 jzx 0, 12, r44, 0x0, L0
 or [0x487], 0x0, SPR_BASE5
 jzx 0, 0, SPR_RXE_PHYRXSTAT0, 0x0, L339
 srx 2, 10, [0x7E5], 0x0, r33
 srx 2, 3, [0x08,off5], 0x0, r34
 orx 2, 3, r33, [0x08,off5], [0x08,off5]
 jmp L340
L339:
 srx 3, 3, [0x7E5], 0x0, r33
 srx 1, 2, [0x08,off5], 0x0, r34
 orx 1, 2, r33, [0x08,off5], [0x08,off5]
L340:
 or [0x486], 0x0, r35
 jge r33, [0x486], L341
 or r33, 0x0, r35
L341:
 jzx 0, 0, SPR_RXE_PHYRXSTAT0, 0x0, L342
 orx 2, 0, r35, [0x08,off5], [0x08,off5]
 jmp L343
L342:
 orx 1, 0, r35, [0x08,off5], [0x08,off5]
L343:
 jne r34, r33, L41
 or [0x08,off5], 0x0, [0x4C7]
 mov 0x447, r33
 calls L52
 srx 1, 14, SPR_Ext_IHR_Data, 0x0, r37
 jzx 0, 0, SPR_RXE_PHYRXSTAT0, 0x0, L344
 orx 1, 6, r37, [0x4C7], [0x4C7]
 mov 0x15, [0x4C6]
 mov 0x1D, [0x4B8]
 jmp L345
L344:
 orx 0, 4, r37, [0x4C7], [0x4C7]
 or SPR_TSF_WORD0, 0x0, [0x4C8]
 or SPR_TSF_WORD1, 0x0, [0x4C9]
 mov 0x607, [0x4C6]
 mov 0x20, [0x4B8]
L345:
 or [0x4B9], 0x0, SPR_BASE2
 mov 0x1, [0x86B]
 calls L901
 srx 1, 14, SPR_TXE0_PHY_CTL, 0x0, r33
 jne r37, r33, L41
 calls L727
 mov 0x448, r33
 calls L52
 srx 12, 0, SPR_Ext_IHR_Data, 0x0, SPR_TX_BF_Rpt_Length
 add SPR_TX_BF_Rpt_Length, [0x4B8], r33
 add r33, 0x4, r33
 orx 10, 5, r33, [0x01,off2], SPR_TX_PLCP_HT_Sig0
 sr r33, 0xB, r33
 orx 4, 0, r33, [0x02,off2], SPR_TX_PLCP_HT_Sig1
 mov 0x3C, r18
 orx 2, 0, 0x2, SPR_BRC, SPR_BRC
 jmp L199
L346:
 add [0x3DE], 0x1, [0x3DE]
L347:
 jnext 0x62, L649
 srx 5, 8, SPR_AMT_Match1, 0x0, r34
 add 0x334, r34, SPR_BASE5
 jzx 0, 12, [0x00,off5], 0x0, L649
 srx 2, 13, [0x00,off5], 0x0, r34
 sl r34, 0x4, r34
 add [SHM_EXTNPHYCTL], r34, SPR_BASE5
 orx 0, 12, 0x1, r44, r44
 or SPR_BASE5, 0x0, [0x487]
 mov 0x442, r33
 or [0x07,off5], 0x0, r34
 calls L54
 mov 0x444, r33
 or [0x08,off5], 0x0, r34
 calls L54
 mov 0x445, r33
 calls L52
 orx 0, 14, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
 or SPR_MHP_Addr2_Low, 0x0, [0x4BC]
 or SPR_MHP_Addr2_Mid, 0x0, [0x4BD]
 or SPR_MHP_Addr2_High, 0x0, [0x4BE]
 or SPR_MHP_Addr1_Low, 0x0, [0x4BF]
 or SPR_MHP_Addr1_Mid, 0x0, [0x4C0]
 or SPR_MHP_Addr1_High, 0x0, [0x4C1]
 or [0x09,off5], 0x0, [0x4C2]
 or [0x0A,off5], 0x0, [0x4C3]
 or [0x0B,off5], 0x0, [0x4C4]
 or SPR_BASE2, 0x0, [0x4B9]
 jne r19, 0x15, L649
 or [0x0B,off1], 0x0, [0x4C8]
 srx 5, 2, [0x0B,off1], 0x0, [0x4C5]
 jmp L649
L348:
 mov 0x100, SPR_TX_BF_Control
 mov 0x442, r33
 mov 0x0, r34
 calls L54
 mov 0x439, r33
 mov 0xC, r34
 calls L54
 mov 0x3, r34
 calls L54
 mov 0x0, SPR_TX_BF_Control
 rets
L349:
 jext 0x3D, L781
 jext 0x61, L350
 jzx 0, 0, [0x05,off1], 0x0, L651
L350:
 jnext 0x63, L781
 orx 0, 8, 0x1, r20, r20
 jext 0x61, L442
 jmp L572
L351:
 jmp L651
L352:
 jzx 0, 3, SPR_TXE0_0x70, 0x0, L353
 sub [0xADB], 0x1, [0xADB]
 jmp L224
L353:
 mov 0x7, SPR_TXE0_SELECT
 jzx 0, 13, [SHM_HOST_FLAGS1], 0x0, L354
 mov 0x256, r33
 mov 0xE0, r34
 calls L54
 or SPR_TSF_WORD0, 0x0, [0xBFE]
L354:
 orx 0, 5, 0x0, SPR_BRC, SPR_BRC
 orx 4, 4, 0x15, 0x0, SPR_WEP_CTL
 jnzx 0, 10, [0x6B8], 0x0, L355
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
L355:
 jext COND_NEED_RESPONSEFR, L362
 jext EOI(COND_TX_UNDERFLOW), L689
 jext EOI(COND_TX_PHYERR), L691
 je r18, 0xB5, L3
 jne r18, 0x15, L361
L356:
 orx 0, 1, 0x1, SPR_BRC, SPR_BRC
 or [0x0F,off0], 0x0, SPR_BASE5
 srx 1, 0, [0x05,off5], 0x0, r33
 mul r33, 0x7, r33
 mov 0x488, r33
 add r33, SPR_PSM_0x5a, SPR_BASE5
 orx 12, 0, [0x00,off5], SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 orx 2, 0, SPR_TXE0_PHY_CTL1, [0x01,off5], SPR_TXE0_PHY_CTL1
 or [0x02,off5], 0x0, SPR_TXE0_PHY_CTL2
 add SPR_BASE5, 0x3, SPR_BASE5
 srx 1, 14, SPR_TXE0_PHY_CTL, 0x0, r33
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L357
 orx 0, 7, r33, [0x01,off5], [0x01,off5]
 jmp L360
L357:
 orx 1, 0, r33, [0x01,off5], [0x01,off5]
 jne r33, 0x0, L358
 mov 0x22E0, SPR_TX_PLCP_VHT_SigB0
 mov 0x4, SPR_TX_PLCP_VHT_SigB1
 jmp L360
L358:
 jne r33, 0x1, L359
 mov 0x45A5, SPR_TX_PLCP_VHT_SigB0
 mov 0xC, SPR_TX_PLCP_VHT_SigB1
 jmp L360
L359:
 mov 0xF4CA, SPR_TX_PLCP_VHT_SigB0
 mov 0x27, SPR_TX_PLCP_VHT_SigB1
L360:
 or [0x00,off5], 0x0, SPR_TX_PLCP_Sig0
 mov 0x0, SPR_TX_PLCP_Sig1
 or [0x01,off5], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x02,off5], 0x0, SPR_TX_PLCP_HT_Sig1
 or [0x03,off5], 0x0, SPR_TX_PLCP_HT_Sig2
 orx 1, 8, 0x3, SPR_TXE0_0x76, SPR_TXE0_0x76
 mov 0x1, SPR_TXE0_CTL
 jmp L0
L361:
 jnext COND_NEED_BEACON, L364
L362:
 orx 1, 0, 0x0, SPR_BRC, SPR_BRC
 je r18, 0xC5, L0
 jne r18, 0x3C, L363
 calls L348
L363:
 jmp L3
L364:
 jzx 0, 0, [0x06C], 0x0, L366
 jzx 0, 8, [0x06C], 0x0, L365
 sub. [0x06E], 0x1, [0x06E]
 subc [0x06F], 0x0, [0x06F]
 jne [0x06E], 0x0, L365
 jne [0x06F], 0x0, L365
 mov 0x0, [0x06C]
 jmp L385
L365:
 mov 0x0, r11
 jmp L367
L366:
 mov 0x1, r33
 calls L802
L367:
 jzx 0, 2, [0x06C], 0x0, L368
 jmp L3
L368:
 jext COND_4_C7, L3
 jzx 0, 0, [0x0B,off0], 0x0, L370
 mov 0x0, SPR_TXE0_CTL
 orx 0, 4, 0x1, SPR_BRC, SPR_BRC
 orx 0, 0, 0x0, [0x0B,off0], [0x0B,off0]
 jne [0x583], 0x0, L369
 srx 0, 9, SPR_MAC_CTLHI, 0x0, r33
 orx 0, 7, r33, r20, r20
L369:
 add [0x072], 0x1, [0x072]
 jmp L131
L370:
 jzx 0, 2, [0x06C], 0x0, L371
 orx 0, 15, 0x1, r43, r43
L371:
 or [0x042], 0x0, r33
 jge r33, [SHM_MAXBFRAMES], L385
 sub SPR_TSF_WORD0, [0x043], r33
 jg r33, [0x041], L385
 orx 0, 15, 0x1, r43, r43
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L372
 jnzx 1, 1, [SHM_HOST_FLAGS5], 0x0, L372
 jnzx 0, 8, [SHM_HOST_FLAGS3], 0x0, L372
L372:
 jmp L385
L373:
 mov 0x0, SPR_IFS_med_busy_ctl
 jnzx 0, 4, r43, 0x0, L380
 orx 0, 4, 0x1, r43, r43
 or SPR_TSF_WORD0, 0x0, [0x86E]
 orx 0, 0, 0x0, r45, r45
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L375
 je SPR_IFS_0x0e, 0x0, L375
 orx 0, 11, 0x0, r43, r43
 jnext COND_PSM(7), L374
 orx 0, 11, 0x1, r43, r43
L374:
 or [0x162], 0x0, SPR_BASE4
 calls L950
L375:
 jnext COND_PSM(7), L377
 jg r40, [0x06B], L377
 or [0x052], 0x0, r34
 jzx 1, 0, SPR_TXE0_PHY_CTL, 0x0, L376
 or [0x05A], 0x0, r34
L376:
 je r34, 0x0, L377
 sr SPR_IFS_if_tx_duration, 0x4, r33
 mul r33, r34, r33
 jg [0x87B], SPR_PSM_0x5a, L377
 or SPR_PSM_0x5a, 0x0, [0x87B]
 add [0x87B], SPR_TSF_WORD0, [0x87C]
L377:
 jzx 0, 10, r43, 0x0, L378
 mov 0x4000, SPR_TSF_GPT2_STAT
L378:
 add. [0x3B4], SPR_IFS_if_tx_duration, [0x3B4]
 addc [0x3B5], 0x0, [0x3B5]
 mov 0x1F1, r33
 calls L52
 jzx 0, 12, SPR_Ext_IHR_Data, 0x0, L379
 mov 0x164, r33
 calls L52
 orx 0, 15, 0x1, SPR_Ext_IHR_Data, r34
 calls L54
 orx 0, 15, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
L379:
 or [SHM_TSSI_CCK_HI], 0x0, SPR_IFS_CTL_SEL_PRICRS
 mov 0x40, SPR_IFS_CTL1
 jzx 0, 8, SPR_IFS_STAT, 0x0, L380
 mov 0x0, SPR_IFS_CTL1
L380:
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L384
 jne r18, 0x35, L381
 orx 0, 9, 0x0, r63, r63
L381:
 jne r18, 0x20, L382
 jnzx 0, 5, r44, 0x0, L382
 mov 0x0, [0xB44]
L382:
 jzx 0, 8, r44, 0x0, L383
 jne r18, 0x31, L383
 calls L1108
L383:
 calls L991
L384:
 orx 0, 4, 0x0, r43, r43
 jext EOI(COND_TX_DONE), L0
L385:
 jzx 0, 0, [0x0A,off0], 0x0, L399
 mov 0x0, [0x14,off0]
 jnext COND_INTERMEDIATE, L386
 orx 0, 2, 0x1, [0x09,off0], [0x09,off0]
 mov 0x0, r0
 jmp L389
L386:
 or SPR_AQM_Upd_BA0, 0x0, [0x7F2]
 or SPR_AQM_Upd_BA1, 0x0, [0x7F3]
 or SPR_AQM_Upd_BA2, 0x0, [0x7F4]
 or SPR_AQM_Upd_BA3, 0x0, [0x7F5]
 or [0x14,off0], 0x0, SPR_AQM_Max_IDX
 calls L1131
 jzx 0, 3, [0x02,off0], 0x0, L388
 jnzx 3, 4, [0x09,off0], 0x0, L388
 jne [0x7F2], SPR_AQM_Upd_BA0, L387
 jne [0x7F3], SPR_AQM_Upd_BA1, L387
 jne [0x7F4], SPR_AQM_Upd_BA2, L387
 je [0x7F5], SPR_AQM_Upd_BA3, L388
L387:
 calls L1155
L388:
 orx 0, 8, 0x1, SPR_TXE0_FIFO_PRI_RDY, SPR_TXE0_FIFO_PRI_RDY
L389:
 mov 0x87, SPR_TX_STATUS0
 or [0x18,off0], 0x0, SPR_TX_STATUS1
 or [0x17,off0], 0x0, SPR_TX_STATUS1
 or [0x16,off0], 0x0, SPR_TX_STATUS1
 or [0x15,off0], 0x0, SPR_TX_STATUS1
 or [0x0C,off0], 0x0, SPR_TX_STATUS1
 sr [0x07,off0], 0x4, SPR_TX_STATUS1
 or [0x06,off0], 0x0, SPR_TX_STATUS1
 mov 0x0, [0x12,off0]
 mov 0x0, [0x13,off0]
 mov 0x0, [0x14,off0]
 mov 0x0, [0x15,off0]
 mov 0x0, [0x16,off0]
 mov 0x0, [0x17,off0]
 mov 0x0, [0x18,off0]
 mov 0x0, [0x0C,off0]
L390:
 jnzx 0, 8, SPR_TXE0_FIFO_PRI_RDY, 0x0, L390
 jext COND_INTERMEDIATE, L391
 or SPR_AQM_Cons_Control, 0x0, r0
L391:
 orx 6, 8, r0, [0x09,off0], [0x09,off0]
 jnzx 0, 13, SPR_MAC_CTLHI, 0x0, L394
 mov 0x0, SPR_TX_STATUS0
 orx 1, 0, 0x3, [0x09,off0], SPR_TX_STATUS1
 mov 0xDEAD, r33
 jge [SHM_TXFCUR], 0x4, L393
 sub. SPR_TSF_WORD0, [0x0D,off0], r33
 subc SPR_TSF_WORD1, [0x0E,off0], r34
 mov 0x0, [0x0D,off0]
 mov 0x0, [0x0E,off0]
 je r34, 0x0, L392
 mov 0xFFFF, r33
L392:
 mov 0x0, r34
 jne r0, 0x0, L393
 sl r18, 0x2, r34
 orx 3, 8, [SHM_TXFCUR], r34, r34
 orx 3, 12, SPR_TXE0_FIFO_PRI_RDY, r34, r34
L393:
 mov 0x87, SPR_TX_STATUS0
 or SPR_TSF_WORD0, 0x0, SPR_TX_STATUS1
 or r33, 0x0, SPR_TX_STATUS1
 or [0x7F5], 0x0, SPR_TX_STATUS1
 or [0x7F4], 0x0, SPR_TX_STATUS1
 or [0x7F3], 0x0, SPR_TX_STATUS1
 or [0x7F2], 0x0, SPR_TX_STATUS1
 or [0x10,off0], 0x0, r33
 orx 7, 8, [0x11,off0], r33, SPR_TX_STATUS1
 or r34, 0x1, SPR_TX_STATUS1
L394:
 mov 0x0, [0x10,off0]
 mov 0x0, [0x11,off0]
 sub [0x1B,off0], r0, [0x1B,off0]
 sub [0x1D,off0], r0, [0x1D,off0]
 jges [0x1D,off0], 0x0, L395
 mov 0xFFFF, [0x1D,off0]
L395:
 jges [0x1B,off0], 0x0, L396
 mov 0x0, [0x1B,off0]
 mov 0x0, [0x19,off0]
L396:
 sub [0x1A,off0], r0, [0x1A,off0]
 jges [0x1A,off0], 0x0, L397
 mov 0x0, [0x1A,off0]
L397:
 jzx 0, 4, [0x02,off0], 0x0, L398
 jzx 0, 14, [0x01,off0], 0x0, L398
 add [0x3D4], r0, [0x3D4]
 add. [0x3D5], r0, [0x3D5]
 addc. [0x3D6], 0x0, [0x3D6]
 addc [0x3D7], 0x0, [0x3D7]
L398:
 jext COND_INTERMEDIATE, L400
 jnzx 0, 10, [0x6B8], 0x0, L399
 orx 12, 3, 0x0, [0x0B,off0], [0x0B,off0]
L399:
 mov 0x0, [0x0A,off0]
 orx 0, 0, 0x0, r46, r46
L400:
 orx 0, 2, 0x0, [0x09,off0], [0x09,off0]
 nand SPR_BRC, 0x1, SPR_BRC
 jext COND_4_C4, L131
 jmp L3
L401:
 jnext COND_4_C7, L425
 jext COND_4_C6, L425
 jext 0x45, L425
 orx 0, 2, 0x1, r43, r43
 jext COND_PSM(3), L425
 orx 0, 7, 0x0, SPR_BRC, SPR_BRC
 calls L348
 jnext EOI(COND_TX_PMQ), L407
 add SPR_TSF_WORD0, 0x320, [0xBFE]
 jnzx 0, 8, r44, 0x0, L402
 jnzx 0, 1, r46, 0x0, L403
 jmp L404
L402:
 orx 0, 8, 0x0, r44, r44
 or [0xB09], 0x0, r33
 jl [0xAF5], r33, L0
 add [0x09E], 0x1, [0x09E]
 mov 0x0, [0xAF5]
 calls L1109
L403:
 orx 0, 7, 0x0, SPR_BRC, SPR_BRC
 jmp L0
L404:
 jand r44, 0x90, L406
 orx 0, 7, 0x0, r44, r44
 add [0xAD8], 0x1, [0xAD8]
 jzx 0, 0, r46, 0x0, L406
 or [0xAD9], 0x0, r33
 jl [0xAD8], r33, L405
 mov 0x0, [0xAD8]
 add [0x09F], 0x1, [0x09F]
 orx 3, 4, 0x6, [0x09,off0], [0x09,off0]
 jmp L207
L405:
 mov 0xFFFF, r33
 calls L802
L406:
 add [0x09A], 0x1, [0x09A]
 orx 0, 1, 0x1, r43, r43
 jmp L408
L407:
 jext 0x48, L408
 jext EOI(COND_RX_FCS_GOOD), L427
L408:
 orx 0, 8, 0x0, SPR_BRC, SPR_BRC
 add. [0x3C4], SPR_IFS_if_tx_duration, [0x3C4]
 addc [0x3C5], 0x0, [0x3C5]
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L409
 mov 0x0, SPR_TSF_0x2a
 add 0x180, [SHM_TXFCUR], SPR_BASE5
L409:
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
 je r14, 0xC5, L410
 jne r14, 0x38, L411
L410:
 or [0x0F,off0], 0x0, SPR_BASE4
 or [0x485], 0x0, r33
 jl [0x02,off4], r33, L0
 orx 1, 4, 0x2, [0x0A,off0], [0x0A,off0]
 mov 0x0, [0x02,off4]
 jmp L0
L411:
 jne r21, 0x54, L412
 add [0x0A4], 0x1, [0x0A4]
 orx 0, 2, 0x0, SPR_BRC, SPR_BRC
 jmp L3
L412:
 jext COND_PSM(1), L417
 je r14, 0x25, L413
 orx 14, 1, r5, 0x1, r5
 and r5, r4, r5
 je r14, 0x31, L413
 jnzx 0, 8, [0x01,off0], 0x0, L417
L413:
 or r6, 0x0, r35
 or [SHM_SFFBLIM], 0x0, r36
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L414
 jg SPR_BASE5, 0x183, L414
 srx 3, 0, [0x00,off5], 0x0, r35
 srx 3, 4, [0x00,off5], 0x0, r36
L414:
 jl r11, r36, L415
 calls L811
L415:
 add r12, 0x1, r12
 jne r12, r35, L416
 or r3, 0x0, r5
L416:
 jge r11, r35, L421
 jmp L424
L417:
 or r7, 0x0, r35
 or [SHM_LFFBLIM], 0x0, r36
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L418
 jg SPR_BASE5, 0x183, L418
 srx 3, 8, [0x00,off5], 0x0, r35
 srx 3, 12, [0x00,off5], 0x0, r36
L418:
 jl r11, r36, L419
 calls L811
L419:
 add r13, 0x1, r13
 jne r13, r35, L420
 or r3, 0x0, r5
L420:
 jl r11, r35, L424
L421:
 orx 0, 11, 0x0, SPR_BRC, SPR_BRC
 jext EOI(COND_TX_PMQ), L422
L422:
 jne r14, 0x31, L423
 srx 1, 2, [0x0A,off0], 0x0, r33
 jne r33, 0x3, L423
 add [0x12,off0], 0x1, [0x12,off0]
 orx 3, 8, 0x0, [0x09,off0], [0x09,off0]
 or [0x13,off0], 0x0, r11
 add r11, [0x12,off0], r11
 jl r11, r35, L424
L423:
 calls L909
 orx 0, 3, 0x1, [0x0B,off0], [0x0B,off0]
 jmp L385
L424:
 calls L909
L425:
 jext EOI(COND_TX_PMQ), L426
L426:
 jext COND_INTERMEDIATE, L385
 jmp L3
L427:
 add. [0x3C2], SPR_IFS_if_tx_duration, [0x3C2]
 addc [0x3C3], 0x0, [0x3C3]
 jnzx 0, 0, [0x06C], 0x0, L3
 or r3, 0x0, r5
 jnext COND_PSM(7), L428
 jzx 0, 6, [0x02,off0], 0x0, L428
 sr r3, 0x1, r5
L428:
 calls L909
 je r14, 0xC5, L356
 jne r14, 0x38, L429
 or [0x0F,off0], 0x0, SPR_BASE4
 or [0x00,off4], 0x100, r33
 orx 4, 0, r24, r33, [0x00,off4]
 srx 4, 0, r33, 0x0, r24
 orx 1, 4, 0x0, [0x0A,off0], [0x0A,off0]
 add [0x03,off4], 0x1, [0x03,off4]
 mov 0x0, [0x02,off4]
 jmp L3
L429:
 je r14, 0x31, L433
 jext 0x42, L430
 jzx 0, 6, [0x08,off6], 0x0, L430
 jnzx 0, 8, [0x4B4], 0x0, L430
 or [0x6BA], 0x0, [0x4B5]
 or [0x6BB], 0x0, [0x4B6]
 or [0x6BC], 0x0, [0x4B7]
 orx 1, 12, r47, [0x4B4], [0x4B4]
 or [0x4B4], 0x100, [0x4B4]
L430:
 mov 0x0, r12
 jext 0x42, L435
 jzx 0, 10, [0x01,off0], 0x0, L432
 or [SHM_MAXBFRAMES], 0x0, r33
 jge [0x042], r33, L432
 sub SPR_TSF_WORD0, [0x043], r33
 jg r33, [0x041], L432
 jzx 0, 1, [SHM_HOST_FLAGS2], 0x0, L431
 jnzx 0, 1, [0x03,off1], 0x0, L432
L431:
 orx 0, 15, 0x1, r43, r43
L432:
 jzx 0, 8, [0x01,off0], 0x0, L434
 mov 0x0, r13
 jmp L434
L433:
 mov 0x0, r12
 add [0x11,off0], 0x1, [0x11,off0]
 jnext COND_PSM(1), L131
 orx 3, 8, 0x0, [0x09,off0], [0x09,off0]
 jmp L131
L434:
 orx 0, 15, 0x1, [0x09,off0], [0x09,off0]
 jmp L1133
L435:
 add [0x0A5], 0x1, [0x0A5]
L436:
 orx 0, 2, 0x0, SPR_BRC, SPR_BRC
 mov 0x0, [0x86C]
 add [0x05E], 0x5, [0x05E]
 mov 0x680, r33
 jl [0x05E], r33, L3
 mov 0x644, [0x05E]
 jmp L3
L437:
 js 0x300, SPR_TXE0_0x76, L438
 calls L727
 jmp L131
L438:
 jzx 0, 10, SPR_IFS_0x32, 0x0, L43
 jext EOI(COND_TX_NAV), L43
L439:
 mov 0x25, r18
 mov 0x20, r33
 mov 0xFFFF, SPR_TME_MASK34
 or [0x05,off1], 0x0, SPR_TME_VAL22
 or [0x06,off1], 0x0, SPR_TME_VAL24
 or [0x07,off1], 0x0, SPR_TME_VAL26
 mov 0x0, SPR_TME_VAL14
 jnzx 0, 12, [SHM_HOST_FLAGS2], 0x0, L444
 or [0x08,off2], 0x0, r34
 jges r34, [0x04,off1], L440
 sub [0x04,off1], r34, SPR_TME_VAL14
L440:
 jne [0x86B], 0x0, L444
 or [0x0A,off2], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x0B,off2], 0x0, SPR_TX_PLCP_HT_Sig1
 mov 0x0, SPR_TME_VAL14
 jmp L448
L441:
 mov 0x14, r33
 mov 0xC4, SPR_TME_VAL22
 mov 0x0, SPR_TME_VAL24
 mov 0x0, SPR_TME_VAL26
 jmp L444
L442:
 jext COND_4_C9, L572
 jext COND_PSM(2), L572
L443:
 mov 0xE, r33
L444:
 jzx 0, 12, [SHM_HOST_FLAGS2], 0x0, L445
 jnzx 0, 1, r23, 0x0, L447
L445:
 or [0x02,off2], 0x0, SPR_TX_PLCP_HT_Sig1
 je [0x86B], 0x1, L446
 or [0x01,off2], 0x0, SPR_TX_PLCP_HT_Sig0
 jmp L448
L446:
 orx 10, 5, r33, [0x01,off2], SPR_TX_PLCP_HT_Sig0
 jmp L448
L447:
 orx 7, 8, r33, [0x00,off1], SPR_TX_PLCP_HT_Sig0
 mov 0x700, SPR_TX_PLCP_HT_Sig1
 mov 0x0, SPR_TX_PLCP_HT_Sig2
L448:
 nand SPR_MHP_Addr2_Low, 0x1, SPR_TME_VAL16
 or SPR_MHP_Addr2_Mid, 0x0, SPR_TME_VAL18
 or SPR_MHP_Addr2_High, 0x0, SPR_TME_VAL20
 calls L901
 jext COND_PSM(2), L599
 je r19, 0x21, L454
 mov 0xFFFF, SPR_TME_MASK12
 je r19, 0xB5, L449
 je r19, 0x2D, L450
 mov MAC_SUBTYPE_CONTROL_ACK, SPR_TME_VAL12
 mov 0x35, r18
 je r19, 0x29, L454
 jmp L452
L449:
 mov 0xC5, r18
 mov 0x74, SPR_TME_VAL12
 jmp L451
L450:
 mov 0x31, r18
 mov MAC_SUBTYPE_CONTROL_CTS, SPR_TME_VAL12
L451:
 jnzx 3, 0, SPR_TSF_0x02, 0x0, L649
 jnzx 0, 0, SPR_NAV_STAT, 0x0, L649
L452:
 jnzx 0, 12, [SHM_HOST_FLAGS2], 0x0, L454
 or [0x03,off2], 0x0, r33
 jne r19, 0xB5, L453
 or [0x09,off2], 0x0, r33
L453:
 sub r33, [0x006], r33
 add r33, [SHM_EDCFSTAT], r33
 jgs r33, [0x04,off1], L454
 sub [0x04,off1], r33, SPR_TME_VAL14
 jmp L455
L454:
 mov 0x0, SPR_TME_VAL14
 jnext 0x71, L455
 orx 0, 15, 0x1, SPR_TME_VAL14, SPR_TME_VAL14
L455:
 orx 2, 0, 0x2, SPR_BRC, SPR_BRC
 mov 0x4021, r17
 je r19, 0xB5, L687
 je r19, 0x2D, L649
 jext COND_RX_COMPLETE, L572
 jmp L0
L456:
 jles SPR_TME_VAL14, 0x0, L459
 sub SPR_TME_VAL14, [0x006], SPR_TME_VAL14
 jzx 0, 4, SPR_TXE0_PHY_CTL, 0x0, L458
 sr [0x006], 0x1, r33
 jand SPR_TXE0_PHY_CTL, 0x2, L457
 or [0x874], 0x0, r33
L457:
 add SPR_TME_VAL14, r33, SPR_TME_VAL14
L458:
 jges SPR_TME_VAL14, 0x0, L459
 mov 0x0, SPR_TME_VAL14
L459:
 rets
L460:
 srx 0, 3, SPR_TXE0_PHY_CTL, 0x0, r33
 or [0x408], 0x0, SPR_TX_PLCP_HT_Sig0
 or [0x409], 0x0, SPR_TX_PLCP_HT_Sig1
 or [0x40A], 0x0, SPR_TX_PLCP_HT_Sig2
 add [0x3DD], r33, [0x3DD]
 jzx 0, 1, SPR_TXE0_PHY_CTL, 0x0, L464
 jnzx 0, 4, SPR_TXE0_PHY_CTL, 0x0, L461
 orx 10, 5, SPR_TDC_VHT_L_Sig_Len, [0x4D5], SPR_TX_PLCP_Sig0
 srx 0, 11, SPR_TDC_VHT_L_Sig_Len, 0x0, SPR_TX_PLCP_Sig1
L461:
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L463
 xor r33, 0x1, r33
 orx 0, 11, 0x0, SPR_TX_PLCP_HT_Sig1, SPR_TX_PLCP_HT_Sig1
 jnext COND_PSM(1), L462
 orx 0, 11, 0x1, SPR_TX_PLCP_HT_Sig1, SPR_TX_PLCP_HT_Sig1
L462:
 orx 0, 8, r33, SPR_TX_PLCP_HT_Sig1, SPR_TX_PLCP_HT_Sig1
 jmp L464
L463:
 or SPR_TDC_VHT_Sig_B0, 0x0, SPR_TX_PLCP_VHT_SigB0
 or SPR_TDC_VHT_Sig_B1, 0x0, SPR_TX_PLCP_VHT_SigB1
 orx 0, 0, r33, SPR_TX_PLCP_HT_Sig2, SPR_TX_PLCP_HT_Sig2
L464:
 rets
L465:
 mov 0x7, SPR_TXE0_FIFO_PRI_RDY
 sub r34, 0x0, r34
 srx 6, 9, r34, 0x0, SPR_TXE0_FIFO_Head
 srx 8, 0, r34, 0x0, SPR_TXE0_FIFO_Read_Pointer
 orx 8, 7, 0x10B, SPR_TXE0_FIFO_Head, SPR_TXE0_FIFO_Head
 rets
L466:
 jzx 0, 8, SPR_BRPO0, 0x0, L473
 orx 0, 12, 0x0, r63, r63
 orx 0, 8, 0x1, r45, r45
 jzx 0, 6, SPR_BTCX_Transmit_Control, 0x0, L467
 orx 0, 12, 0x1, r63, r63
 orx 0, 8, 0x0, r45, r45
L467:
 add. [0x3C0], SPR_IFS_0x0e, [0x3C0]
 addc [0x3C1], 0x0, [0x3C1]
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L468
 orx 0, 11, 0x0, r43, r43
 calls L950
L468:
 jnzx 3, 0, SPR_IFS_0x4a, 0x0, L469
 and [SHM_TSSI_CCK_HI], 0xF, SPR_IFS_CTL_SEL_PRICRS
 or [SHM_TSSI_CCK_HI], 0x0, SPR_IFS_CTL_SEL_PRICRS
 orx 0, 4, 0x1, SPR_IFS_CTL, SPR_IFS_CTL
 jmp L40
L469:
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L470
 jzx 0, 0, [0x3C9], 0x0, L470
 mov 0xC000, SPR_TSF_GPT2_STAT
L470:
 mov 0x0, SPR_IFS_med_busy_ctl
 mov 0x8, [0xBF7]
 orx 0, 8, 0x0, SPR_BRPO0, SPR_BRPO0
 orx 0, 5, 0x0, r46, r46
 mov 0x1F0, r33
 calls L52
 srx 4, 0, SPR_Ext_IHR_Data, 0x0, r33
 jne r33, 0xE, L471
 orx 0, 5, 0x1, r46, r46
L471:
 jzx 0, 10, r43, 0x0, L472
 orx 0, 15, 0x1, SPR_TSF_GPT2_STAT, SPR_TSF_GPT2_STAT
L472:
 jmp L0
L473:
 orx 0, 12, 0x0, r63, r63
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L474
 jzx 0, 1, [0x3C9], 0x0, L474
 mov 0xC000, SPR_TSF_GPT2_STAT
L474:
 or [SHM_TSSI_CCK_HI], 0x0, SPR_IFS_CTL_SEL_PRICRS
 jnzx 0, 11, SPR_IFS_STAT, 0x0, L475
 orx 0, 8, 0x1, SPR_BRPO0, SPR_BRPO0
 jzx 0, 1, r63, 0x0, L475
 orx 0, 1, 0x0, r63, r63
 je [0xB0D], 0x0, L475
 add SPR_TSF_WORD0, [0xB0C], [0xB0D]
L475:
 jzx 0, 10, r43, 0x0, L476
 mov 0x4000, SPR_TSF_GPT2_STAT
L476:
 jnzx 0, 7, SPR_RXE_0x1a, 0x0, L3
 add [0x087], 0x1, [0x087]
 orx 0, 4, 0x1, SPR_IFS_CTL, SPR_IFS_CTL
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L477
 jzx 0, 5, [0x3C9], 0x0, L477
 mov 0xC000, SPR_TSF_GPT2_STAT
L477:
 mov 0x8, [0xBF7]
 jzx 0, 5, r46, 0x0, L3
 add [0x0AC], 0x1, [0x0AC]
 jmp L3
L478:
 // csi copied initialization
 mov 0, [SHM_CSI_COPIED]
 jnzx 0, 2, SPR_RXE_FIFOCTL1, 0x0, L0
 mov 0x1F1, r33
 calls L52
 jzx 0, 12, SPR_Ext_IHR_Data, 0x0, L483
L479:
 jzx 0, 14, SPR_RXE_0x1a, 0x0, L479
 srx 7, 8, SPR_RXE_PHYRXSTAT2, 0x0, r33
 jge r33, [0x402], L481
 jge r33, [0x403], L480
 add [0x406], 0x1, [0x406]
 jmp L482
L480:
 add [0x405], 0x1, [0x405]
 jmp L482
L481:
 add [0x404], 0x1, [0x404]
L482:
 add [0x0AD], 0x1, [0x0AD]
 jmp L719
L483:
 orx 1, 8, 0x3, SPR_TXE0_0x76, SPR_TXE0_0x76
 jzx 0, 0, SPR_TXE0_CTL, 0x0, L484
 orx 0, 8, 0x0, r44, r44
L484:
 mov 0x0, SPR_TXE0_CTL
 mov 0x7E5, SPR_BASE1
 and [SHM_TSSI_CCK_HI], 0xF, SPR_IFS_CTL_SEL_PRICRS
 mov 0xFFFF, [0xC1F]
 jzx 14, 0, [0x7AE], 0x0, L485
 jne SPR_Received_Frame_Count, 0x0, L485
 or [0x7AF], 0x0, SPR_PSO_RX_Cnt_Watermark
L485:
 jext COND_4_C7, L486
 orx 2, 0, 0x0, SPR_BRC, SPR_BRC
L486:
 or SPR_TSF_WORD0, 0x0, r30
 or SPR_TSF_WORD1, 0x0, r29
 or SPR_TSF_WORD2, 0x0, r28
 or SPR_TSF_WORD3, 0x0, r27
 add [0x088], 0x1, [0x088]
 srx 2, 10, SPR_RXE_ENCODING, 0x0, r23
 mov 0x143, r33
 calls L52
 srx 3, 12, SPR_Ext_IHR_Data, 0x0, r33
 mov 0x2, r47
 je r33, 0xF, L487
 mov 0x1, r47
 je r33, 0x3, L487
 je r33, 0xC, L487
 mov 0x0, r47
L487:
 jne [0xC08], 0x0, L488
 or SPR_RXE_ENCODING, 0x0, [0xC14]
L488:
 jzx 0, 13, [SHM_HOST_FLAGS1], 0x0, L489
 mov 0x256, r33
 mov 0xE0, r34
 calls L54
 or SPR_TSF_WORD0, 0x0, [0xBFE]
L489:
 or [SHM_CHAN], 0x0, [RX_HDR_RxChan]
 mov 0x83, r22
 orx 2, 2, 0x0, SPR_PSM_COND, SPR_PSM_COND
 jnzx 0, 12, SPR_RXE_0x1a, 0x0, L490
 add [0x0AE], 0x1, [0x0AE]
 jmp L704
L490:
 mov 0x0, SPR_WEP_CTL
 mov 0x6, SPR_RXE_0x54
 orx 6, 6, 0x1, 0x0, SPR_RXE_FIFOCTL1
 mov 0x3, SPR_TXBA_Control
 mov 0x2041, SPR_BRWK0
 mov 0x18, SPR_BRWK1
 mov 0x0, SPR_BRWK2
 mov 0x600, SPR_BRWK3
L491:
 nap
 calls L990
 jnext EOI(COND_RX_COMPLETE), L491
 jl SPR_RXE_FRAMELEN, 0x6, L720
 sl [0x4D7], 0x3, SPR_IFS_0x06
 je r23, 0x3, L497
 je r23, 0x2, L496
 je r23, 0x1, L494
 sl [0x527], 0x3, SPR_IFS_0x06
 mov 0xB000, r33
 jnzx 0, 0, [0x00,off1], 0x0, L492
 orx 2, 12, [0x00,off1], 0x0, r33
L492:
 mul r33, [0x01,off1], r26
 jzx 0, 6, [0x00,off1], 0x0, L493
 add r26, [0x01,off1], r26
 jzx 0, 15, [0x00,off1], 0x0, L493
 sub r26, 0x1, r26
L493:
 jnzx 3, 12, r26, 0x0, L720
 jmp L497
L494:
 srx 10, 5, [0x00,off1], 0x0, r33
 orx 0, 11, [0x01,off1], r33, r26
 jg r26, [0x010], L495
 jnzx 0, 3, [0x00,off1], 0x0, L497
L495:
 mov 0x2, SPR_IFS_0x06
 calls L928
 jmp L719
L496:
 srx 7, 8, [0x00,off1], 0x0, r33
 orx 7, 8, [0x01,off1], r33, r26
 jg r26, [0x05D], L720
 je r26, 0x0, L720
L497:
 jzx 0, 9, SPR_RXE_ENCODING, 0x0, L501
L498:
 jnzx 0, 14, SPR_RXE_0x1a, 0x0, L704
 calls L990
 jnzx 0, 15, SPR_RXE_0x56, 0x0, L498
L499:
 orx 0, 15, 0x0, r20, r20
 jnzx 0, 14, SPR_RXE_0x56, 0x0, L500
 orx 0, 2, 0x1, SPR_PSM_COND, SPR_PSM_COND
L500:
 jnzx 0, 15, SPR_RXE_0x56, 0x0, L702
 srx 13, 0, SPR_RXE_0x56, 0x0, r26
L501:
 jnzx 1, 14, r26, 0x0, L720
 or r26, 0x0, SPR_WEP_WKey
 or SPR_BRC, 0x140, SPR_BRC
 orx 0, 0, 0x0, r20, r20
 orx 0, 12, 0x0, r44, r44
 orx 0, 9, 0x0, SPR_BRC, SPR_BRC
 srx 13, 0, SPR_RXE_0x56, 0x0, SPR_RXE_0x54
 je SPR_RXE_0x54, 0x0, L502
 jle SPR_RXE_0x54, 0x8, L702
L502:
 orx 7, 6, r22, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 jzx 0, 6, r22, 0x0, L503
 jzx 2, 0, SPR_WEP_CTL, 0x0, L503
 jle r26, 0x34, L652
 orx 4, 4, 0x1D, SPR_WEP_CTL, SPR_WEP_CTL
L503:
 jext COND_RX_COMPLETE, L504
 calls L990
 jzx 0, 0, SPR_MHP_Status, 0x0, L503
L504:
#define SPIN_LENGTH (6 + 16)
#define SPARE1 r54
 mov 0, r55
spin_rx_header:
 jext COND_RX_COMPLETE, skip+
 jl SPR_RXE_FRAMELEN, SPIN_LENGTH, spin_rx_header
spin_rx_end:
 jl SPR_RXE_FRAMELEN, SPIN_LENGTH, skip+
 and [CMP_FRM_CTRL_FLD], 0xfc, SPARE1
 and [3,off1], 0xfc, r56
 jne SPARE1, r56, skip+
 mov [CMP_DST_MAC_0], SPARE1
 jne [5,off1], SPARE1, skip+
 mov [CMP_DST_MAC_1], SPARE1
 jne [6,off1], SPARE1, skip+
 mov [CMP_DST_MAC_2], SPARE1
 jne [7,off1], SPARE1, skip+
 //add [COUNTER], 1, [COUNTER]
 //and [COUNTER], 0x3, [COUNTER]
 //jne [COUNTER], 0, skip+
 mov 1, r55
 or [5,off1], 0x0, [CMP_DST_MAC_SAVE_0]
 or [6,off1], 0x0, [CMP_DST_MAC_SAVE_1]
 or [7,off1], 0x0, [CMP_DST_MAC_SAVE_2]
 jext COND_RX_COMPLETE, skip+
 jne [SHM_CSI_COLLECT], 1, skip+
 // check the encoding
 // register 23 contains the frame encoding
 and SPR_RXE_PHYRXSTAT0, 0x3, SPARE1
 jne r23, 0x0, localskip+
 add [0x8bd], 1, [0x8bd]
localskip:
 jne r23, 0x1, localskip+
 add [0x8be], 1, [0x8be]
localskip:
 jne r23, 0x2, localskip+
 add [0x8bf], 1, [0x8bf]
localskip:
 // store source mac address in frames d11rxhdr
 or [8,off1], 0x0, [RX_HDR_NEXMON_SrcMac0]
 or [9,off1], 0x0, [RX_HDR_NEXMON_SrcMac1]
 or [10,off1], 0x0, [RX_HDR_NEXMON_SrcMac2]
 // skip csi collection for 802.11b frames
 je r23, 0x0, skip+
 // clear rx header
 mov RX_HDR_BASE + RX_HDR_LEN, SPARE1
 mov RX_HDR_BASE + (17 * RX_HDR_LEN), SPR_BASE5
erase_hdr:
 mov 0x0, [0x00,off5]
 sub SPR_BASE5, 0x1, SPR_BASE5
 jges SPR_BASE5, SPARE1, erase_hdr-
 phy_reg_write(0x00d,73)
 mov 0, SPARE1
 mov (RX_HDR_BASE + RX_HDR_LEN), SPR_BASE5
 // copy CSI information for 1st 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2, SPR_BASE5
repeat:
 phy_reg_write(0x00e, SPARE1)
 phy_reg_read_to_shm_off(0x00f, 0, off5)
 phy_reg_read_to_shm_off(0x010, 1, off5)
 add SPR_BASE5, 2, SPR_BASE5
 add SPARE1, 1, SPARE1
 jl SPARE1, 15, repeat-
 // copy CSI information for 2nd 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2, SPR_BASE5
repeat:
 phy_reg_write(0x00e, SPARE1)
 phy_reg_read_to_shm_off(0x00f, 0, off5)
 phy_reg_read_to_shm_off(0x010, 1, off5)
 add SPR_BASE5, 2, SPR_BASE5
 add SPARE1, 1, SPARE1
 jl SPARE1, 30, repeat-
 // copy CSI information for 3rd 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2, SPR_BASE5
repeat:
 phy_reg_write(0x00e, SPARE1)
 phy_reg_read_to_shm_off(0x00f, 0, off5)
 phy_reg_read_to_shm_off(0x010, 1, off5)
 add SPR_BASE5, 2, SPR_BASE5
 add SPARE1, 1, SPARE1
 jl SPARE1, 45, repeat-
 // copy CSI information for 4th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2, SPR_BASE5
repeat:
 phy_reg_write(0x00e, SPARE1)
 phy_reg_read_to_shm_off(0x00f, 0, off5)
 phy_reg_read_to_shm_off(0x010, 1, off5)
 add SPR_BASE5, 2, SPR_BASE5
 add SPARE1, 1, SPARE1
 jl SPARE1, 60, repeat-
 // copy CSI information for 5th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2, SPR_BASE5
repeat:
 phy_reg_write(0x00e, SPARE1)
 phy_reg_read_to_shm_off(0x00f, 0, off5)
 phy_reg_read_to_shm_off(0x010, 1, off5)
 add SPR_BASE5, 2, SPR_BASE5
 add SPARE1, 1, SPARE1
 jl SPARE1, 75, repeat-
 // copy CSI information for 6th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 7th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 8th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 9th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 10th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 11th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 12th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 13th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 14th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 15th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 16th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // copy CSI information for 17th 15 subcarriers
 or 2, 0x0, [0, off5]
 or 15, 0x0, [1, off5]
 add SPR_BASE5, 2*16, SPR_BASE5
 // indicate the end of CSI being copied
 mov 1, [SHM_CSI_COPIED]
skip:
 srx 5, 1, SPR_MHP_Status, 0x0, SPR_WEP_IV_Key
 add SPR_WEP_IV_Key, 0x6, SPR_WEP_IV_Key
 mov 0x0, [RX_HDR_RxStatus1]
 orx 1, 1, 0x3, 0x0, [RX_HDR_RxStatus2]
 jl SPR_RXE_FRAMELEN, 0x10, L571
 srx 5, 2, SPR_MHP_FC, 0x0, r19
 srx 1, 2, SPR_MHP_FC, 0x0, r42
 jne r19, 0x1D, L505
 srx 5, 2, SPR_MHP_CFG, 0x0, r19
 orx 5, 2, r19, 0x1, r19
L505:
 srx 0, 8, SPR_MHP_Status, 0x0, r33
 orx 0, 13, r33, r20, r20
 mov 0x1, r1
 jnzx 0, 1, SPR_WEP_IV_Key, 0x0, L506
 mov 0x0, r1
L506:
 mov 0x1, SPR_DAGG_CTL2
L507:
 jzx 0, 0, SPR_AMT_Status, 0x0, L507
 jext COND_PSM(4), L511
 mov 0xFFFF, [0x582]
 jnext 0x61, L508
 srx 5, 0, SPR_AMT_Match1, 0x0, r33
 jmp L510
L508:
 jnext 0x62, L509
 srx 5, 8, SPR_AMT_Match1, 0x0, r33
 jmp L510
L509:
 jnext 0x63, L511
 srx 5, 0, SPR_AMT_Match2, 0x0, r33
L510:
 add 0x334, r33, SPR_BASE5
 srx 1, 8, [0x00,off5], 0x0, [0x582]
L511:
 jzx 0, 7, SPR_MHP_QOS, 0x0, L513
 jnzx 0, 8, SPR_MAC_CTLHI, 0x0, L512
 jnext 0x61, L513
L512:
 orx 2, 0, 0x3, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 add SPR_WEP_IV_Key, 0xC, SPR_DAGG_SH_OFFSET
 add r26, 0xE, [0x873]
 xor r1, 0x1, r1
L513:
 orx 0, 5, r1, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 orx 0, 2, r1, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 jext COND_PSM(4), L531
 jext 0x61, L523
 jnzx 0, 15, [0x04,off1], 0x0, L531
 or [0x04,off1], 0x0, SPR_NAV_ALLOCATION
 orx 4, 11, 0x2, SPR_NAV_CTL, SPR_NAV_CTL
 orx 0, 8, 0x0, SPR_PSM_COND, SPR_PSM_COND
 mov 0xFFFF, r25
 jne r42, 0x1, L514
 and r19, 0xFFFB, r33
 jne r33, 0x39, L519
 jmp L515
L514:
 jnzx 0, 8, [0x03,off1], 0x0, L519
 jzx 0, 9, [0x03,off1], 0x0, L516
L515:
 jnext 0x62, L519
 srx 5, 8, SPR_AMT_Match1, 0x0, r34
 jmp L517
L516:
 jnext 0x63, L519
 srx 5, 0, SPR_AMT_Match2, 0x0, r34
L517:
 je [0x582], 0x0, L518
 jzx 0, 0, [0x05,off1], 0x0, L519
 or r34, 0x0, r25
L518:
 orx 0, 8, 0x1, SPR_PSM_COND, SPR_PSM_COND
L519:
 jzx 0, 3, [SHM_HOST_FLAGS4], 0x0, L522
 jnzx 0, 0, [0x05,off1], 0x0, L522
 je r23, 0x3, L522
 or [0x00,off1], 0x0, SPR_TDC_PLCP0
 or [0x01,off1], 0x0, SPR_TDC_PLCP1
 or r26, 0x0, SPR_TDC_Frame_Length0
 mov 0x0, SPR_TDC_Frame_Length1
 jne r23, 0x2, L520
 or [0x02,off1], 0x0, SPR_TDC_Frame_Length1
L520:
 orx 1, 1, r23, 0x9, SPR_TDCCTL
L521:
 jnzx 0, 0, SPR_TDCCTL, 0x0, L521
 add r30, SPR_TDC_TX_Time, [0x7D1]
 jmp L838
L522:
 jzx 0, 0, [0x05,off1], 0x0, L531
 jnext 0x62, L531
L523:
 orx 0, 12, 0x0, SPR_NAV_CTL, SPR_NAV_CTL
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L531
 orx 0, 1, 0x0, [0xB42], [0xB42]
 jzx 0, 0, [0x05,off1], 0x0, L525
 jne r19, 0x20, L524
 or [0xAEF], 0x0, r34
 jge r34, [0xAE2], L526
L524:
 jzx 0, 5, [0xB05], 0x0, L529
L525:
 jne r23, 0x0, L529
 or [0xB1F], 0x0, r33
 je [0xAE0], 0x0, L529
 or [0xB1E], 0x0, r34
 jge [0xAE0], r34, L529
 jne r42, 0x2, L528
L526:
 jl [0xB20], r33, L527
 or [0xB4C], 0x0, [0xB4B]
L527:
 orx 0, 9, 0x1, r63, r63
L528:
 jne r19, 0x14, L529
 calls L1162
 jzx 0, 13, r63, 0x0, L529
 add [0xB2B], 0x1, [0xB2B]
L529:
 jne r23, 0x0, L530
 jne r42, 0x2, L530
 orx 0, 1, 0x1, [0xB42], [0xB42]
L530:
 je [0xB0D], 0x0, L531
 orx 0, 1, 0x1, r63, r63
L531:
 jzx 0, 14, [0x03,off1], 0x0, L547
 add SPR_DAGG_SH_OFFSET, 0x4, SPR_DAGG_SH_OFFSET
 sub [0x873], 0x4, [0x873]
 jnzx 0, 4, SPR_WEP_CTL, 0x0, L545
 mov 0xFFFF, r37
 jl SPR_RXE_FRAMELEN, 0x16, L571
 je r19, 0x2C, L532
 jne r42, 0x2, L547
L532:
 jext 0x61, L533
 jzx 0, 0, [0x05,off1], 0x0, L547
 jzx 0, 11, [SHM_HOST_FLAGS4], 0x0, L535
L533:
 jnext 0x62, L534
 srx 5, 8, SPR_AMT_Match1, 0x0, r33
 je r33, 0x3E, L534
 or r33, 0x0, r37
 add r37, 0x4, r37
L534:
 jne r37, 0xFFFF, L535
 jnzx 0, 0, [0x05,off1], 0x0, L547
 jzx 0, 14, [SHM_HOST_FLAGS1], 0x0, L547
L535:
 mov 0x7E5, r34
 sr SPR_WEP_IV_Key, 0x1, SPR_BASE5
 add SPR_BASE5, r34, SPR_BASE5
 add SPR_WEP_IV_Key, 0x8, [0xC35]
L536:
 jext COND_RX_COMPLETE, L537
 calls L990
 jl SPR_RXE_FRAMELEN, [0xC35], L536
L537:
 jl SPR_RXE_FRAMELEN, [0xC35], L571
 mov 0x2F0, r33
 jne r37, 0xFFFF, L538
 srx 1, 14, [0x01,off5], 0x0, r37
 jnext 0x3D, L538
 jzx 0, 0, [0x05,off1], 0x0, L538
 jnext COND_PSM(8), L547
 je r25, 0xFFFF, L538
 add r25, 0x4, r25
 add r25, r33, SPR_BASE4
 srx 5, 4, [0x00,off4], 0x0, r25
 srx 0, 1, r37, 0x0, r37
 add r25, r37, r25
 add r25, 0x1, r25
 srx 2, 10, [0x00,off4], 0x0, r38
 jmp L541
L538:
 add r37, r33, SPR_BASE4
 srx 5, 4, [0x00,off4], 0x0, r25
 jzx 0, 11, [SHM_HOST_FLAGS4], 0x0, L540
 orx 0, 5, 0x0, r25, r25
 jzx 0, 0, [0x05,off1], 0x0, L540
 srx 2, 13, [0x00,off4], 0x0, r38
 srx 1, 14, [0x01,off5], 0x0, r36
 srx 1, 9, [0x00,off4], 0x0, r33
 jne r36, r33, L539
 add r25, 0x10, r25
 jmp L542
L539:
 srx 1, 11, [0x00,off4], 0x0, r33
 jne r36, r33, L547
 add r25, 0x20, r25
 jmp L542
L540:
 srx 2, 0, [0x00,off4], 0x0, r38
L541:
 jne r38, 0x7, L542
 orx 0, 3, [0x00,off5], 0x0, r33
 xor r33, [0x00,off4], r33
 jnzx 0, 3, r33, 0x0, L547
L542:
 sl r25, 0x3, r0
 add [SHM_KTP], r0, SPR_BASE4
 orx 5, 5, r25, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 orx 0, 6, 0x1, r38, SPR_WEP_CTL
 jne r38, 0x2, L543
 sub [0x873], 0x8, [0x873]
 mov 0x882, r1
 sl r37, 0x3, r33
 sub r33, r37, SPR_BASE3
 mov 0x170, r33
 add SPR_BASE3, r33, SPR_BASE3
 or [0x05,off3], 0x0, r33
 or [0x06,off3], 0x0, r34
 jne r33, [0x02,off5], L547
 jne r34, [0x03,off5], L547
 calls L911
 mov 0x880, SPR_BASE4
 jzx 0, 15, [0x061], 0x0, L543
 jge r0, 0x60, L543
 jnzx 0, 10, [0x03,off1], 0x0, L543
 jnzx 3, 0, [0x0E,off1], 0x0, L543
 orx 0, 13, 0x1, SPR_WEP_CTL, SPR_WEP_CTL
 orx 0, 3, 0x1, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 add r0, [0x059], r35
 add r35, 0x4, r35
L543:
 calls L916
 jl r38, 0x5, L544
 jle r26, 0x34, L652
L544:
 add SPR_WEP_IV_Key, 0x14, r33
 jl r26, r33, L652
 orx 4, 4, 0x15, SPR_WEP_CTL, SPR_WEP_CTL
 jl r38, 0x5, L546
L545:
 add SPR_DAGG_SH_OFFSET, 0x4, SPR_DAGG_SH_OFFSET
 sub [0x873], 0x4, [0x873]
L546:
 orx 0, 3, 0x1, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 orx 5, 5, r25, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 jmp L548
L547:
 orx 4, 4, 0x15, 0x0, SPR_WEP_CTL
 orx 0, 3, 0x0, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
L548:
 jne r19, 0x38, L550
 jnext 0x61, L550
 jnext COND_4_C7, L550
 jne r19, r14, L550
 sr SPR_WEP_IV_Key, 0x1, r33
 add SPR_BASE1, r33, SPR_BASE5
 mov 0x607, r33
 add SPR_WEP_IV_Key, 0x5, SPR_Bfm_Rpt_Offset
 je [0x00,off5], 0x15, L549
 jne [0x00,off5], r33, L550
 add SPR_WEP_IV_Key, 0x8, SPR_Bfm_Rpt_Offset
L549:
 add [0x3E0], 0x1, [0x3E0]
 orx 0, 15, 0x0, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
 orx 0, 8, 0x0, SPR_BRC, SPR_BRC
 mov 0x440, r33
 or [0x01,off5], 0x0, r34
 calls L54
 sub r26, SPR_Bfm_Rpt_Offset, SPR_Bfm_Rpt_Length
 add SPR_Bfm_Rpt_Length, 0x2, SPR_Bfm_Rpt_Length
 mov 0x2, SPR_TX_BF_Control
 jext EOI(COND_TX_PMQ), L550
L550:
 jzx 0, 0, [RX_HDR_RxStatus2], 0x0, L551
 sub [0x873], SPR_DAGG_SH_OFFSET, SPR_DAGG_BYTESLEFT
 jles SPR_DAGG_BYTESLEFT, 0xE, L551
 mov 0xF, SPR_DAGG_CTL2
 orx 0, 5, 0x1, r20, r20
L551:
 jzx 0, 7, [SHM_HOST_FLAGS1], 0x0, L552
 orx 1, 8, 0x1, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 jmp L556
L552:
 jzx 0, 1, [0x7AE], 0x0, L553
 jnzx 0, 0, [0x05,off1], 0x0, L554
 jext 0x61, L555
 jmp L556
L553:
 jzx 0, 0, [0x7AE], 0x0, L555
 jne r19, 0x20, L555
L554:
 orx 0, 14, 0x1, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 jmp L556
L555:
 mov 0x0, SPR_PSO_RX_Cnt_Watermark
L556:
 orx 1, 0, 0x2, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 mov 0xC3, r22
 jext COND_NEED_RESPONSEFR, L560
 je r19, 0x35, L561
 srx 7, 0, [0x00,off1], 0x0, r0
 or r23, 0x0, r1
 jne r23, 0x3, L557
 srx 3, 12, [0x01,off1], 0x0, r0
L557:
 jzx 0, 4, r45, 0x0, L559
 je r1, 0x0, L558
 mov 0xB, r0
 mov 0x1, r1
 jmp L559
L558:
 mov 0xA, r0
L559:
 calls L58
L560:
 jne r42, 0x2, L561
 and r19, 0x23, r33
 je r33, 0x2, L680
 je r33, 0x22, L680
 jmp L781
L561:
 nap
 jext COND_RX_FIFOFULL, L703
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L702
 calls L990
 jnext COND_RX_COMPLETE, L561
 jnzx 0, 9, SPR_RXE_ENCODING, 0x0, L652
L562:
 calls L990
 jzx 0, 14, SPR_RXE_0x1a, 0x0, L562
 jext COND_RX_FIFOFULL, L703
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L702
 calls L815
 jg SPR_RXE_FRAMELEN, [0x010], L572
 jnext COND_RX_FCS_GOOD, L572
 jne r42, 0x0, L566
 jnext 0x61, L563
 add [0x08A], 0x1, [0x08A]
 jmp L565
L563:
 jnzx 0, 0, [0x05,off1], 0x0, L564
 add [0x090], 0x1, [0x090]
 jmp L565
L564:
 add [0x095], 0x1, [0x095]
L565:
 je r19, 0x20, L750
 je r19, 0x14, L750
 je r19, 0x10, L653
 je r19, 0x24, L349
 je r19, 0x28, L777
 je r19, 0x30, L777
 je r19, 0x34, L779
 je r19, 0x38, L351
 jmp L781
L566:
 jne r42, 0x1, L570
 jnext 0x61, L567
 add [0x08B], 0x1, [0x08B]
 jmp L569
L567:
 jnzx 0, 0, [0x05,off1], 0x0, L568
 add [0x091], 0x1, [0x091]
 jmp L569
L568:
 add [0x096], 0x1, [0x096]
L569:
 je r19, 0x35, L636
 je r19, 0x21, L788
 je r19, 0x25, L788
 je r19, 0x2D, L682
 je r19, 0x31, L636
 je r19, 0x29, L776
 and r19, 0xFFFB, r33
 je r33, 0x39, L785
 je r19, 0x15, L346
 je r19, 0xB5, L686
 je r19, 0xC5, L636
 jmp L649
L570:
 add [SHM_BCMCFIFOID], 0x1, [SHM_BCMCFIFOID]
 jmp L651
L571:
 add [0x083], 0x1, [0x083]
 jnzx 0, 9, SPR_RXE_ENCODING, 0x0, L652
 orx 0, 9, 0x1, SPR_BRC, SPR_BRC
 jmp L652
L572:
 mov 0x0, [0x7AD]
 mov 0x0, [0x7D1]
L573:
 calls L990
 jnzx 0, 12, SPR_DAGG_STAT, 0x0, L574
 nap
 jext COND_RX_FIFOFULL, L703
 jnext 0x39, L573
 jmp L628
L574:
 jext COND_4_C6, L576
 jext EOI(COND_RX_COMPLETE), L575
L575:
 jmp L719
L576:
 nap
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L702
 jext COND_RX_FIFOFULL, L703
 calls L990
 jnext EOI(COND_RX_COMPLETE), L576
L577:
 jzx 0, 15, SPR_RXE_0x56, 0x0, L578
 jzx 0, 14, SPR_RXE_0x1a, 0x0, L577
L578:
 srx 0, 15, SPR_RXE_0x56, 0x0, r33
 xor r33, 0x1, r33
 orx 0, 3, r33, SPR_PSM_COND, SPR_PSM_COND
 or SPR_TSF_0x3e, 0x0, [RX_HDR_RxTSFTime]
 orx 0, 6, 0x0, SPR_BRC, SPR_BRC
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L702
 jzx 0, 1, [0x06C], 0x0, L583
 orx 0, 0, 0x1, r20, r20
 jnext COND_RX_FCS_GOOD, L583
 jext 0x61, L579
 add [0x081], 0x1, [0x081]
 jmp L580
L579:
 add [0x080], 0x1, [0x080]
L580:
 jnzx 0, 9, [0x06C], 0x0, L581
 orx 0, 9, 0x1, [0x06C], [0x06C]
 mov 0x0, [0x06E]
 mov 0x0, [0x06F]
 jmp L582
L581:
 sub [0x0E,off1], r61, r33
 sub r33, 0x10, r33
 sr r33, 0x4, r33
 add. [0x06E], r33, [0x06E]
 addc [0x06F], 0x0, [0x06F]
L582:
 or [0x0E,off1], 0x0, r61
 jzx 0, 10, [0x06C], 0x0, L720
L583:
 jext COND_RX_FCS_GOOD, L588
 add [0x085], 0x1, [0x085]
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L584
 jzx 0, 3, [0x3C9], 0x0, L584
 mov 0xC000, SPR_TSF_GPT2_STAT
L584:
 jnext COND_PSM(2), L585
 jnzx 2, 0, [0xBF7], 0x0, L586
L585:
 mov 0x1, [0xBF7]
L586:
 jext COND_PSM(2), L587
 orx 0, 9, 0x1, SPR_BRC, SPR_BRC
 orx 0, 1, 0x0, SPR_BRC, SPR_BRC
 orx 0, 9, 0x0, r63, r63
L587:
 jext COND_RX_FIFOFULL, L703
 orx 0, 0, 0x1, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 orx 0, 0, 0x1, r20, r20
 jmp L623
L588:
 orx 0, 6, 0x0, r63, r63
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L589
 jzx 0, 2, [0x3C9], 0x0, L589
 mov 0xC000, SPR_TSF_GPT2_STAT
L589:
 jnext COND_PSM(2), L590
 jnzx 1, 1, [0xBF7], 0x0, L597
 mov 0x0, [0xBF7]
L590:
 jext 0x61, L594
 je r42, 0x1, L596
 je r42, 0x0, L593
 srx 1, 8, [0x03,off1], 0x0, r33
 je r33, 0x1, L591
 je r33, 0x2, L592
 jmp L596
L591:
 jext 0x64, L594
 jmp L595
L592:
 jext 0x62, L594
 jmp L595
L593:
 jext 0x63, L594
 jmp L595
L594:
 mov 0x2, [0xBF7]
 jmp L597
L595:
 mov 0x4, [0xBF7]
 jmp L597
L596:
 mov 0x1, [0xBF7]
L597:
 jext COND_RX_FIFOFULL, L703
 jnext 0x61, L601
 jzx 0, 2, [SHM_HOST_FLAGS2], 0x0, L598
 jne r42, 0x2, L598
 jnext 0x62, L612
L598:
 jnext COND_PSM(2), L601
 jnzx 1, 5, SPR_MHP_QOS, 0x0, L604
 jext COND_NEED_RESPONSEFR, L600
 jmp L439
L599:
 orx 2, 0, 0x2, SPR_BRC, SPR_BRC
 mov 0x4, SPR_TXBA_Data_Select
 sr [0x0E,off1], 0x4, r33
 sub r33, 0x3F, SPR_TXBA_Data
 orx 3, 12, SPR_MHP_QOS, 0x5, SPR_TME_VAL28
 srx 0, 12, [0x03,off1], 0x0, r33
 xor r33, 0x1, r33
 orx 0, 5, r33, r43, r43
 mov 0x4001, SPR_TXE0_CTL
L600:
 orx 3, 0, 0x5, [0x0E,off1], SPR_TXBA_Control
 orx 0, 15, 0x1, r20, r20
L601:
 jnext COND_NEED_RESPONSEFR, L604
 jzx 1, 5, SPR_MHP_QOS, 0x0, L602
 orx 0, 1, 0x0, SPR_BRC, SPR_BRC
 jmp L604
L602:
 jne r23, 0x0, L603
 jzx 3, 4, SPR_TX_PLCP_HT_Sig0, 0x0, L603
 srx 0, 7, SPR_RXE_PHYRXSTAT0, 0x0, r33
 orx 0, 4, r33, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
L603:
 orx 0, 1, 0x1, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 jext COND_PSM(2), L604
 or r17, 0x0, SPR_TXE0_CTL
L604:
 srx 1, 0, r19, 0x0, r33
 je r33, 0x1, L613
 jext 0x61, L614
 jzx 0, 0, [0x05,off1], 0x0, L608
 jne r42, 0x2, L605
 add [0x094], 0x1, [0x094]
L605:
 jnzx 0, 7, SPR_MHP_Status, 0x0, L623
 jnzx 0, 8, [0x03,off1], 0x0, L720
 jnzx 0, 9, [0x03,off1], 0x0, L606
 jext COND_PSM(8), L607
 jmp L610
L606:
 jnext COND_PSM(8), L610
 je r19, 0x20, L607
 srx 0, 13, [0x03,off1], 0x0, r33
 mul [0x582], 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE4
 orx 0, 3, r33, [0x1F,off4], [0x1F,off4]
L607:
 je r19, 0x10, L623
 jmp L621
L608:
 jnext 0x3D, L609
 jnext 0x62, L609
 jne r42, 0x2, L609
 mul [0x582], 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE4
 orx 0, 3, 0x0, [0x1F,off4], [0x1F,off4]
L609:
 jne r42, 0x2, L611
 add [0x08F], 0x1, [0x08F]
 jmp L612
L610:
 je r42, 0x2, L612
 jnzx 0, 0, [0x0B,off1], 0x0, L623
L611:
 jzx 0, 4, SPR_MAC_CTLHI, 0x0, L612
 je r19, 0x20, L623
 je r19, 0x14, L623
L612:
 jzx 0, 8, SPR_MAC_CTLHI, 0x0, L720
 jmp L623
L613:
 jnext 0x61, L623
 je r19, 0x2D, L621
 je r19, 0x29, L621
 jmp L623
L614:
 jne r42, 0x2, L616
 jge [0x582], 0x1, L616
 mov 0x0, [0xAEF]
 orx 0, 2, 0x0, r46, r46
 jnzx 0, 0, r63, 0x0, L615
 je [0xB0D], 0x0, L616
 add SPR_TSF_WORD0, [0xB0C], [0xB0D]
L615:
 je [0xB14], 0xFFFE, L616
 add [0xB14], 0x1, [0xB14]
L616:
 jzx 0, 7, SPR_MHP_Status, 0x0, L617
 add [0x098], 0x1, [0x098]
 jmp L623
L617:
 jnext COND_4_C7, L619
 srx 5, 2, [0x6B8], 0x0, r35
 jne r35, 0x29, L619
 orx 0, 15, 0x0, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
 orx 0, 8, 0x0, SPR_BRC, SPR_BRC
 or r33, 0x0, r33
 jle 0x0, 0x1, L618
L618:
 jext EOI(COND_TX_PMQ), L619
L619:
 jne r42, 0x2, L620
 add [0x089], 0x1, [0x089]
L620:
 je r19, 0x0, L623
 je r19, 0x8, L623
 je r19, 0x2C, L623
 je r19, 0x38, L623
L621:
 mul [0x582], 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE5
 jand [0x1F,off5], 0x50, L623
 jnzx 0, 0, SPR_PMQ_control_high, 0x0, L633
 jnext COND_PSM(2), L622
 srx 0, 5, r43, 0x0, r33
 srx 0, 12, [0x03,off1], 0x0, r34
 jboh r33, r34, L623
 orx 0, 5, r34, r43, r43
L622:
 or [0x08,off1], 0x0, SPR_PMQ_pat_0
 or [0x09,off1], 0x0, SPR_PMQ_pat_1
 or [0x0A,off1], 0x0, SPR_PMQ_pat_2
 srx 0, 12, [0x03,off1], 0x0, r33
 add r33, 0x1, SPR_PMQ_dat
 or [0x016], 0x0, SPR_PMQ_control_low
 or SPR_PMQ_control_low, 0x0, 0x0
 srx 6, 9, SPR_PMQ_control_high, 0x0, r33
 jle r33, [0x015], L623
 mov 0x40, SPR_MAC_IRQLO
L623:
 jzx 0, 15, SPR_RXE_0x56, 0x0, L624
 mov 0x7, SPR_TXBA_Control
L624:
 jnzx 0, 7, SPR_MAC_CTLHI, 0x0, L625
 je r55, 1, skip+
 jnzx 0, 0, r20, 0x0, L720
 jne [SHM_CSI_COLLECT], 1, skip+
 jmp L720
skip:
L625:
 orx 0, 2, 0x1, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 srx 0, 6, r20, 0x0, r33
 orx 0, 15, r33, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
L626:
 jext COND_RX_FIFOFULL, L703
 calls L990
 jext COND_RX_CRYPTBUSY, L626
 srx 0, 15, SPR_WEP_CTL, 0x0, r33
 orx 0, 4, r33, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 jzx 0, 3, [RX_HDR_RxStatus2], 0x0, L627
 srx 0, 14, SPR_WEP_CTL, 0x0, r33
 orx 0, 4, r33, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
L627:
 or [0x7E2], 0x0, r33
 orx 1, 5, r33, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 jzx 0, 15, SPR_RXE_0x56, 0x0, L628
 mov 0x6, SPR_RCM_TA_Address_1
 or SPR_RXE_PHYRXSTAT0, 0x0, [RX_HDR_PhyRxStatus_0]
 or SPR_RXE_PHYRXSTAT1, 0x0, [RX_HDR_PhyRxStatus_1]
 or SPR_RXE_PHYRXSTAT2, 0x0, [RX_HDR_PhyRxStatus_2]
 or SPR_RXE_PHYRXSTAT3, 0x0, [RX_HDR_PhyRxStatus_3]
 or SPR_RXE_0x46, 0x0, [RX_HDR_PhyRxStatus_5]
 or SPR_RXE_0x44, 0x0, [RX_HDR_PhyRxStatus_4]
 orx 7, 0, SPR_RCM_TA_Address_2, [RX_HDR_PhyRxStatus_5], [RX_HDR_PhyRxStatus_5]
 orx 0, 8, 0x1, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 calls L815
L628:
 or SPR_RXE_FRAMELEN, 0x0, r33
 jzx 0, 0, [RX_HDR_RxStatus2], 0x0, L629
 jg SPR_DAGG_LEN, [0x010], L720
 srx 11, 0, SPR_DAGG_STAT, 0x0, r33
L629:
 jzx 0, 2, [RX_HDR_RxStatus1], 0x0, L630
 add r33, 0x2, r33
L630:
 jg r33, [0x010], L634
 or r33, 0x0, [RX_HDR_RxFrameSize]
 mov RX_HDR_BASE, SPR_RXE_RXHDR_OFFSET
 or 0, 0x0, [SHM(0x1182)]
 jne [SHM_CSI_COPIED], 1, skip+
 or 17, 0x0, [SHM(0x1182)]
skip:
 // send out original packet
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 // send csi packet
 mov RX_HDR_BASE + RX_HDR_LEN, SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (2 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (3 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (4 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (5 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (6 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (7 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (8 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (9 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (10 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (11 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (12 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (13 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (14 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (15 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (16 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
 // skip if csi not copied
 jne [SHM_CSI_COPIED], 1, skip+
 mov RX_HDR_BASE + (17 * RX_HDR_LEN), SPR_RXE_RXHDR_OFFSET
 calls L798
skip:
 jnzx 0, 12, SPR_DAGG_STAT, 0x0, L631
 orx 5, 0, 0x22, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 orx 0, 2, 0x1, [RX_HDR_RxStatus1], [RX_HDR_RxStatus1]
 orx 0, 1, 0x0, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
 jmp L572
L631:
 nand SPR_RXE_FIFOCTL1, 0x2, SPR_RXE_FIFOCTL1
 jnext COND_PSM(2), L632
 jnext COND_RX_FCS_GOOD, L632
 orx 0, 4, 0x1, SPR_PSM_COND, SPR_PSM_COND
L632:
 jzx 0, 15, SPR_RXE_0x56, 0x0, L499
 nand SPR_RXE_FIFOCTL1, 0x2, SPR_RXE_FIFOCTL1
 jmp L401
L633:
 add [0x0A1], 0x1, [0x0A1]
 jmp L635
L634:
 add [0x082], 0x1, [0x082]
L635:
 jext COND_PSM(2), L720
 orx 0, 8, 0x1, SPR_BRC, SPR_BRC
 orx 0, 9, 0x1, SPR_BRC, SPR_BRC
 jmp L720
L636:
 jnext 0x61, L647
 je r19, 0xC5, L637
 jne r19, 0x35, L638
 add [0x08E], 0x1, [0x08E]
 jmp L639
L637:
 add [0x3E2], 0x1, [0x3E2]
 jmp L639
L638:
 add [0x08D], 0x1, [0x08D]
L639:
 jnext COND_4_C7, L649
 jne r19, r14, L649
 orx 0, 15, 0x0, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
 orx 0, 8, 0x0, SPR_BRC, SPR_BRC
 or r33, 0x0, r33
 jle 0x0, 0x1, L640
L640:
 jext EOI(COND_TX_PMQ), L641
L641:
 je r19, 0x31, L646
 mov 0x0, [0xAD8]
 jnext COND_PSM(1), L642
 jzx 0, 7, r44, 0x0, L643
 orx 3, 4, 0x6, [0x09,off0], [0x09,off0]
L642:
 orx 0, 7, 0x0, r44, r44
L643:
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L645
 jzx 0, 6, SPR_BTCX_Stat, 0x0, L644
 orx 0, 11, 0x1, SPR_BTCX_Stat, SPR_BTCX_Stat
L644:
 jzx 0, 8, r44, 0x0, L645
 orx 0, 15, 0x0, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
 orx 0, 7, 0x0, SPR_BRC, SPR_BRC
 calls L1110
 jmp L649
L645:
 jnzx 1, 2, SPR_TXE0_FIFO_PRI_RDY, 0x0, L649
 jzx 0, 10, [0x6B8], 0x0, L649
L646:
 orx 0, 4, 0x1, SPR_BRC, SPR_BRC
 jmp L649
L647:
 jnzx 0, 14, [SHM_HOST_FLAGS2], 0x0, L648
 jne r19, 0x35, L648
 jne [0x04,off1], 0x0, L648
 mov 0x0, SPR_NAV_0x06
 mov 0x0, SPR_NAV_0x04
L648:
 jne r19, 0x31, L649
 add [0x093], 0x1, [0x093]
 jmp L649
L649:
 jext 0x61, L650
 jzx 0, 8, SPR_MAC_CTLHI, 0x0, L652
L650:
 jnzx 0, 6, SPR_MAC_CTLHI, 0x0, L572
 jmp L652
L651:
 jnzx 0, 8, SPR_MAC_CTLHI, 0x0, L572
L652:
 orx 0, 0, 0x1, r20, r20
 jmp L572
L653:
 jext 0x3E, L654
 jext 0x3D, L781
 jzx 0, 6, r20, 0x0, L781
L654:
 jext 0x61, L655
 jzx 0, 0, [0x05,off1], 0x0, L651
L655:
 jnzx 0, 0, [0x0B,off1], 0x0, L656
 jnext 0x63, L781
L656:
 jzx 3, 0, [0x794], 0x0, L664
 mov 0x7F4, SPR_BASE5
 mov 0xDD, r36
L657:
 calls L74
 or r35, 0x0, r38
 jne r36, 0xDD, L663
 jzx 0, 15, SPR_BASE5, 0x0, L658
 srx 7, 0, [0x01,off5], 0x0, r33
 srx 7, 8, [0x01,off5], 0x0, r34
 orx 7, 8, [0x02,off5], r34, r34
 srx 7, 8, [0x02,off5], 0x0, r35
 orx 7, 8, [0x03,off5], r35, r35
 jmp L659
L658:
 srx 7, 8, [0x00,off5], 0x0, r33
 or [0x01,off5], 0x0, r34
 or [0x02,off5], 0x0, r35
L659:
 jl r33, 0x4, L662
 mov 0x6F50, r37
 jne r34, r37, L660
 mov 0x99A, r37
 je r35, r37, L661
L660:
 mov 0x1700, r37
 jne r34, r37, L662
 mov 0x5F2, r37
 jne r35, r37, L662
L661:
 jmp L678
L662:
 rr r33, 0x1, r33
 add. SPR_BASE5, r33, SPR_BASE5
 or SPR_BASE5, 0x0, 0x0
 addc. SPR_BASE5, 0x1, SPR_BASE5
 orx 14, 0, SPR_BASE5, 0x0, r34
 add r34, 0x3, r34
 jl r34, r38, L657
L663:
 sub SPR_RXE_FRAMELEN, 0x4, r37
 jg r37, SPR_RXE_Copy_Length, L678
 or [0x793], 0x0, r33
 jne r33, [SHM_CHAN], L781
L664:
 jzx 7, 8, [0x0F,off1], 0x0, L667
 srx 7, 8, [0x0F,off1], 0x0, r33
 jne r33, [SHM_PRSSIDLEN], L677
 mov 0xB0, SPR_BASE4
 mov 0x7F5, SPR_BASE5
 je r33, 0x1, L666
L665:
 or [0x00,off5], 0x0, r34
 jne r34, [0x00,off4], L677
 add SPR_BASE5, 0x1, SPR_BASE5
 add SPR_BASE4, 0x1, SPR_BASE4
 sub r33, 0x2, r33
 jgs r33, 0x1, L665
 je r33, 0x0, L668
L666:
 srx 7, 0, [0x00,off5], 0x0, r33
 srx 7, 0, [0x00,off4], 0x0, r34
 jne r33, r34, L677
 jmp L668
L667:
 jnzx 0, 11, SPR_MAC_CTLHI, 0x0, L781
L668:
 mov 0x7F4, SPR_BASE5
 mov 0x2D, r36
 calls L74
 jnzx 0, 0, [SHM_HOST_FLAGS2], 0x0, L677
 mov 0x680, r38
 add [0x05F], 0x5, r37
 jl r37, r38, L669
 mov 0x644, r37
L669:
 je r37, [0x05E], L679
 or [0x05E], 0x0, SPR_BASE5
 or [0x09,off1], 0x0, r34
 or [0x0A,off1], 0x0, r35
L670:
 je SPR_BASE5, [0x05F], L672
 jne r35, [0x02,off5], L671
 je r34, [0x01,off5], L677
L671:
 add SPR_BASE5, 0x5, SPR_BASE5
 jl SPR_BASE5, r38, L670
 mov 0x644, SPR_BASE5
 jmp L670
L672:
 add [0x0A2], 0x1, [0x0A2]
 or [0x05F], 0x0, SPR_BASE5
 or [0x08,off1], 0x0, [0x00,off5]
 or [0x09,off1], 0x0, [0x01,off5]
 or [0x0A,off1], 0x0, [0x02,off5]
 mul [0x582], 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE4
 jzx 0, 6, [0x1F,off4], 0x0, L673
 mov 0xB01, r33
 jmp L674
L673:
 mov 0xB01, r33
 je r23, 0x2, L674
 orx 7, 8, [0x00,off1], r23, r33
L674:
 orx 5, 2, r0, r33, [0x03,off5]
 sr SPR_TSF_WORD0, 0x8, [0x04,off5]
 jzx 0, 5, [SHM_HOST_FLAGS5], 0x0, L675
 jne r36, 0x2D, L676
L675:
 orx 0, 8, 0x1, [0x04,off5], [0x04,off5]
L676:
 or r37, 0x0, [0x05F]
L677:
 jzx 0, 15, [SHM_HOST_FLAGS5], 0x0, L678
 orx 0, 0, 0x1, r20, r20
L678:
 jext 0x61, L442
 jmp L572
L679:
 add [0x0A3], 0x1, [0x0A3]
 jmp L651
L680:
 jext COND_RX_COMPLETE, L681
 jl SPR_RXE_FRAMELEN, 0x1C, L680
L681:
 jl SPR_RXE_FRAMELEN, 0x1C, L651
 jnext 0x61, L783
 jmp L442
L682:
 jnext 0x61, L684
 add [0x08C], 0x1, [0x08C]
 jzx 0, 0, [0x08,off1], 0x0, L683
 mov 0x6, SPR_RCM_TA_Address_1
 or SPR_RCM_TA_Address_1, 0x0, 0x0
 srx 1, 0, SPR_RCM_TA_Address_2, 0x0, [0xC1F]
 srx 2, 11, [SHM_CHAN], 0x0, r33
 sub r33, 0x2, r33
 je r33, 0x0, L683
 jl [0xC1F], r33, L683
 sub SPR_TSF_WORD0, [0xC1D], r33
 jle r33, [0xC1E], L683
 sub [0xC1F], 0x1, [0xC1F]
 jzx 0, 2, SPR_RCM_TA_Address_2, 0x0, L649
L683:
 jmp L443
L684:
 add [0x092], 0x1, [0x092]
L685:
 srx 0, 7, SPR_RXE_PHYRXSTAT0, 0x0, r1
 orx 0, 4, r1, [0x86B], r1
 calls L907
 sl [SHM_SLOTT], 0x1, r34
 add r34, [SHM_EDCFSTAT], r34
 add r33, r34, SPR_NAV_0x12
 orx 0, 13, 0x1, SPR_NAV_CTL, SPR_NAV_CTL
 jmp L649
L686:
 jnext 0x61, L685
 add [0x3E1], 0x1, [0x3E1]
 jmp L441
L687:
 jnzx 0, 8, SPR_MHP_HTC_High, 0x0, L347
 jmp L649
L688:
 jext 0x45, L38
 jext COND_4_C7, L691
 add [0x07F], 0x1, [0x07F]
 mov 0x0, r35
 jmp L693
L689:
 orx 1, 4, 0x3, SPR_WEP_CTL, SPR_WEP_CTL
 orx 0, 8, 0x1, SPR_BRC, SPR_BRC
 jand 0x7, SPR_BRC, L690
 add [0x07E], 0x1, [0x07E]
 jmp L694
L690:
 mov 0x76, r33
 add r33, [SHM_TXFCUR], SPR_BASE5
 add [0x00,off5], 0x1, [0x00,off5]
 jext COND_PSM(1), L693
 jnzx 3, 4, [0x09,off0], 0x0, L692
 orx 3, 4, 0x6, [0x09,off0], [0x09,off0]
 jmp L692
L691:
 add [0x07F], 0x1, [0x07F]
L692:
 mov 0x1, r35
L693:
 jnext COND_4_C7, L694
 orx 0, 7, 0x0, SPR_BRC, SPR_BRC
 orx 0, 8, 0x0, r44, r44
 mov 0x0, r14
 orx 0, 15, 0x0, SPR_TXE0_TIMEOUT, SPR_TXE0_TIMEOUT
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
L694:
 jext EOI(COND_TX_POWER), L695
L695:
 jext EOI(COND_TX_NOW), L696
L696:
 orx 0, 5, 0x0, SPR_BRC, SPR_BRC
 jext EOI(COND_TX_UNDERFLOW), L697
L697:
 mov 0x7, r33
 jnzx 1, 0, SPR_TXE0_PHY_CTL, 0x0, L698
 or 0x7, [0x055], r33
L698:
 calls L52
 or SPR_Ext_IHR_Data, 0x0, r37
 jne [0xC08], 0x0, L699
 or r37, 0x0, [0xC09]
 or SPR_TXE0_PHY_CTL, 0x0, [0xC0A]
 or SPR_TXE0_PHY_CTL1, 0x0, [0xC0B]
 or SPR_TXE0_PHY_CTL2, 0x0, [0xC0C]
 or SPR_TX_PLCP_Sig0, 0x0, [0xC0D]
 or SPR_TX_PLCP_Sig1, 0x0, [0xC0E]
 or SPR_TX_PLCP_HT_Sig0, 0x0, [0xC0F]
 or SPR_TX_PLCP_HT_Sig1, 0x0, [0xC10]
 or SPR_TX_PLCP_HT_Sig2, 0x0, [0xC11]
 or SPR_TX_PLCP_VHT_SigB0, 0x0, [0xC12]
 or SPR_TX_PLCP_VHT_SigB1, 0x0, [0xC13]
 orx 7, 8, r18, [0xC15], [0xC15]
 mov 0x1, [0xC08]
L699:
 mov 0xFFFF, r34
 calls L54
 xor r33, [0x055], r33
 calls L54
 je r35, 0x0, L0
 je [0x06C], 0x0, L700
 mov 0x0, [0x5AE]
 jmp L701
L700:
 jnand 0x7, SPR_BRC, L701
 or r37, 0x0, [0x0C,off0]
 jmp L207
L701:
 nand SPR_BRC, 0x7, SPR_BRC
 jmp L0
L702:
 orx 0, 6, 0x0, SPR_BRC, SPR_BRC
L703:
 mov 0x100, SPR_MAC_IRQLO
 add [0x09D], 0x1, [0x09D]
L704:
 calls L1157
 jext EOI(COND_RX_FIFOFULL), L705
L705:
 jnext COND_PSM(4), L707
 jzx 0, 15, r20, 0x0, L706
 mov 0x4, SPR_TXBA_Data_Select
 or SPR_TXBA_Data, 0x0, r33
 sr [0x0E,off1], 0x4, r59
 sub r59, r33, r59
 srx 1, 4, r59, 0x0, SPR_TXBA_Data_Select
 or SPR_TXBA_Data, 0x0, r38
 srx 3, 0, r59, 0x0, r33
 sl 0x1, r33, r33
 nand r38, r33, r38
 or r38, 0x0, SPR_TXBA_Data
L706:
 mov 0x7, SPR_TXBA_Control
 jmp L720
L707:
 orx 0, 9, 0x1, SPR_BRC, SPR_BRC
 jmp L720
L708:
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L37
 jnand 0xE2, SPR_BRC, L37
 jext COND_TX_PHYERR, L37
 jext COND_TX_TBTTEXPIRE, L37
 jext COND_TX_DONE, L37
 calls L727
L709:
 add. [0x3C0], SPR_IFS_0x0e, [0x3C0]
 addc [0x3C1], 0x0, [0x3C1]
 mov 0x0, SPR_IFS_0x0e
 mov 0x3, [SHM_UCODESTAT]
 je [0x05C], 0x0, L710
 calls L122
 or [0x05C], 0x0, SPR_TME_VAL14
 mov 0x0, [0x006]
 mov 0x0, [0x05C]
 mov 0xE, r2
 orx 10, 5, r2, [0x4D5], SPR_TX_PLCP_HT_Sig0
 or [0x4D6], 0x0, SPR_TX_PLCP_HT_Sig1
 orx 1, 0, 0x1, [SHM_TXFIFO_SIZE01], SPR_TXE0_PHY_CTL
 or [0x4DB], 0x0, SPR_TXE0_PHY_CTL1
 calls L891
 orx 2, 0, 0x2, SPR_BRC, SPR_BRC
 mov 0x4001, SPR_TXE0_CTL
 jmp L0
L710:
 mov 0x1, SPR_MAC_IRQLO
 orx 0, 15, 0x0, SPR_TSF_GPT0_STAT, SPR_TSF_GPT0_STAT
 calls L1080
L711:
 jext COND_TX_FLUSH, L732
 jne [0x03F], 0x0, L742
L712:
 je [0x3D0], 0x0, L713
 calls L1172
L713:
 jnext COND_MACEN, L711
 mov 0x2, [SHM_UCODESTAT]
 mov 0x0, [0xBF7]
 mov 0x0, SPR_IFS_med_busy_ctl
 mov 0x6000, SPR_TSF_GPT0_CNTLO
 or [SHM_DEFAULTIV], 0x0, SPR_TSF_GPT0_CNTHI
 mov 0x644, [0x05E]
 mov 0x644, [0x05F]
 srx 0, 15, SPR_MAC_CTLHI, 0x0, r33
 orx 0, 0, r33, r43, r43
L714:
 calls L715
 mov 0x0, [0x7AD]
 mov 0x0, [0x7D1]
 calls L1064
 mov 0x0, [0x87B]
 calls L1157
 jmp L3
L715:
 mov 0x0, SPR_BRC
 mov 0xFFFF, SPR_BRCL0
 mov 0xFFFF, SPR_BRCL1
 mov 0xEFFF, SPR_BRCL2
 mov 0xFF7F, SPR_BRCL3
 calls L1157
 orx 0, 15, 0x1, SPR_TSF_GPT0_STAT, SPR_TSF_GPT0_STAT
 mov 0x0, SPR_BRCL0
 mov 0x0, SPR_BRCL1
 mov 0x0, SPR_BRCL2
 mov 0x0, SPR_BRCL3
 mov 0x301, [0x017]
 srx 0, 13, SPR_MAC_CTLHI, 0x0, r33
 orx 0, 4, r33, [0x017], [0x017]
 srx 0, 14, SPR_MAC_CTLHI, 0x0, r33
 xor r33, 0x1, r33
 orx 0, 1, r33, 0x0, [0x016]
 rets
L716:
 jnzx 0, 11, SPR_RXE_0x1a, 0x0, L0
 calls L990
 jnzx 0, 12, SPR_RXE_0x1a, 0x0, L716
 add [0x086], 0x1, [0x086]
 jzx 0, 4, SPR_PHY_HDR_Parameter, 0x0, L717
 jzx 0, 4, [0x3C9], 0x0, L717
 mov 0xC000, SPR_TSF_GPT2_STAT
L717:
 jzx 0, 5, r46, 0x0, L718
 add [0x0AF], 0x1, [0x0AF]
L718:
 mov 0x8, [0xBF7]
 jext COND_RX_FIFOFULL, L703
 jnzx 0, 15, SPR_RXE_0x1a, 0x0, L703
L719:
 srx 13, 0, 0x0, 0x0, SPR_RXE_0x54
 mov 0x4, SPR_RXE_FIFOCTL1
 mov 0x2, SPR_IFS_0x06
 orx 0, 4, 0x1, SPR_IFS_CTL, SPR_IFS_CTL
 jmp L3
L720:
 mov 0x1, SPR_DAGG_CTL2
 jext COND_PSM(3), L721
 srx 13, 0, 0x0, 0x0, SPR_RXE_0x54
L721:
 mov 0x14, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 mov 0x110, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 mov 0x0, SPR_TX_BF_Control
 mov 0xC3, r22
 orx 0, 6, 0x0, SPR_BRC, SPR_BRC
 orx 0, 0, 0x0, [RX_HDR_RxStatus2], [RX_HDR_RxStatus2]
L722:
 calls L990
 jzx 4, 0, SPR_WEP_IV_Location, 0x0, L723
 jnzx 0, 15, SPR_WEP_IV_Location, 0x0, L723
 jext COND_RX_CRYPTBUSY, L722
L723:
 srx 2, 0, SPR_WEP_CTL, 0x0, r38
 je r38, 0x7, L724
 mov 0x5, r38
L724:
 or r38, 0x1D0, SPR_WEP_CTL
 mov 0xA, r33
L725:
 sub r33, 0x1, r33
 jne r33, 0x0, L725
 mov 0x14, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 mov 0x110, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 or r38, 0x70, SPR_WEP_CTL
 mov 0x0, SPR_WEP_CTL
 jge SPR_RXE_FRAMELEN, 0x14, L726
 orx 0, 4, 0x1, SPR_IFS_CTL, SPR_IFS_CTL
L726:
 jnext COND_4_C9, L401
 orx 0, 12, 0x1, r43, r43
 calls L727
 orx 0, 0, 0x1, SPR_TXE0_AUX, SPR_TXE0_AUX
 or r33, 0x0, r33
 orx 0, 0, 0x0, SPR_TXE0_AUX, SPR_TXE0_AUX
 jmp L401
L727:
 mov 0x4000, SPR_TXE0_CTL
 or SPR_TXE0_CTL, 0x0, 0x0
 orx 1, 8, 0x3, SPR_TXE0_0x76, SPR_TXE0_0x76
 jle 0x0, 0x1, L728
L728:
 jnext EOI(COND_TX_NOW), L729
 nap2
 jmp L218
L729:
 orx 0, 8, 0x0, r44, r44
 nand SPR_BRC, 0x27, SPR_BRC
 orx 0, 4, 0x0, SPR_BRC, SPR_BRC
 jzx 0, 13, r43, 0x0, L731
L730:
 jext EOI(COND_TX_UNDERFLOW), L731
 jnext EOI(COND_TX_POWER), L730
L731:
 orx 1, 12, 0x0, r43, r43
 rets
L732:
 jext 0x45, L37
 jnzx 7, 8, SPR_TXE0_0x66, 0x0, L733
 mov 0x1, r36
 mov 0x3F, r35
 sl 0x1, [SHM_TXFCUR], r34
 jmp L734
L733:
 sl 0x1, 0x8, r36
 mov 0x3F00, r35
 or [SHM_TXFCUR], 0x0, r34
 add r34, 0x8, r34
 sl 0x1, r34, r34
L734:
 mov 0x584, SPR_BASE5
 mov 0x0, SPR_TXE0_FIFO_PRI_RDY
L735:
 jnand SPR_TXE0_0x66, r36, L737
L736:
 add SPR_BASE5, 0x20, SPR_BASE5
 add SPR_TXE0_FIFO_PRI_RDY, 0x1, SPR_TXE0_FIFO_PRI_RDY
 sl r36, 0x1, r36
 jand r36, r35, L741
 jmp L735
L737:
 jge r36, 0x100, L740
 jne r36, r34, L738
 je [SHM_UCODESTAT], 0x3, L738
 jext COND_NEED_RESPONSEFR, L738
 jnand SPR_BRC, 0xB0, L736
 calls L727
L738:
 jge r36, 0x100, L740
 calls L745
 jzx 0, 0, [0x0A,off5], 0x0, L739
 jzx 7, 8, [0x09,off5], 0x0, L739
 je [SHM_UCODESTAT], 0x3, L739
 jext COND_RX_FIFOBUSY, L37
 jext COND_RX_CRYPTBUSY, L37
 jext 0x45, L37
 jext COND_4_C7, L37
 jext COND_TX_BUSY, L37
 or SPR_BASE5, 0x0, SPR_BASE0
 orx 3, 4, 0x2, [0x09,off0], [0x09,off0]
 or [SHM_TXFCUR], 0x0, SPR_TXE0_FIFO_PRI_RDY
 jmp L207
L739:
 orx 0, 0, 0x0, [0x0A,off5], [0x0A,off5]
 jmp L740
L740:
 or r36, 0x0, SPR_TXE0_0x66
 orx 0, 6, 0x0, r63, r63
 mov 0x1, SPR_MAC_IRQHI
 jmp L736
L741:
 or [SHM_TXFCUR], 0x0, SPR_TXE0_FIFO_PRI_RDY
 jne [SHM_UCODESTAT], 0x3, L37
 jmp L712
L742:
 mov 0x584, SPR_BASE5
 mov 0x0, SPR_TXE0_FIFO_PRI_RDY
 mov 0x1, r36
 mov 0x3F, r35
L743:
 jand r36, [0x03F], L744
 calls L745
 nand [0x03F], r36, [0x03F]
L744:
 sl r36, 0x1, r36
 jand r36, r35, L712
 add SPR_BASE5, 0x20, SPR_BASE5
 add SPR_TXE0_FIFO_PRI_RDY, 0x1, SPR_TXE0_FIFO_PRI_RDY
 jmp L743
L745:
 orx 0, 0, 0x0, [0x0A,off5], [0x0A,off5]
 mov 0x0, [0x0A,off5]
 mov 0x0, [0x0B,off5]
 mov 0x0, [0x10,off5]
 mov 0x0, [0x11,off5]
 mov 0x0, [0x12,off5]
 mov 0x0, [0x15,off5]
 mov 0x0, [0x16,off5]
 mov 0x0, [0x17,off5]
 mov 0x0, [0x18,off5]
 mov 0x0, [0x1B,off5]
 mov 0x0, [0x1A,off5]
L746:
 jnzx 0, 10, SPR_TXE0_FIFO_Frame_Count, 0x0, L748
 mov 0x63, SPR_AQM_Max_IDX
 calls L1131
 orx 0, 8, 0x1, SPR_TXE0_FIFO_PRI_RDY, SPR_TXE0_FIFO_PRI_RDY
 or SPR_TXE0_FIFO_PRI_RDY, 0x0, 0x0
L747:
 jnzx 0, 8, SPR_TXE0_FIFO_PRI_RDY, 0x0, L747
 jmp L746
L748:
 sl r36, 0x8, r33
 jnand SPR_TXE0_FIFO_DEF1, r33, L746
 rets
L749:
 jnzx 0, 7, SPR_TXE0_STATUS, 0x0, L0
 or r33, 0x0, r33
 jext EOI(COND_TX_POWER), L352
 mov 0x20, SPR_MAC_IRQLO
 jext 0x3D, L3
 or r15, 0x0, SPR_IFS_BKOFFTIME
 mov 0x0, r15
 or r16, 0x0, r5
 or r3, 0x0, r16
 calls L727
 jmp L3
L750:
 jl SPR_RXE_FRAMELEN, 0x2C, L652
 jext COND_PSM(8), L751
 je r19, 0x14, L762
 add [0x099], 0x1, [0x099]
 jmp L762
L751:
 je r19, 0x14, L761
 add [0x097], 0x1, [0x097]
 calls L818
 orx 0, 7, 0x0, r45, r45
 orx 0, 2, 0x0, r46, r46
 mov 0x0, [0xAEF]
 jext 0x3D, L753
 jnext 0x43, L753
 add [0x09B], 0x1, [0x09B]
 calls L727
 orx 0, 12, 0x0, SPR_BRC, SPR_BRC
 orx 0, 0, 0x0, SPR_BRC, SPR_BRC
 orx 0, 3, 0x0, SPR_BRC, SPR_BRC
 mov 0x10, SPR_MAC_IRQLO
 jnzx 0, 0, SPR_TSF_0x0e, 0x0, L752
 or r15, 0x0, SPR_IFS_BKOFFTIME
 mov 0x0, r15
 or r16, 0x0, r5
 or r3, 0x0, r16
 jmp L753
L752:
 and SPR_TSF_RANDOM, r3, SPR_IFS_BKOFFTIME
L753:
 jnzx 0, 4, [SHM_HOST_FLAGS2], 0x0, L761
 or [0x01C], 0x0, r33
 add r33, [0x00,off3], r33
 add. r30, r33, r30
 addc. r29, 0x0, r29
 addc. r28, 0x0, r28
 addc r27, 0x0, r27
 jext 0x3D, L754
 jg r27, [0x12,off1], L775
 jl r27, [0x12,off1], L754
 jg r28, [0x11,off1], L775
 jl r28, [0x11,off1], L754
 jg r29, [0x10,off1], L775
 jl r29, [0x10,off1], L754
 jge r30, [0x0F,off1], L775
L754:
 orx 0, 12, 0x0, r20, r20
 jnzx 0, 4, [SHM_HOST_FLAGS5], 0x0, L756
 or SPR_TSF_WORD0, 0x0, [0x87A]
 or SPR_TSF_WORD1, 0x0, [0x879]
 or SPR_TSF_WORD2, 0x0, [0x878]
 or SPR_TSF_WORD3, 0x0, [0x877]
 jne [0x87A], SPR_TSF_WORD0, L754
 sub. [0x87A], r30, r30
 subc. [0x879], r29, r29
 subc. [0x878], r28, r28
 subc [0x877], r27, r27
L755:
 add. r30, [0x0F,off1], r33
 or r33, 0x0, SPR_TSF_WORD0
 addc. r29, [0x10,off1], SPR_TSF_WORD1
 addc. r28, [0x11,off1], SPR_TSF_WORD2
 addc r27, [0x12,off1], SPR_TSF_WORD3
 jne r33, SPR_TSF_WORD0, L755
 jmp L760
L756:
 sub. [0x0F,off1], r30, r33
 subc. [0x10,off1], r29, r34
 subc. [0x11,off1], r28, r35
 subc [0x12,off1], r27, r36
 sl [0x582], 0x2, r37
 add [0x057], r37, SPR_BASE4
 sub. r33, [0x4D,off4], [0x79A]
 subc. r34, [0x4E,off4], [0x79B]
 subc. r35, [0x4F,off4], [0x79C]
 subc r36, [0x50,off4], [0x79D]
 mul [0x582], 0xC, r37
 mov 0x753, r0
 add r0, SPR_PSM_0x5a, SPR_BASE5
 sl [0x03,off5], 0x5, r37
 or r37, 0x10, r37
 srx 4, 11, [0x03,off5], 0x0, r38
 sub. r37, [0x79A], r37
 subc r38, [0x79B], r38
 srx 15, 5, r37, r38, r37
 je r37, [0x03,off5], L760
 sub r37, [0x03,off5], r38
 or r37, 0x0, [0x03,off5]
 je [0x04,off5], 0x0, L757
 add [0x05,off5], r38, [0x05,off5]
L757:
 je [0x06,off5], 0x0, L758
 add [0x07,off5], r38, [0x07,off5]
L758:
 sl r38, 0x5, r33
 srx 4, 11, r38, 0x0, r34
 mov 0x0, r35
 mov 0x0, r36
 jges r38, 0x0, L759
 mov 0xFFFF, r35
 mov 0xFFFF, r36
 orx 10, 5, r35, r34, r34
L759:
 sub. [0x4D,off4], r33, [0x4D,off4]
 subc. [0x4E,off4], r34, [0x4E,off4]
 subc. [0x4F,off4], r35, [0x4F,off4]
 subc [0x50,off4], r36, [0x50,off4]
L760:
 mov 0x0, [0xC36]
 mov 0x0, [0xC37]
L761:
 jnext 0x3D, L775
L762:
 je r19, 0x14, L775
 mov 0x7FA, SPR_BASE5
 mov 0x4, r36
 calls L74
 jne r36, 0x4, L771
 jnzx 0, 10, [SHM_HOST_FLAGS2], 0x0, L771
 jzx 0, 15, SPR_BASE5, 0x0, L763
 srx 7, 8, [0x03,off5], 0x0, r34
 orx 7, 8, [0x04,off5], r34, r34
 jmp L764
L763:
 or [0x03,off5], 0x0, r34
L764:
 mov 0x0, SPR_TSF_0x64
 jnext COND_PSM(8), L765
 jnzx 0, 0, SPR_TSF_0x0e, 0x0, L771
 or r34, 0x0, SPR_NAV_ALLOCATION
 orx 4, 11, 0x3, SPR_NAV_CTL, SPR_NAV_CTL
 jmp L771
L765:
 jnext 0x63, L768
 jnzx 3, 6, SPR_RXE_0x16, 0x0, L768
 jzx 0, 0, SPR_TSF_0x02, 0x0, L767
 jzx 0, 1, SPR_TSF_0x02, 0x0, L766
 jnzx 0, 2, SPR_TSF_0x02, 0x0, L771
 jmp L771
L766:
 jmp L771
L767:
 jmp L771
L768:
 jnext 0x67, L769
 or r34, 0x0, SPR_TSF_0x16
 jmp L771
L769:
 jnext 0x68, L770
 or r34, 0x0, SPR_TSF_0x1a
 jmp L771
L770:
 or r34, 0x0, SPR_TSF_0x1e
L771:
 jnext 0x3D, L775
 jext 0x3E, L775
 je r19, 0x14, L775
 jnext COND_PSM(8), L775
 mov 0x7FA, SPR_BASE5
 mov 0x5, r36
 calls L74
 jne r36, 0x5, L775
 jzx 0, 15, SPR_BASE5, 0x0, L772
 srx 7, 8, [0x01,off5], 0x0, r8
 srx 7, 8, [0x02,off5], 0x0, r33
 jmp L773
L772:
 srx 7, 0, [0x01,off5], 0x0, r8
 srx 7, 0, [0x02,off5], 0x0, r33
L773:
 mul [0x582], 0xC, r34
 add [0x057], SPR_PSM_0x5a, SPR_BASE4
 or r8, 0x0, [0x28,off4]
 orx 0, 3, r33, [0x1F,off4], [0x1F,off4]
 orx 0, 15, r33, SPR_TSF_GPT1_STAT, SPR_TSF_GPT1_STAT
 jzx 0, 13, [SHM_HOST_FLAGS4], 0x0, L774
 orx 0, 3, 0x0, [0x1F,off4], [0x1F,off4]
 orx 0, 15, 0x0, SPR_TSF_GPT1_STAT, SPR_TSF_GPT1_STAT
L774:
 orx 0, 13, 0x0, r44, r44
L775:
 jext 0x61, L442
 jmp L572
L776:
 jnext 0x61, L651
 jmp L442
L777:
 jext 0x61, L778
 jnext COND_PSM(8), L651
 jmp L783
L778:
 or [0x08,off1], 0x0, SPR_PMQ_pat_0
 or [0x09,off1], 0x0, SPR_PMQ_pat_1
 or [0x0A,off1], 0x0, SPR_PMQ_pat_2
 mov 0x4, SPR_PMQ_dat
 or [0x016], 0x0, SPR_PMQ_control_low
 jmp L442
L779:
 srx 7, 0, [0x0F,off1], 0x0, r33
 jzx 0, 8, SPR_MHP_Status, 0x0, L780
 srx 7, 0, [0x12,off1], 0x0, r33
L780:
 jne r33, 0x4, L781
 jext 0x61, L442
 jmp L572
L781:
 jne r19, 0x10, L782
 jzx 0, 15, [SHM_HOST_FLAGS5], 0x0, L782
 orx 0, 0, 0x1, r20, r20
L782:
 jext 0x61, L442
L783:
 jzx 0, 0, [SHM_HOST_FLAGS4], 0x0, L784
 jzx 0, 8, SPR_MHP_Status, 0x0, L784
 srx 3, 0, r32, 0x0, r33
 jne r33, 0x5, L784
 mov 0x212, SPR_IFS_slot
L784:
 jzx 0, 0, [0x05,off1], 0x0, L651
 jmp L572
L785:
 mov 0x0, SPR_NAV_0x06
 mov 0x0, SPR_NAV_0x04
 jnext COND_PSM(8), L786
 orx 3, 3, 0x1, SPR_TSF_0x00, SPR_TSF_0x00
 jmp L787
L786:
 srx 3, 2, SPR_RXE_0x16, 0x0, r33
 je r33, 0x0, L649
 orx 3, 3, r33, SPR_TSF_0x00, SPR_TSF_0x00
 jnext 0x62, L649
L787:
 and r14, 0x4, r34
 jand r19, r34, L649
 orx 0, 8, 0x0, SPR_BRC, SPR_BRC
 jmp L649
L788:
 jnext 0x61, L649
 jne r19, 0x21, L789
 or [0x0C,off1], 0x0, SPR_TME_VAL30
 or [0x0B,off1], 0x0, SPR_TME_VAL28
 jnzx 0, 2, [0x0B,off1], 0x0, L439
L789:
 add [0x0AA], 0x1, [0x0AA]
 jnzx 0, 2, [0x0B,off1], 0x0, L639
 jnext COND_PSM(1), L790
 jzx 0, 7, r44, 0x0, L790
 orx 3, 4, 0x6, [0x09,off0], [0x09,off0]
 orx 0, 7, 0x0, r44, r44
L790:
 jzx 1, 0, [0x0B,off1], 0x0, L442
 jmp L572
L791:
 mov 0x0, SPR_PSM_0x4e
 mov 0x0, SPR_PSM_0x0c
 orx 0, 1, 0x1, SPR_PHY_HDR_Parameter, SPR_PHY_HDR_Parameter
 jnzx 0, 5, SPR_MAC_CMD, 0x0, L793
 mov 0xC7F, SPR_BASE5
L792:
 mov 0x0, [0x00,off5]
 sub SPR_BASE5, 0x1, SPR_BASE5
 jges SPR_BASE5, 0x0, L792
L793:
 mov 0x200, r20
 mov 0x0, r43
 mov 0x0, r44
 mov 0x0, r45
 mov 0x0, r46
 mov 0x0, r63
 mov 0xFFFF, r53
 mov 0x1, [SHM_UCODESTAT]
 mov 0x0, r33
 calls L52
 srx 7, 0, SPR_Ext_IHR_Data, 0x0, [SHM_PHYVER]
 srx 3, 8, SPR_Ext_IHR_Data, 0x0, [SHM_PHYTYPE]
 jne [SHM_PHYTYPE], 0x9, L794
 add [SHM_PHYVER], 0x10, [SHM_PHYVER]
 mov 0x4, [SHM_PHYTYPE]
L794:
 mov 0x2, SPR_PHY_HDR_Parameter
 mov 0x0, r39
 mov 0x0, r44
 mov 0x0, r45
 orx 0, 5, 0x1, SPR_PSM_0x70, SPR_PSM_0x70
L795:
 jzx 0, 13, SPR_PSM_0x70, 0x0, L795
 jne [SHM_PHYTYPE], 0x0, L796
 jmp L797
L796:
 jne [SHM_PHYTYPE], 0x4, L797
L797:
 mov 0x357, [SHM_UCODEREV]
 mov 0x411, [SHM_UCODEPATCH]
 mov 0xDA18, [SHM_UCODEDATE]
 mov 0x6B46, [SHM_UCODETIME]
 mov 0x0, [SHM_PCTLWDPOS]
 mov 0x7E5, SPR_BASE1
 mov 0x5A4, SPR_BASE0
 mov 0x0, [0x872]
 or r3, 0x0, r5
 and SPR_TSF_RANDOM, r3, SPR_IFS_BKOFFTIME
 orx 0, 0, 0x1, SPR_PSO_Control, SPR_PSO_Control
 orx 0, 0, 0x1, SPR_RXE_FIFOCTL0, SPR_RXE_FIFOCTL0
 jmp L709
L798:
 orx 1, 0, r23, [RX_HDR_PhyRxStatus_0], [RX_HDR_PhyRxStatus_0]
 // mov 0x840, SPR_RXE_RXHDR_OFFSET
 // mov 0xE, SPR_RXE_RXHDR_LEN
 mov RX_HDR_LEN, SPR_RXE_RXHDR_LEN
 orx 0, 0, 0x1, SPR_RXE_FIFOCTL1, SPR_RXE_FIFOCTL1
 jnzx 0, 12, SPR_DAGG_STAT, 0x0, L799
 mov 0x7, SPR_DAGG_CTL2
L799:
 jext COND_RX_FIFOFULL, L703
 jnext COND_RX_FIFOBUSY, L799
L800:
 jext COND_RX_FIFOFULL, L703
 jext COND_RX_FIFOBUSY, L800
 or r33, 0x0, r33
 jle 0x0, 0x1, L801
L801:
 jext COND_RX_FIFOFULL, L703
 rets
L802:
 jnext 0x42, L803
 add [0x86C], r33, [0x86C]
 or [0x86C], 0x0, r11
 jmp L810
L803:
 jnzx 0, 2, [0x0B,off0], 0x0, L804
 srx 3, 8, [0x09,off0], 0x0, r11
 add r11, r33, r11
 add [0x10,off0], r33, [0x10,off0]
 orx 3, 8, r11, [0x09,off0], [0x09,off0]
 jmp L810
L804:
 or [0x13,off0], 0x0, r11
 srx 6, 0, SPR_AQM_Agg_Stats, 0x0, r34
 jges r33, 0x0, L805
 add [0x19,off0], 0x1, [0x19,off0]
 sub 0x0, r34, r34
L805:
 sub r11, [0x19,off0], r11
 jges r11, 0x0, L806
 or [0x13,off0], 0x0, [0x19,off0]
 mov 0x1, r11
L806:
 jnext COND_PSM(1), L807
 add r11, [0x12,off0], r11
L807:
 jzx 0, 1, [0x02,off0], 0x0, L808
 add [0x15,off0], r34, [0x15,off0]
 jmp L810
L808:
 srx 1, 4, [0x0B,off0], 0x0, r33
 add SPR_BASE0, r33, SPR_BASE5
 srx 7, 0, [0x15,off5], 0x0, r33
 add r33, r34, r33
 jle r33, 0xFF, L809
 mov 0xFF, r33
L809:
 orx 7, 0, r33, [0x15,off5], [0x15,off5]
L810:
 rets
L811:
 jnzx 0, 5, [0x08,off6], 0x0, L814
 srx 1, 4, [0x0B,off0], 0x0, r33
 jge r33, 0x3, L814
 je r14, 0x31, L812
 add r33, 0x1, r33
 jmp L813
L812:
 jne r33, 0x0, L813
 mov 0x1, r33
L813:
 orx 1, 4, r33, [0x0B,off0], [0x0B,off0]
L814:
 rets
L815:
 je [SHM_PHYTYPE], 0x4, L816
 srx 0, 5, SPR_RXE_PHYRXSTAT0, 0x0, [0x871]
 jne [SHM_PHYTYPE], 0x5, L817
 add [0x871], 0x1, [0x871]
 rets
L816:
 mov 0x1, [0x871]
 orx 7, 8, SPR_RXE_PHYRXSTAT1, 0x0, r33
 sra r33, 0x8, r33
 sra SPR_RXE_PHYRXSTAT1, 0x8, r34
 jles r34, r33, L817
 mov 0x4, [0x871]
 srx 0, 5, SPR_RXE_PHYRXSTAT0, 0x0, [0x871]
L817:
 rets
L818:
 jnzx 0, 5, [SHM_HOST_FLAGS1], 0x0, L837
 or SPR_BASE3, 0x0, [0x79E]
 or SPR_BASE2, 0x0, [0x79F]
 or SPR_TSF_WORD0, 0x0, r34
 srx 15, 5, r34, SPR_TSF_WORD1, r33
 mov 0x753, SPR_BASE5
 mov 0x0, r34
 mov 0x736, SPR_BASE4
 mov 0x7A4, SPR_BASE3
L819:
 je [0x00,off5], 0x0, L836
 mov 0x795, SPR_BASE2
 add SPR_BASE2, r34, SPR_BASE2
 sr [0x00,off2], 0x5, r38
 jdn r33, [0x03,off5], L825
 or [0x00,off5], 0x0, r35
L820:
 add [0x03,off5], r38, [0x00,off3]
 add [0x03,off5], r35, [0x03,off5]
 sub [0x0B,off5], 0x1, [0x0B,off5]
 jges [0x0B,off5], 0x0, L821
 sub [0x01,off5], 0x1, [0x0B,off5]
L821:
 jdnz [0x03,off5], r33, L820
 sub [0x03,off5], r33, r36
 sr [0x00,off5], 0x3, r37
 jle r36, r37, L822
 mov 0x1, [0x00,off4]
 mov 0x200, SPR_MAC_IRQHI
 mov 0x1, [0x7A3]
L822:
 jand [0x02,off5], 0x40, L823
 mov 0x1, [0x7AC]
 jmp L825
L823:
 jand [0x02,off5], 0xA0, L825
 orx 0, 7, 0x1, r45, r45
 sl [SHM_NOSLPZNATDTIM], 0x6, SPR_TSF_GPT1_CNTLO
 sr [SHM_NOSLPZNATDTIM], 0xA, SPR_TSF_GPT1_CNTHI
 mov 0xC000, SPR_TSF_GPT1_STAT
 jzx 0, 13, r44, 0x0, L824
 add [0x0A0], 0x1, [0x0A0]
L824:
 orx 0, 13, 0x1, r44, r44
L825:
 jdn r33, [0x00,off3], L827
 je [0x04,off5], 0x0, L826
 orx 1, 0, 0x1, [0x02,off5], [0x02,off5]
 or [0x00,off3], 0x0, r36
 add r36, [0x04,off5], [0x05,off5]
L826:
 add [0x03,off5], r38, [0x00,off3]
 jand [0x02,off5], 0x40, L827
 mov 0x0, [0x7AC]
 orx 0, 12, 0x1, SPR_BRC, SPR_BRC
L827:
 je [0x04,off5], 0x0, L828
 jdn r33, [0x05,off5], L828
 orx 1, 0, 0x2, [0x02,off5], [0x02,off5]
 or [0x00,off3], 0x0, r36
 add r36, [0x04,off5], [0x05,off5]
 mov 0x1, [0x01,off4]
 mov 0x200, SPR_MAC_IRQHI
 mov 0x1, [0x7A3]
L828:
 je [0x06,off5], 0x0, L836
 jdn r33, [0x07,off5], L836
L829:
 jzx 0, 2, [0x02,off5], 0x0, L831
 sub [0x06,off5], 0x1, [0x06,off5]
 or [0x09,off5], 0x0, r35
 add [0x07,off5], r35, [0x07,off5]
 mov 0x7A8, SPR_BASE2
 add SPR_BASE2, r34, SPR_BASE2
 or [0x0A,off5], 0x0, r35
 add [0x00,off2], r35, [0x00,off2]
 jzx 0, 5, [0x00,off2], 0x0, L830
 add [0x07,off5], 0x1, [0x07,off5]
 srx 4, 0, [0x00,off2], 0x0, [0x00,off2]
L830:
 orx 0, 2, 0x0, [0x02,off5], [0x02,off5]
 jmp L832
L831:
 or [0x08,off5], 0x0, r35
 add [0x07,off5], r35, [0x07,off5]
 orx 0, 2, 0x1, [0x02,off5], [0x02,off5]
L832:
 je [0x06,off5], 0x0, L833
 jdnz [0x07,off5], r33, L829
L833:
 jzx 0, 2, [0x02,off5], 0x0, L834
 mov 0x1, [0x02,off4]
 jmp L835
L834:
 mov 0x1, [0x03,off4]
L835:
 mov 0x200, SPR_MAC_IRQHI
 mov 0x1, [0x7A3]
L836:
 add SPR_BASE5, 0xC, SPR_BASE5
 add r34, 0x1, r34
 add SPR_BASE4, 0x4, SPR_BASE4
 add SPR_BASE3, 0x1, SPR_BASE3
 jl r34, 0x4, L819
 or [0x79E], 0x0, SPR_BASE3
 or [0x79F], 0x0, SPR_BASE2
L837:
 rets
L838:
 orx 0, 15, 0x0, r43, r43
 jext COND_TX_DONE, L0
 jne SPR_Received_Frame_Count, 0x0, L0
 jne SPR_TXE0_0x78, 0x20, L0
 je [0x7D1], 0x0, L841
 or [SHM_SPUWKUP], 0x0, r33
 add r33, [SHM_PRETBTT], r33
 add SPR_TSF_WORD0, r33, r34
 jdnz [0x7D1], r34, L840
 jnext 0x3E, L839
 add r33, [0x7D1], r34
 jdpz r34, SPR_TSF_CFP_Start_Low, L840
 jnand 0xBF, SPR_BRC, L0
L839:
 sub [0x7D1], SPR_TSF_WORD0, [0x7AD]
 jmp L842
L840:
 mov 0x0, [0x7AD]
 mov 0x0, [0x7D1]
 jmp L0
L841:
 jnand 0xFF, SPR_BRC, L0
 jnzx 0, 4, SPR_MAC_CMD, 0x0, L0
L842:
 calls L818
 mov 0x753, SPR_BASE4
 add SPR_BASE4, 0x30, r34
L843:
 jne [0x0B,off4], 0x0, L844
 jnzx 0, 3, [0x02,off4], 0x0, L0
L844:
 add SPR_BASE4, 0xC, SPR_BASE4
 jl SPR_BASE4, r34, L843
 jnzx 0, 15, SPR_TSF_GPT1_STAT, 0x0, L0
 jne [0x7AC], 0x0, L0
 jnzx 0, 2, r20, 0x0, L846
 jnzx 0, 6, SPR_MAC_CMD, 0x0, L845
 jnzx 0, 3, r20, 0x0, L847
L845:
 mov 0x0, SPR_SCC_Timer_Low
 mov 0x0, SPR_SCC_Timer_High
 mov 0x8000, SPR_SCC_Divisor
 mov 0x2, SPR_SCC_Control
 orx 1, 2, 0x1, r20, r20
 mov 0x2100, SPR_PSM_0x6e
 mov 0x0, SPR_PSM_0x6c
 mov 0x88, r35
 calls L55
 jmp L0
L846:
 jnzx 0, 1, SPR_SCC_Control, 0x0, L0
 orx 14, 1, SPR_SCC_Timer_Low, 0x0, SPR_SCC_Period_Divisor
 srx 0, 15, SPR_SCC_Timer_Low, 0x0, r33
 orx 14, 1, SPR_SCC_Timer_High, r33, SPR_SCC_Period
 or SPR_SCC_Period, 0x0, SPR_PSM_0x6e
 or SPR_SCC_Period_Divisor, 0x0, SPR_PSM_0x6c
 mov 0x74, r35
 calls L55
 or SPR_SCC_Period, 0x0, [0xC18]
 or SPR_SCC_Period_Divisor, 0x0, [0xC19]
 mov 0x0, SPR_SCC_Period
 mov 0x0, SPR_SCC_Period_Divisor
 sr [0xC19], 0x6, [0xC19]
 or [0xC18], 0x0, r33
 orx 5, 10, r33, [0xC19], [0xC19]
 orx 1, 2, 0x2, r20, r20
 mov 0x40, SPR_MAC_CMD
L847:
 jext 0x25, L866
 orx 0, 11, 0x0, r44, r44
 jzx 0, 9, [SHM_HOST_FLAGS1], 0x0, L848
 mov 0xFFFF, [0x85E]
 mov 0x7FFF, [0x85F]
 jmp L867
L848:
 mov 0x753, SPR_BASE5
 mov 0x795, SPR_BASE4
 mov 0x1, r33
 mov 0xFFFF, r34
 mov 0x0, r35
 mov 0x0, r38
L849:
 je [0x00,off5], 0x0, L863
 mov 0x0, r37
 jzx 0, 6, [0x02,off5], 0x0, L850
 jnzx 0, 0, [0x02,off5], 0x0, L866
 sub. SPR_TSF_CFP_Start_Low, [0x00,off4], r59
 subc SPR_TSF_CFP_Start_High, 0x0, r36
 srx 15, 5, r59, r36, r36
 je [0x04,off5], 0x0, L853
 jmp L852
L850:
 jzx 0, 7, [0x02,off5], 0x0, L856
 or [0x03,off5], 0x0, r36
 je [0x01,off5], 0x1, L851
 je [0x0B,off5], 0x1, L851
 mov 0x1, r37
L851:
 je [0x04,off5], 0x0, L852
 jdnz r36, [0x05,off5], L852
 or [0x05,off5], 0x0, r36
 mov 0x1, r37
L852:
 jand [0x746], r33, L853
 je [0x06,off5], 0x0, L860
 jmp L854
L853:
 sl r33, 0x4, r59
 jand [0x746], r59, L866
 jzx 0, 2, [0x02,off5], 0x0, L866
L854:
 jdnz r36, [0x07,off5], L860
 or [0x07,off5], 0x0, r36
 jand [0x746], r33, L855
 mov 0x1, r37
L855:
 jmp L860
L856:
 jzx 0, 5, [0x02,off5], 0x0, L863
 jzx 0, 9, SPR_MAC_CTLHI, 0x0, L866
 or [0x03,off5], 0x0, r36
 sub [0x0B,off5], 0x1, r59
 jges r59, 0x0, L857
 sub [0x01,off5], 0x1, r59
L857:
 srx 7, 8, [0x05B], 0x0, r0
 jne r0, 0x0, L858
 srx 7, 0, [0x05B], 0x0, r0
 je r0, 0x0, L859
 sub r0, 0x1, r59
 jmp L859
L858:
 sub r0, 0x1, r0
 mul r0, [0x01,off5], r0
 add r59, SPR_PSM_0x5a, r59
L859:
 je r59, 0x0, L860
 add r36, [0x00,off5], r36
 sub r59, 0x1, r59
 jmp L859
L860:
 je r35, 0x0, L861
 jdn r36, r34, L862
 jmp L863
L861:
 mov 0x1, r35
L862:
 or r36, 0x0, r34
 or r37, 0x0, r38
L863:
 sl r33, 0x1, r33
 add SPR_BASE5, 0xC, SPR_BASE5
 add SPR_BASE4, 0x1, SPR_BASE4
 jl r33, 0x10, L849
 je r35, 0x0, L866
 or SPR_TSF_WORD0, 0x0, r37
 srx 15, 5, r37, SPR_TSF_WORD1, r37
 sub r34, r37, r36
 sl r36, 0x5, [0x7A0]
 sr r36, 0xB, [0x7A1]
 or [SHM_SPUWKUP], 0x0, r35
 jzx 0, 13, r44, 0x0, L864
 add r35, 0x3E8, r35
L864:
 jne [0x7A1], 0x0, L865
 jle [0x7A0], r35, L866
L865:
 jext 0x4C, L866
 or r38, 0x0, [0x7A2]
 sub. [0x7A0], r35, [0x85E]
 subc [0x7A1], 0x0, [0x85F]
 jmp L867
L866:
 je [0x7A2], 0x0, L0
 jmp L888
L867:
 jls [0x85F], 0x0, L0
 mov 0x4000, SPR_TSF_GPT0_STAT
 jne [0x7AD], 0x0, L869
 jnzx 0, 1, SPR_PHY_HDR_Parameter, 0x0, L868
 jext 0x25, L888
L868:
 jext 0x25, L714
L869:
 jg [0x85E], SPR_SCC_Fast_Powerup_Delay, L870
 je [0x85F], 0x0, L0
L870:
 sub. [0x85E], SPR_SCC_Fast_Powerup_Delay, SPR_SCC_Timer_Low
 subc [0x85F], 0x0, SPR_SCC_Timer_High
 mov 0x4, [SHM_UCODESTAT]
 je SPR_PHY_HDR_Parameter, 0x0, L872
L871:
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L871
 calls L1081
 orx 0, 1, 0x1, r20, r20
 calls L923
 calls L1164
L872:
 calls L925
 jnext 0x3D, L873
 mov 0x0, SPR_BRWK0
 mov 0x4, SPR_BRWK1
 mov 0x1420, SPR_BRWK2
 mov 0x0, SPR_BRWK3
 je [0x7AD], 0x0, L874
 mov 0x1400, SPR_BRWK2
 jmp L874
L873:
 mov 0x200, SPR_BRWK0
 mov 0x4, SPR_BRWK1
 mov 0x1020, SPR_BRWK2
 mov 0x0, SPR_BRWK3
L874:
 or SPR_SCC_Timer_High, 0x0, SPR_PSM_0x6e
 or SPR_SCC_Timer_Low, 0x0, SPR_PSM_0x6c
 mov 0x78, r35
 calls L55
 mov 0x0, SPR_SCC_Divisor
 mov 0x2, SPR_SCC_Control
L875:
 jnzx 0, 1, SPR_SCC_Control, 0x0, L875
 orx 5, 8, 0x1F, 0x14, SPR_PSM_0x6a
L876:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L876
 or SPR_PSM_0x6c, 0x0, [0xC1A]
 or SPR_PSM_0x6e, 0x0, [0xC1B]
 or SPR_TSF_WORD0, 0x0, [0x87A]
 or SPR_TSF_WORD1, 0x0, [0x879]
 or SPR_TSF_WORD2, 0x0, [0x878]
 or SPR_TSF_WORD3, 0x0, [0x877]
 add. SPR_TSF_WORD0, [0x85E], [0xC38]
 addc SPR_TSF_WORD1, [0x85F], [0xC39]
 mov 0xFFFF, SPR_SCC_Timer_High
 mov 0xFFFF, SPR_SCC_Timer_Low
 mov 0x5, SPR_SCC_Control
L877:
 mov 0x0, SPR_MAC_MAX_NAP
 nap
 jzx 0, 9, [SHM_HOST_FLAGS1], 0x0, L878
 jnext 0x25, L877
L878:
 orx 0, 5, 0x1, SPR_PSM_0x70, SPR_PSM_0x70
 mov 0xFFFF, SPR_TME_MASK0
 mov 0xFFFF, SPR_TME_MASK2
 mov 0xFFFF, SPR_TME_MASK4
 mov 0xFFFF, SPR_TME_MASK6
 mov 0xFFFF, SPR_TME_MASK8
 mov 0xFFFF, SPR_TME_MASK10
 mov 0xFFFF, SPR_TME_MASK12
 mov 0xFFFF, SPR_TME_MASK14
 mov 0xFFFF, SPR_TME_MASK16
 mov 0xFFFF, SPR_TME_MASK18
 mov 0xFFFF, SPR_TME_MASK20
 mov 0xFFFF, SPR_TME_MASK22
 mov 0xFFFF, SPR_TME_MASK24
 mov 0xFFFF, SPR_TME_MASK26
 mov 0xFFFF, SPR_TME_MASK28
 mov 0xFFFF, SPR_TME_MASK30
 mov 0xFFFF, SPR_TME_MASK32
 mov 0xFFFF, SPR_TME_MASK34
 mov 0xFFFF, SPR_TME_MASK36
 mov 0xFFFF, SPR_TME_MASK38
 mov 0xFFFF, SPR_TME_MASK40
 mov 0xFFFF, SPR_TME_MASK42
 mov 0xFFFF, SPR_TME_MASK44
 orx 5, 8, 0x1F, 0x78, SPR_PSM_0x6a
L879:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L879
 je SPR_PSM_0x6c, 0x0, L880
 orx 0, 11, 0x1, r44, r44
L880:
 mov 0x0, SPR_PSM_0x6e
 mov 0x0, SPR_PSM_0x6c
 mov 0x78, r35
 calls L55
 calls L55
 mov 0x0, SPR_SCC_Control
L881:
 mov 0x0, SPR_SCC_Divisor
 mov 0x2, SPR_SCC_Control
L882:
 jnzx 0, 1, SPR_SCC_Control, 0x0, L882
 jzx 0, 15, SPR_PSM_0x70, 0x0, L881
 jext EOI(0x12), L883
L883:
 orx 0, 12, 0x1, SPR_TSF_0x00, SPR_TSF_0x00
 orx 5, 8, 0x1F, 0x14, SPR_PSM_0x6a
L884:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L884
 sub. SPR_PSM_0x6c, [0xC1A], r28
 subc SPR_PSM_0x6e, [0xC1B], r27
 or [0xC19], 0x0, r33
 mul r28, r33, r29
 or SPR_PSM_0x5a, 0x0, r30
 srx 15, 10, r30, r29, r33
 sr r29, 0xA, r34
 add. [0x87A], r33, SPR_TSF_WORD0
 addc. [0x879], r34, SPR_TSF_WORD1
 addc. [0x878], 0x0, SPR_TSF_WORD2
 addc [0x877], 0x0, SPR_TSF_WORD3
 add. [0x3BE], r33, [0x3BE]
 addc [0x3BF], r34, [0x3BF]
 mov 0x2, [SHM_UCODESTAT]
 calls L1164
 or SPR_TSF_0x0e, 0x0, 0x0
 sl SPR_TSF_0x10, 0xA, r35
 sr SPR_TSF_0x10, 0x6, r36
L885:
 or SPR_TSF_CFP_Start_Low, 0x0, r33
 or SPR_TSF_CFP_Start_High, 0x0, r34
 sub. r33, SPR_TSF_WORD0, r33
 subc r34, SPR_TSF_WORD1, r34
 jges r34, 0x0, L886
 add. SPR_TSF_CFP_Start_Low, r35, SPR_TSF_CFP_Start_Low
 addc SPR_TSF_CFP_Start_High, r36, SPR_TSF_CFP_Start_High
 add [0xAEF], 0x1, [0xAEF]
 sub r8, 0x1, r8
 jges r8, 0x0, L885
 sub [SHM_DTIMP], 0x1, r8
 jmp L885
L886:
 orx 0, 12, 0x0, SPR_TSF_0x00, SPR_TSF_0x00
 jnzx 0, 11, r44, 0x0, L888
 je [0x7A2], 0x0, L888
 mov 0x1000, r33
 add SPR_TSF_WORD0, r33, r0
 mov 0x0, [0x7A3]
L887:
 calls L818
 jdp SPR_TSF_WORD0, r0, L888
 je [0x7A3], 0x0, L887
 jmp L847
L888:
 sub. [0xC38], SPR_TSF_WORD0, r33
 subc [0xC39], SPR_TSF_WORD1, r34
 jne r34, 0x0, L889
 mov 0x1388, r35
 jge r33, r35, L889
 orx 0, 4, 0x1, SPR_BRWK3, SPR_BRWK3
 rl r33, 0x3, SPR_TSF_GPT2_CNTLO
 orx 12, 3, r34, SPR_TSF_GPT2_CNTLO, SPR_TSF_GPT2_CNTHI
 mov 0xC000, SPR_TSF_GPT2_STAT
 nap
L889:
 jzx 0, 13, SPR_PSM_0x70, 0x0, L889
 orx 0, 1, 0x0, r20, r20
 mov 0x0, SPR_MAC_MAX_NAP
 mov 0x0, SPR_BRWK0
 mov 0x0, SPR_BRWK1
 mov 0x0, SPR_BRWK2
 mov 0x0, SPR_BRWK3
 calls L924
 calls L930
 mov 0x1420, SPR_BRWK2
 mov 0x0, SPR_MAC_MAX_NAP
 mov 0x0, [0xC3D]
 jne [0x7AD], 0x0, L890
L890:
 or [SHM_PRETBTT], 0x0, SPR_TSF_CFP_PreTBTT
 mov 0x7360, SPR_BRWK0
 mov 0x1, SPR_BRWK1
 mov 0x730F, SPR_BRWK2
 mov 0xE57, SPR_BRWK3
 calls L931
 mov 0x2, [SHM_UCODESTAT]
 mov 0x0, [0x7A2]
 jmp L714
L891:
 srx 1, 0, SPR_TXE0_PHY_CTL, 0x0, r33
 jge r33, 0x2, L893
 mov 0x2EA, SPR_BASE5
 je r33, 0x0, L892
 mov 0x2EB, SPR_BASE5
L892:
 orx 7, 6, [0x00,off5], SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
 calls L898
L893:
 jzx 0, 3, SPR_TXE0_PHY_CTL, 0x0, L894
 orx 7, 6, [0x2EE], SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
L894:
 jzx 0, 7, [SHM_HOST_FLAGS2], 0x0, L897
 mov 0x7F00, r34
 je r33, 0x0, L896
 srx 2, 11, [SHM_CHAN], 0x0, r33
 je r33, 0x2, L895
 jzx 1, 14, SPR_TXE0_PHY_CTL, 0x0, L896
L895:
 mov 0x7F, r34
L896:
 mov 0x75, r33
 calls L54
L897:
 rets
L898:
 jnzx 0, 0, SPR_TXE0_PHY_CTL, 0x0, L899
 srx 0, 4, r0, 0x0, r34
 srx 2, 5, r0, 0x0, SPR_TXE0_PHY_CTL2
 add SPR_TXE0_PHY_CTL2, r34, SPR_TXE0_PHY_CTL2
 jmp L900
L899:
 mov 0x57A, SPR_BASE5
 srx 2, 0, r0, 0x0, r34
 add SPR_BASE5, r34, SPR_BASE5
 or [0x00,off5], 0x0, SPR_TXE0_PHY_CTL2
L900:
 rets
L901:
 or r47, 0x0, r33
 je [0xC1F], 0xFFFF, L902
 or [0xC1F], 0x0, r33
L902:
 orx 1, 14, r33, [SHM_TXFIFO_SIZE01], r34
 orx 1, 0, [0x86B], r34, SPR_TXE0_PHY_CTL
 srx 2, 8, [SHM_CHAN], 0x0, r34
 sr r34, r33, r34
 orx 2, 0, r34, [0x07,off2], SPR_TXE0_PHY_CTL1
 calls L891
 je [0x2EF], 0x0, L903
 je 0xFFFF, SPR_BTCX_CUR_RFACT_Timer, L903
 orx 7, 6, [0x2EF], SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
L903:
 je [0xC1F], 0xFFFF, L904
 orx 0, 7, 0x1, SPR_TXE0_PHY_CTL2, SPR_TXE0_PHY_CTL2
L904:
 je [0x86B], 0x1, L906
 jne [0x86B], 0x0, L905
 jzx 3, 4, [0x01,off2], 0x0, L906
L905:
 srx 0, 13, SPR_RXE_ENCODING, 0x0, r33
 orx 0, 4, r33, SPR_TXE0_PHY_CTL, SPR_TXE0_PHY_CTL
L906:
 rets
L907:
 add [SHM_EDCFSTAT], 0x9, r33
 add r33, [SHM_SLOTT], r33
 add r33, [0x006], r33
 jnzx 1, 0, r1, 0x0, L908
 add r33, 0x64, r33
 jzx 0, 9, [SHM_HOST_FLAGS4], 0x0, L908
 jzx 0, 4, r1, 0x0, L908
 sr [0x006], 0x1, r34
 sub r33, r34, r33
L908:
 rets
L909:
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L910
 calls L971
 rets
L910:
 and SPR_TSF_RANDOM, r5, SPR_IFS_BKOFFTIME
 rets
L911:
 rr [0x00,off5], 0x8, r34
 orx 7, 0, [0x01,off5], r34, r34
 or [0x00,off3], 0x0, [0x882]
 or [0x01,off3], 0x0, [0x883]
 or [0x02,off3], 0x0, [0x884]
 or [0x03,off3], 0x0, [0x885]
 or [0x04,off3], 0x0, [0x886]
 add [0x04,off3], r34, [0x887]
 or [0x00,off5], 0x0, [0x880]
 srx 7, 0, r34, 0x0, [0x881]
 or [0x887], 0x0, r36
 mov 0x0, r34
 or SPR_BASE4, 0x0, SPR_BASE5
L912:
 xor r36, [0x00,off5], r36
 add r1, r34, SPR_BASE3
 tkipl r36, r35
 tkiphs r36, r36
 add r34, 0x1, r34
 xor r36, r35, r36
 add SPR_BASE4, r34, SPR_BASE5
 add [0x00,off3], r36, [0x00,off3]
 or [0x00,off3], 0x0, r36
 jle r34, 0x5, L912
 xor r36, [0x06,off4], r34
 rr r34, 0x1, r34
 add [0x882], r34, [0x882]
 or [0x882], 0x0, r36
 xor r36, [0x07,off4], r34
 rr r34, 0x1, r34
 add [0x883], r34, [0x883]
 rr [0x883], 0x1, r34
 add [0x884], r34, [0x884]
 rr [0x884], 0x1, r34
 add [0x885], r34, [0x885]
 rr [0x885], 0x1, r34
 add [0x886], r34, [0x886]
 rr [0x886], 0x1, r34
 add [0x887], r34, [0x887]
 or [0x887], 0x0, r34
 xor r34, [0x00,off4], r34
 sr r34, 0x1, r34
 orx 7, 8, r34, [0x881], [0x881]
 rets
 mov 0x0, SPR_WEP_0x4c
 mov 0x84, SPR_WEP_0x4e
 mov 0x58, SPR_WEP_0x4c
 add SPR_BASE3, 0x2, SPR_BASE5
 jzx 0, 8, [0x00,off3], 0x0, L913
 add SPR_BASE3, 0x8, SPR_BASE5
L913:
 or [0x00,off5], 0x0, SPR_WEP_0x4e
 or [0x01,off5], 0x0, SPR_WEP_0x4e
 or [0x02,off5], 0x0, SPR_WEP_0x4e
 add SPR_BASE3, 0x5, SPR_BASE5
 jzx 0, 9, [0x00,off3], 0x0, L914
 add SPR_BASE3, 0x8, SPR_BASE5
 jns 0x300, [0x00,off3], L914
 add SPR_BASE3, 0xC, SPR_BASE5
L914:
 or [0x00,off5], 0x0, SPR_WEP_0x4e
 or [0x01,off5], 0x0, SPR_WEP_0x4e
 or [0x02,off5], 0x0, SPR_WEP_0x4e
 mov 0x0, r33
 jzx 0, 13, r20, 0x0, L915
 and [0x0C,off3], 0xF, r33
 jns 0x300, [0x00,off3], L915
 and [0x0F,off3], 0xF, r33
L915:
 or r33, 0x0, SPR_WEP_0x4e
 mov 0x0, SPR_WEP_0x4e
 orx 3, 10, 0x9, SPR_WEP_CTL, SPR_WEP_CTL
 rets
L916:
 je r38, 0x7, L918
 mov 0x100, SPR_WEP_0x48
 or [0x00,off4], 0x0, SPR_WEP_0x4a
 or [0x01,off4], 0x0, SPR_WEP_0x4a
 or [0x02,off4], 0x0, SPR_WEP_0x4a
 or [0x03,off4], 0x0, SPR_WEP_0x4a
 or [0x04,off4], 0x0, SPR_WEP_0x4a
 or [0x05,off4], 0x0, SPR_WEP_0x4a
 or [0x06,off4], 0x0, SPR_WEP_0x4a
 or [0x07,off4], 0x0, SPR_WEP_0x4a
 jne r38, 0x2, L917
 or r35, 0x0, SPR_BASE4
 or [0x00,off4], 0x0, SPR_WEP_0x4a
 or [0x01,off4], 0x0, SPR_WEP_0x4a
 or [0x02,off4], 0x0, SPR_WEP_0x4a
 or [0x03,off4], 0x0, SPR_WEP_0x4a
L917:
 rets
L918:
 mov 0x100, SPR_WEP_0x48
 or [0x00,off4], 0x0, SPR_WEP_0x4a
 or [0x01,off4], 0x0, SPR_WEP_0x4a
 or [0x02,off4], 0x0, SPR_WEP_0x4a
 or [0x03,off4], 0x0, SPR_WEP_0x4a
 or [0x04,off4], 0x0, SPR_WEP_0x4a
 or [0x05,off4], 0x0, SPR_WEP_0x4a
 or [0x06,off4], 0x0, SPR_WEP_0x4a
 or [0x07,off4], 0x0, SPR_WEP_0x4a
 add [0x051], r0, SPR_BASE4
 mov 0x108, SPR_WEP_0x48
 or [0x00,off4], 0x0, SPR_WEP_0x4a
 or [0x01,off4], 0x0, SPR_WEP_0x4a
 or [0x02,off4], 0x0, SPR_WEP_0x4a
 or [0x03,off4], 0x0, SPR_WEP_0x4a
 or [0x04,off4], 0x0, SPR_WEP_0x4a
 or [0x05,off4], 0x0, SPR_WEP_0x4a
 or [0x06,off4], 0x0, SPR_WEP_0x4a
 or [0x07,off4], 0x0, SPR_WEP_0x4a
 orx 7, 8, 0x0, SPR_WEP_IV_Key, SPR_WEP_IV_Key
 rets
L919:
 jnzx 0, 14, SPR_RXE_0x60, 0x0, L919
 orx 0, 12, 0x1, r0, SPR_RXE_0x60
L920:
 jnzx 0, 12, SPR_RXE_0x60, 0x0, L920
 or SPR_RXE_0x62, 0x0, r1
 rets
L921:
 jnzx 0, 14, SPR_RXE_0x60, 0x0, L921
 or r1, 0x0, SPR_RXE_0x62
 orx 0, 13, 0x1, r0, SPR_RXE_0x60
 rets
L922:
 calls L90
 jmp L926
L923:
 mov 0x19E, r33
 calls L52
 or SPR_Ext_IHR_Data, 0x3, r34
 calls L54
 mov 0x8D8, r0
 calls L919
 or r1, 0x0, [0xC2C]
 orx 0, 0, 0x0, r1, r1
 calls L921
 mov 0x8F0, r0
 calls L919
 or r1, 0x0, [0xC2D]
 orx 0, 6, 0x0, r1, r1
 calls L921
 mov 0x8E4, r0
 calls L919
 or r1, 0x0, [0xC2E]
 orx 0, 13, 0x0, r1, r1
 calls L921
 mov 0x0, r34
 mov 0x408, r33
 calls L54
 mov 0x417, r33
 calls L54
 mov 0x1728, r33
 mov 0x4000, r34
 calls L54
 mov 0x80C, r0
 calls L919
 nand r1, 0xBE, r1
 calls L921
 mov 0x8F2, r0
 calls L919
 nand r1, 0x113, r1
 calls L921
 mov 0x97F, r0
 calls L919
 or r1, 0x10, r1
 calls L921
 rets
L924:
 mov 0x80C, r0
 calls L919
 or r1, 0xBE, r1
 calls L921
 mov 0x97F, r0
 calls L919
 nand r1, 0x10, r1
 calls L921
 mov 0x8F2, r0
 calls L919
 or r1, 0x111, r1
 calls L921
 mov 0x1E00, SPR_MAC_MAX_NAP
 nap
 rets
L925:
 orx 0, 5, 0x0, SPR_PSM_0x70, SPR_PSM_0x70
 mov 0x0, SPR_PHY_HDR_Parameter
L926:
 rets
 mov 0xC24, SPR_BASE5
 jzx 0, 1, r20, 0x0, L927
 mov 0xC28, SPR_BASE5
L927:
 mov 0x1725, r33
 or [0x00,off5], 0x0, r34
 calls L54
 mov 0x173E, r33
 or [0x01,off5], 0x0, r34
 calls L54
 rets
L928:
 mov 0x6, SPR_PHY_HDR_Parameter
 mov 0x19E, r33
 calls L52
 or SPR_Ext_IHR_Data, 0x3, r34
 calls L54
 mov 0xE, SPR_PHY_HDR_Parameter
 add SPR_TSF_WORD0, 0x2, r33
L929:
 jne SPR_TSF_WORD0, r33, L929
 nand SPR_PHY_HDR_Parameter, 0x8, SPR_PHY_HDR_Parameter
 mov 0x19E, r33
 calls L52
 nand SPR_Ext_IHR_Data, 0x3, r34
 calls L54
 mov 0x2, SPR_PHY_HDR_Parameter
 rets
L930:
 mov 0x408, r33
 mov 0xC07, r34
 calls L54
 mov 0x960, SPR_MAC_MAX_NAP
 nap
 mov 0xC03, r34
 calls L54
 mov 0x417, r33
 mov 0xD, r34
 calls L54
 mov 0x1728, r33
 mov 0x4180, r34
 calls L54
 mov 0x2580, SPR_MAC_MAX_NAP
 nap
 mov 0x408, r33
 mov 0xC02, r34
 calls L54
 mov 0x960, SPR_MAC_MAX_NAP
 nap
 mov 0x1728, r33
 mov 0x4080, r34
 calls L54
 mov 0x417, r33
 mov 0x4, r34
 calls L54
 mov 0x8D8, r0
 orx 0, 0, 0x1, [0xC2C], r1
 calls L921
 mov 0x8F0, r0
 orx 0, 6, 0x1, [0xC2D], r1
 calls L921
 mov 0xF0, SPR_MAC_MAX_NAP
 nap
 mov 0x8E4, r0
 orx 0, 13, 0x1, [0xC2E], r1
 calls L921
 mov 0x3840, SPR_MAC_MAX_NAP
 nap
 rets
L931:
 mov 0x6, SPR_PHY_HDR_Parameter
 or SPR_PHY_HDR_Parameter, 0x0, 0x0
 mov 0x1, r33
 calls L52
 orx 0, 14, 0x1, SPR_Ext_IHR_Data, r34
 or r34, 0x0, r36
 calls L54
 mov 0x19E, r33
 calls L52
 orx 3, 2, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
 orx 0, 0, 0x1, r34, r34
 or r34, 0x0, r35
 calls L54
 mov 0x2, SPR_PHY_HDR_Parameter
 or SPR_PHY_HDR_Parameter, 0x0, 0x0
 mov 0x1, r33
 orx 0, 14, 0x0, r36, r34
 calls L54
 mov 0x19E, r33
 orx 1, 0, 0x0, r35, r34
 calls L54
 mov 0x16A, r33
 mov 0xFF, r34
 calls L54
 rets
L932:
 jzx 0, 4, SPR_MAC_CMD, 0x0, L941
 jnzx 0, 15, SPR_TSF_GPT1_STAT, 0x0, L941
 or SPR_TSF_WORD0, 0x0, 0x0
 jnzx 0, 4, r20, 0x0, L933
 orx 0, 4, 0x1, r20, r20
 or SPR_TSF_WORD1, 0x0, [0x86D]
L933:
 sub SPR_TSF_WORD1, [0x86D], r36
 jge r36, 0x2, L934
 jnand 0x3F, SPR_BRC, L941
L934:
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L941
 mov 0x271, r33
 mov 0x20, r34
 calls L54
 mov 0x272, r33
 mov 0x200, r34
 calls L54
 or [0x179], 0x0, [0xBFD]
 or [0x17B], 0x0, [0xBFF]
 mov 0x45, [0x18A]
 mov 0x0, SPR_IFS_med_busy_ctl
 mov 0x270, r33
 mov 0x1, r34
 calls L54
L935:
 calls L52
 jnzx 0, 0, SPR_Ext_IHR_Data, 0x0, L935
 mov 0x184, SPR_BASE5
 mov 0x0, [0x184]
 mov 0x0, [0x185]
 mov 0x0, [0x186]
 mov 0x0, [0x187]
 mov 0x0, [0x188]
 mov 0x0, [0x189]
 mov 0x6C2, r34
L936:
 mov 0x0, r35
L937:
 add r34, r35, r33
 calls L52
 addc. [0x00,off5], SPR_Ext_IHR_Data, [0x00,off5]
 add r35, 0x1, r35
 xor SPR_BASE5, 0x1, SPR_BASE5
 jne r35, 0x4, L937
 add SPR_BASE5, 0x2, SPR_BASE5
 mov 0x8C2, r34
 je SPR_BASE5, 0x186, L936
 mov 0xAC2, r34
 je SPR_BASE5, 0x188, L936
 jg r36, 0x1, L939
 add SPR_TSF_WORD0, 0x14, r35
L938:
 jne SPR_IFS_med_busy_ctl, 0x0, L940
 jne r35, SPR_TSF_WORD0, L938
L939:
 or [SHM_CHAN], 0x0, [SHM_JSSIAUX]
 mov 0x10, SPR_MAC_CMD
 mov 0x4, SPR_MAC_IRQHI
 orx 0, 4, 0x0, r20, r20
L940:
 jnext EOI(COND_RX_PLCP), L941
 calls L1157
L941:
 rets
L942:
 jzx 0, 3, SPR_MAC_CMD, 0x0, L944
 jnzx 0, 10, r43, 0x0, L943
 orx 0, 10, 0x1, r43, r43
 or SPR_TSF_WORD0, 0x0, [0x86F]
 or SPR_TSF_WORD1, 0x0, [0x870]
L943:
 sub. SPR_TSF_WORD0, [0x86F], r33
 subc SPR_TSF_WORD1, [0x870], r34
 rl r33, 0x3, r33
 orx 12, 3, r34, r33, r34
 sub. r33, SPR_TSF_GPT2_CNTLO, r33
 subc r34, SPR_TSF_GPT2_CNTHI, r34
 jls r34, 0x0, L944
 mov 0x4000, SPR_TSF_GPT2_STAT
 add. SPR_TSF_GPT2_VALLO, r33, SPR_TSF_GPT2_VALLO
 add. SPR_TSF_GPT2_VALHI, r34, SPR_TSF_GPT2_VALHI
 orx 0, 10, 0x0, r43, r43
 mov 0x8, SPR_MAC_CMD
 mov 0x2, SPR_MAC_IRQHI
L944:
 rets
 or [SHM_TKIP_P1KEYS], 0x0, r33
 calls L54
 rets
L945:
 jzx 0, 3, [0xBF7], 0x0, L946
 jnzx 0, 9, SPR_IFS_STAT, 0x0, L949
L946:
 mov 0x3B4, SPR_BASE5
 add SPR_BASE5, [0xBF7], SPR_BASE5
 jzx 0, 0, [0xBF7], 0x0, L947
 add SPR_BASE5, 0x5, SPR_BASE5
L947:
 mov 0x3BC, r33
 jg SPR_BASE5, r33, L948
 add. [0x00,off5], SPR_IFS_med_busy_ctl, [0x00,off5]
 addc [0x01,off5], 0x0, [0x01,off5]
L948:
 mov 0x0, [0xBF7]
 mov 0x0, SPR_IFS_med_busy_ctl
L949:
 rets
L950:
 je SPR_IFS_0x0e, 0x0, L957
 or SPR_IFS_0x0e, 0x0, r1
 or [0x16D], 0x0, r38
 mov 0x120, SPR_BASE4
 mov 0x584, SPR_BASE5
 mov 0x0, r33
L951:
 jzx 0, 11, r43, 0x0, L954
 or [0x03,off4], 0x0, r0
 je r33, [0x161], L956
 jzx 0, 0, r38, 0x0, L954
 jnzx 0, 8, [0x01,off5], 0x0, L952
 srx 3, 0, [0x07,off4], 0x0, r2
 add r2, 0x1, r2
 orx 3, 0, r2, [0x07,off4], [0x07,off4]
 jmp L953
L952:
 srx 3, 4, [0x07,off4], 0x0, r2
 add r2, 0x1, r2
 orx 3, 4, r2, [0x07,off4], [0x07,off4]
L953:
 orx 14, 1, r0, 0x1, r0
 and r0, [0x02,off4], r0
 or r0, 0x0, [0x03,off4]
 and SPR_TSF_RANDOM, r0, r2
 or r2, 0x0, [0x05,off4]
 add r2, [0x04,off4], [0x06,off4]
 jmp L956
L954:
 or [0x04,off4], 0x0, r2
 sub r1, r2, r37
 jls r37, 0x0, L955
 sub [0x05,off4], r37, [0x05,off4]
 jgs [0x05,off4], 0x0, L955
 mov 0x0, [0x05,off4]
 orx 0, 9, 0x0, [0x07,off4], [0x07,off4]
L955:
 or [0x05,off4], 0x0, r37
 add [0x04,off4], r37, [0x06,off4]
L956:
 add SPR_BASE4, 0x10, SPR_BASE4
 add SPR_BASE5, 0x20, SPR_BASE5
 add r33, 0x1, r33
 sr r38, 0x1, r38
 jne r33, 0x4, L951
 mov 0x0, SPR_IFS_0x0e
L957:
 rets
L958:
 mov 0x0, [0x16C]
 mov 0x0, [0x16D]
 mov 0x150, SPR_BASE4
 mov 0x3, r33
 and SPR_AQM_FIFO_Ready, 0xF, [0x16E]
 or SPR_IFS_0x0e, 0x0, r37
 mov 0xFFFF, r34
L959:
 jl r37, [0x06,off4], L960
 orx 0, 9, 0x0, [0x07,off4], [0x07,off4]
 mov 0x0, [0x05,off4]
 or [0x04,off4], 0x0, [0x06,off4]
L960:
 sl 0x1, r33, r1
 jand [0x16E], r1, L964
 jge r37, [0x04,off4], L961
 jnzx 0, 9, [0x07,off4], 0x0, L961
 orx 0, 9, 0x1, [0x07,off4], [0x07,off4]
 and SPR_TSF_RANDOM, r5, [0x05,off4]
 or [0x04,off4], 0x0, r36
 add r36, [0x05,off4], [0x06,off4]
L961:
 sub [0x06,off4], r37, r36
 jges r36, 0x0, L962
 mov 0x0, r36
L962:
 jne r34, r36, L963
 add [0x16C], 0x1, [0x16C]
 or [0x16D], r1, [0x16D]
L963:
 jle r34, r36, L964
 or r33, 0x0, [0x165]
 or r36, 0x0, r34
 or SPR_BASE4, 0x0, [0x166]
 mov 0x0, [0x16C]
 mov 0x0, [0x16D]
L964:
 sub r33, 0x1, r33
 sub SPR_BASE4, 0x10, SPR_BASE4
 jges r33, 0x0, L959
 or r34, 0x0, [0x164]
 rets
L965:
 or [0x166], 0x0, SPR_BASE4
 or [0x166], 0x0, [0x162]
 or [0x165], 0x0, [0x161]
 or [0x03,off4], 0x0, r5
 or [0x01,off4], 0x0, r3
 or [0x02,off4], 0x0, r4
 srx 3, 0, [0x07,off4], 0x0, r12
 srx 3, 4, [0x07,off4], 0x0, r13
 rets
 or [0x165], 0x0, r0
 je r0, [0x161], L970
 mov 0x0, SPR_TSF_0x24
 mov 0x0, SPR_TSF_0x2a
 or [0x166], 0x0, SPR_BASE4
 jzx 0, 0, SPR_IFS_STAT, 0x0, L967
 or SPR_IFS_0x0e, 0x0, r1
 sub [0x164], r1, r0
 jles r0, 0x0, L966
 or r0, 0x0, SPR_IFS_BKOFFTIME
 jmp L968
L966:
 mov 0x1, SPR_IFS_BKOFFTIME
 jmp L968
L967:
 or [0x164], 0x0, SPR_IFS_BKOFFTIME
L968:
 or [0x160], 0x0, [0x169]
 or [0x162], 0x0, [0x16A]
 or [0x163], 0x0, [0x16B]
 or [0x161], 0x0, [0x168]
 or [0x16A], 0x0, SPR_BASE5
 jnzx 0, 8, [0x07,off5], 0x0, L969
 or r5, 0x0, [0x03,off5]
 orx 3, 0, r12, [0x07,off5], [0x07,off5]
 orx 3, 4, r13, [0x07,off5], [0x07,off5]
L969:
 orx 0, 8, 0x0, [0x07,off5], [0x07,off5]
 or [0x164], 0x0, [0x160]
 or [0x166], 0x0, [0x162]
 or [0x167], 0x0, [0x163]
 or [0x165], 0x0, [0x161]
 or [0x162], 0x0, SPR_BASE4
 or [0x03,off4], 0x0, r5
 or [0x01,off4], 0x0, r3
 or [0x02,off4], 0x0, r4
 orx 3, 0, [0x07,off4], r12, r12
 orx 3, 4, [0x07,off4], r13, r13
L970:
 rets
L971:
 or [0x162], 0x0, SPR_BASE4
 jg SPR_BASE4, 0x150, L974
 and SPR_TSF_RANDOM, r5, r33
 or r33, 0x0, [0x05,off4]
 add [0x04,off4], r33, [0x06,off4]
 or [0x06,off4], 0x0, SPR_IFS_BKOFFTIME
 jzx 0, 0, [SHM_HOST_FLAGS4], 0x0, L972
 jl SPR_BASE4, 0x140, L972
 jzx 0, 1, r43, 0x0, L972
 mov 0x212, SPR_IFS_slot
L972:
 or r33, 0x0, [0x16F]
 jzx 0, 2, r43, 0x0, L973
 or r5, 0x0, [0x03,off4]
L973:
 orx 0, 9, 0x1, [0x07,off4], [0x07,off4]
L974:
 orx 0, 2, 0x0, r43, r43
 rets
L975:
 jzx 0, 2, SPR_IFS_STAT, 0x0, L977
 jnzx 0, 15, SPR_TSF_GPT1_STAT, 0x0, L977
 orx 0, 2, 0x0, r46, r46
 jzx 0, 2, [0xB42], 0x0, L976
 add [0xB44], 0x1, [0xB44]
 orx 0, 2, 0x0, [0xB42], [0xB42]
L976:
 jzx 0, 7, r45, 0x0, L977
 add [0xAEF], 0x1, [0xAEF]
 orx 0, 7, 0x0, r45, r45
L977:
 rets
L978:
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L982
 calls L991
 jzx 0, 5, r44, 0x0, L980
L979:
 je SPR_AQM_FIFO_Ready, 0x0, L838
 jmp L0
L980:
 jnzx 1, 1, [SHM_HOST_FLAGS5], 0x0, L982
 jnzx 0, 8, r63, 0x0, L979
 jnzx 0, 8, r44, 0x0, L979
 jnzx 0, 5, r63, 0x0, L979
 jnzx 0, 4, [0xB05], 0x0, L981
 je [0xAFA], 0x0, L981
 je [0xAE0], 0x0, L982
L981:
 jnzx 0, 9, r43, 0x0, L979
 jnzx 0, 3, r45, 0x0, L979
L982:
 rets
L983:
 orx 0, 5, 0x0, r44, r44
 orx 0, 1, 0x0, r20, r20
 jmp L922
L984:
 jzx 0, 8, [SHM_HOST_FLAGS3], 0x0, L986
 jnzx 0, 9, SPR_BTCX_Stat, 0x0, L989
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L985
 jzx 0, 0, SPR_TXE0_CTL, 0x0, L989
L985:
 je r18, 0x25, L989
 je r18, 0x35, L989
 je r18, 0x31, L989
L986:
 or r44, 0x30, r44
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L987
 jnext COND_4_C7, L988
L987:
 orx 0, 7, 0x1, r44, r44
L988:
 orx 0, 1, 0x1, r20, r20
 jnzx 0, 8, [SHM_HOST_FLAGS3], 0x0, L922
 or [0xAEF], 0x0, r34
 jmp L922
 jmp L922
L989:
 rets
L990:
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L1062
L991:
 je [0xAF4], 0x0, L992
 sub SPR_TSF_WORD0, [0xAF4], r33
 mov 0xFDE8, r34
 jl r33, r34, L992
 sub SPR_TSF_WORD0, r34, [0xAF4]
L992:
 jdnz SPR_TSF_WORD0, [0xAED], L993
 sub SPR_TSF_WORD0, 0x1, [0xAED]
L993:
 jnzx 0, 0, SPR_BTCX_Stat, 0x0, L1011
 orx 0, 14, 0x0, r44, r44
 jzx 0, 14, [SHM_HOST_FLAGS5], 0x0, L994
 orx 0, 0, 0x0, SPR_GPIO_OUT, SPR_GPIO_OUT
L994:
 jzx 0, 4, r45, 0x0, L1062
 orx 0, 4, 0x0, r45, r45
 orx 0, 10, 0x1, SPR_BRPO3, SPR_BRPO3
 jzx 0, 12, r63, 0x0, L995
 orx 0, 6, 0x1, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L983
 jmp L996
L995:
 jzx 0, 5, r44, 0x0, L996
 orx 0, 6, 0x1, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L983
L996:
 jnzx 0, 4, r46, 0x0, L997
 sub SPR_BTCX_RFACT_DUR_Timer, [0xB11], r33
 jg r33, [0xADF], L1002
L997:
 jzx 0, 6, r45, 0x0, L1001
 add [0xB1F], 0x1, [0xB1F]
 mov 0x0, [0xB21]
 je [0xB4B], 0x0, L998
 sub [0xB4B], 0x1, [0xB4B]
L998:
 or [0xB1F], 0x0, r34
 orx 0, 7, 0x0, r45, r45
 jzx 0, 9, r63, 0x0, L999
 jl r34, [0xB20], L999
 orx 0, 9, 0x0, r63, r63
L999:
 jzx 0, 13, r63, 0x0, L1001
 add [0xB2B], 0x10, [0xB2B]
 or SPR_TSF_WORD0, 0x0, [0xB36]
 srx 3, 0, [0xB2B], 0x0, r33
 srx 3, 4, [0xB2B], 0x0, r34
 jg r33, 0x0, L1000
 jge r34, [0xB2C], L1000
 jmp L1001
L1000:
 mov 0x0, [0xB2B]
 orx 0, 13, 0x0, r63, r63
L1001:
 jzx 0, 4, r63, 0x0, L1062
 jne [0xAF4], 0x0, L1062
 or [0xAEB], 0x0, [0xAF4]
 rets
L1002:
 orx 0, 5, 0x0, r63, r63
 jzx 0, 4, r63, 0x0, L1005
 jzx 0, 12, [SHM_HOST_FLAGS3], 0x0, L1003
 jnzx 0, 0, [0xB2E], 0x0, L1003
 or [0xB04], 0x0, r59
 jg [0xAFA], r59, L1062
L1003:
 jzx 0, 4, r63, 0x0, L1005
 sub SPR_BTCX_RFACT_DUR_Timer, [0xB11], r33
 jge r33, [0xB3C], L1004
 sub SPR_TSF_WORD0, [0xB3D], r33
 jl r33, [0xB3E], L1005
L1004:
 or SPR_TSF_WORD0, 0x0, [0xAF4]
 rets
L1005:
 jzx 0, 6, r45, 0x0, L1008
 je [0xAF7], 0x43, L1006
 sub SPR_TSF_WORD0, [0xAE8], [0xAF0]
L1006:
 je [0xB4B], 0x0, L1007
 sub [0xB4B], 0x1, [0xB4B]
L1007:
 add [0xB21], 0x1, [0xB21]
 or [0xB22], 0x0, r33
 jl [0xB21], r33, L1008
 mov 0x0, [0xB1F]
L1008:
 jne [0xAF7], 0x5, L1009
 or SPR_TSF_WORD0, 0x0, [0xB29]
 or SPR_TSF_WORD1, 0x0, [0xB2D]
L1009:
 jne [0xAF7], 0x9, L1010
 or SPR_TSF_WORD0, 0x0, [0xB45]
L1010:
 rets
L1011:
 jzx 0, 14, [SHM_HOST_FLAGS5], 0x0, L1012
 orx 0, 0, 0x1, SPR_GPIO_OUT, SPR_GPIO_OUT
L1012:
 jzx 0, 4, r45, 0x0, L1013
 jnzx 0, 5, r44, 0x0, L1062
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1059
 sub SPR_TSF_WORD0, [0xAEB], r33
 jl r33, [0xAE7], L1062
 orx 0, 4, 0x1, r46, r46
 jmp L1062
L1013:
 orx 0, 10, 0x0, SPR_BRPO3, SPR_BRPO3
 orx 0, 14, 0x1, r44, r44
 add. [0x3FC], 0x1, [0x3FC]
 addc [0x3FD], 0x0, [0x3FD]
 mov 0x0, [0xB11]
 jl SPR_BTCX_CUR_RFACT_Timer, 0xFA, L1014
 or SPR_BTCX_CUR_RFACT_Timer, 0x0, [0xB11]
L1014:
 add SPR_TSF_WORD0, [0xB11], r59
 sub r59, SPR_BTCX_CUR_RFACT_Timer, [0xAEB]
 orx 0, 4, 0x0, r46, r46
 orx 2, 4, 0x1, r45, r45
 orx 0, 4, 0x0, r63, r63
 srx 0, 2, SPR_BTCX_Stat, 0x0, r33
 orx 0, 14, r33, r43, r43
 mov 0x0, [0xB3F]
L1015:
 sub SPR_TSF_WORD0, [0xAEB], r33
 jl r33, [0xB28], L1015
 jl r33, [0xAE7], L1016
 add [0xB12], 0x1, [0xB12]
L1016:
 or [0xADE], 0x0, r51
 mov 0x0, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 or SPR_BTCX_ECI_Data, 0x0, [0xAFE]
 mov 0x1, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 or SPR_BTCX_ECI_Data, 0x0, [0xAFF]
 mov 0x2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 or SPR_BTCX_ECI_Data, 0x0, [0xB00]
 mov 0x3, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 or SPR_BTCX_ECI_Data, 0x0, [0xB01]
 orx 0, 8, 0x0, [SHM_HOST_FLAGS2], [SHM_HOST_FLAGS2]
 jzx 0, 15, [0xB00], 0x0, L1017
 orx 0, 8, 0x1, [SHM_HOST_FLAGS2], [SHM_HOST_FLAGS2]
L1017:
 or [0xAFF], 0x0, r59
 srx 5, 0, r59, 0x0, [0xAF7]
 mov 0x4E2, r59
 jzx 3, 0, [0xB00], 0x0, L1018
 srx 3, 0, [0xB00], 0x0, r38
 mul r38, r59, r59
 or SPR_PSM_0x5a, 0x0, r51
L1018:
 jg [0xAF7], 0xF, L1019
 sl 0x1, [0xAF7], r59
 jnand r59, [0xB1C], L1020
 jmp L1021
L1019:
 sub [0xAF7], 0x10, r59
 sl 0x1, r59, r59
 jand r59, [0xB1D], L1021
L1020:
 orx 0, 5, 0x1, r45, r45
 jzx 0, 9, [SHM_HOST_FLAGS2], 0x0, L1021
 orx 0, 9, 0x1, [0xB3F], [0xB3F]
L1021:
 jg [0xAF7], 0xF, L1023
 jl [0xAF7], 0x2, L1022
 jg [0xAF7], 0x3, L1022
 jne [0xB4B], 0x0, L1025
L1022:
 sl 0x1, [0xAF7], r59
 jnand r59, [0xB0E], L1024
 jmp L1025
L1023:
 sub [0xAF7], 0x10, r59
 sl 0x1, r59, r59
 jand r59, [0xB0F], L1025
L1024:
 orx 0, 8, 0x1, [0xB3F], [0xB3F]
L1025:
 jne [0xAF7], 0x15, L1026
 srx 6, 8, [0xB00], 0x0, r33
 jg r33, 0x30, L1026
 orx 0, 8, 0x0, [0xB3F], [0xB3F]
L1026:
 jne [0xAF7], 0x17, L1027
 srx 1, 11, [0xAFF], 0x0, r33
 srx 1, 13, [0xAFF], 0x0, r34
 je r33, 0x0, L1027
 add r33, r34, r33
 add r33, 0x40, [0xAF7]
 je [0xB4B], 0x0, L1027
 orx 0, 8, 0x0, [0xB3F], [0xB3F]
L1027:
 jne [0xAF7], 0x5, L1029
 jzx 0, 14, r63, 0x0, L1029
 srx 6, 8, [0xB00], 0x0, r35
 jge r35, [0xB3B], L1029
 je r35, 0x0, L1029
 jnzx 0, 7, [0xAFF], 0x0, L1028
 orx 0, 6, 0x1, [0xB3F], [0xB3F]
 jmp L1029
L1028:
 or [0xB30], 0x0, [0xB2A]
 or SPR_TSF_WORD1, 0x0, [0xB31]
L1029:
 jne [0xAF7], 0x9, L1032
 jnzx 0, 3, [0xB2E], 0x0, L1032
 mov 0x0, [0xB14]
 je [0xB45], 0x0, L1032
 sub SPR_TSF_WORD0, [0xB45], r33
 jl r33, [0xB46], L1030
 or [0xB46], 0x0, r34
 add r34, [0xB47], r34
 jge r33, r34, L1031
 jzx 0, 1, [0xB42], 0x0, L1032
L1030:
 orx 0, 10, 0x1, [0xB3F], [0xB3F]
 jmp L1032
L1031:
 orx 0, 1, 0x0, [0xB42], [0xB42]
L1032:
 jne [0xAF7], 0x8, L1033
 or [0xAEB], 0x0, [0xB0B]
 orx 0, 15, 0x1, r63, r63
L1033:
 jzx 0, 15, r63, 0x0, L1034
 orx 0, 3, 0x1, [0xB3F], [0xB3F]
L1034:
 je [0xAF7], 0x1, L1036
 je [0xAF7], 0xF, L1036
 je [0xAF7], 0x18, L1036
 jne [0xAF7], 0x15, L1035
 jnzx 0, 8, [0xB3F], 0x0, L1035
 jmp L1036
L1035:
 jne [0xAF7], 0x4, L1039
L1036:
 orx 0, 4, 0x1, r63, r63
 or [0xAEB], 0x0, [0xAF3]
 jne [0xAF7], 0x18, L1037
 or [SHM_PCTLWDPOS], 0x0, [0xAF7]
 or [0xB19], 0x0, [0xAFA]
 jmp L1038
L1037:
 jne [0xAF7], 0x4, L1039
 srx 3, 8, [0xAFF], 0x0, [0xAFA]
L1038:
 or [0xAEB], 0x0, [0xB02]
L1039:
 jzx 0, 3, r46, 0x0, L1042
 jnzx 0, 9, r63, 0x0, L1040
 jzx 0, 13, r63, 0x0, L1042
L1040:
 or [0xAEF], 0x0, r34
 jge r34, [0xAE2], L1041
 or [0xB1F], 0x0, r33
 jge r33, [0xB20], L1042
L1041:
 orx 0, 5, 0x1, [0xB3F], [0xB3F]
L1042:
 add r51, [0xADF], r51
 orx 0, 2, 0x0, r46, r46
 or [0xB44], 0x0, r33
 or [0xAEF], 0x0, r34
 jl r34, [0xAE2], L1043
 jnzx 0, 7, r45, 0x0, L1045
 jmp L1044
L1043:
 jl r33, [0xB39], L1046
 jnzx 0, 2, [0xB42], 0x0, L1045
L1044:
 or SPR_TSF_CFP_Start_Low, 0x0, r35
 or SPR_TSF_CFP_Start_High, 0x0, r34
 sub. r35, SPR_TSF_WORD0, r35
 subc r34, SPR_TSF_WORD1, r34
 jls r34, 0x0, L1046
 jne r34, 0x0, L1046
 jg r35, r51, L1046
L1045:
 orx 0, 2, 0x1, r46, r46
 calls L1120
L1046:
 mov 0x4E2, r59
 srx 6, 8, [0xB00], 0x0, r34
 mul r34, r59, r59
 or SPR_PSM_0x5a, 0x0, r34
 je [0xAF7], 0x2, L1047
 je [0xAF7], 0x12, L1047
 je [0xAF7], 0x13, L1047
 je [0xAF7], 0x3, L1047
 je [0xAF7], 0x42, L1047
 je [0xAF7], 0x43, L1047
 je [0xAF7], 0x44, L1047
 jmp L1050
L1047:
 orx 0, 6, 0x1, r45, r45
 je r34, 0x0, L1048
 or r34, 0x0, [0xAE0]
 orx 0, 3, 0x1, r46, r46
 add [0xB24], 0x1, [0xB24]
 jg r34, [0xB3A], L1048
 orx 0, 4, 0x1, [0xB3F], [0xB3F]
L1048:
 sub SPR_TSF_WORD0, [0xAEB], r33
 or SPR_TSF_WORD0, 0x0, r35
 je [0xAF7], 0x44, L1049
 sub r35, r33, [0xAE8]
L1049:
 orx 0, 8, 0x0, r63, r63
L1050:
 jnzx 0, 5, r44, 0x0, L1062
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1059
 or [0xAE4], 0x0, r34
 or [0xAE6], 0x0, r35
 jne [0xAF7], 0x4, L1052
 jnzx 0, 0, [0xB2E], 0x0, L1052
 or [0xAFA], 0x0, r33
 jl r33, [0xAFD], L1051
 orx 0, 1, 0x1, [0xB3F], [0xB3F]
L1051:
 je r33, 0x0, L1052
 je [0xB33], 0x0, L1052
 or [0xB33], 0x0, r34
 or [0xB34], 0x0, r35
L1052:
 je r35, 0x0, L1053
 je [0xAF4], 0x0, L1053
 sub SPR_TSF_WORD0, [0xAF4], r33
 add r35, r34, r34
 jl r33, r34, L1053
 orx 0, 2, 0x1, [0xB3F], [0xB3F]
L1053:
 jnzx 0, 3, [0xB05], 0x0, L1054
 jzx 0, 0, r63, 0x0, L1054
 jzx 0, 8, SPR_IFS_STAT, 0x0, L1054
 jext COND_NEED_RESPONSEFR, L1054
 orx 0, 7, 0x1, [0xB3F], [0xB3F]
L1054:
 jnzx 0, 1, [SHM_HOST_FLAGS1], 0x0, L1062
 jnzx 0, 2, r46, 0x0, L1062
 jnzx 0, 4, [0xB2E], 0x0, L1057
 jnzx 0, 3, [0xB3F], 0x0, L1057
 jnzx 0, 1, [0xB3F], 0x0, L1057
 jnzx 0, 2, [0xB3F], 0x0, L1057
 jnzx 0, 4, [0xB3F], 0x0, L1057
 jnzx 1, 1, [SHM_HOST_FLAGS5], 0x0, L1057
 jnzx 0, 5, [0xB3F], 0x0, L1055
 jnzx 0, 6, [0xAFF], 0x0, L1057
 jnzx 0, 6, [0xB3F], 0x0, L1055
 jnzx 0, 10, [0xB3F], 0x0, L1055
 jnzx 0, 8, [0xB3F], 0x0, L1057
 jnzx 0, 9, [0xB3F], 0x0, L1057
L1055:
 jnzx 0, 7, [0xB3F], 0x0, L1057
 jnzx 0, 3, r45, 0x0, L1056
 jzx 0, 9, r43, 0x0, L1056
 jnzx 0, 1, r46, 0x0, L1056
 orx 0, 9, 0x0, r43, r43
 calls L1114
L1056:
 jmp L1062
L1057:
 orx 0, 7, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1058
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1058:
 jne [0xC3D], 0x0, L1059
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1059:
 sub SPR_TSF_WORD0, [0xAEB], r33
 jl r33, [0xADF], L1062
 jnzx 0, 2, [SHM_HOST_FLAGS5], 0x0, L1060
 jzx 0, 1, [SHM_HOST_FLAGS5], 0x0, L1061
 jnzx 0, 8, [0xB3F], 0x0, L1061
 jnzx 0, 1, [0xB3F], 0x0, L1061
L1060:
 orx 0, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 jmp L1062
L1061:
 orx 0, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L984
 jnzx 0, 3, r45, 0x0, L1062
 orx 0, 9, 0x1, r43, r43
 add [0xB03], 0x1, [0xB03]
 jmp L1107
L1062:
 rets
L1063:
 orx 0, 6, 0x0, r45, r45
 orx 0, 4, 0x0, r46, r46
 orx 0, 3, 0x0, r46, r46
 orx 0, 5, 0x0, r63, r63
 orx 0, 9, 0x0, r63, r63
 mov 0x0, [0xB0D]
 mov 0x0, [0xB02]
 mov 0x0, [0xAFA]
 mov 0x0, [0xB24]
 orx 0, 14, 0x0, [0xB35], [0xB35]
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
 rets
L1064:
 orx 0, 15, 0x0, SPR_BTCX_Control, SPR_BTCX_Control
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L1073
 jnzx 0, 7, r63, 0x0, L1079
 orx 0, 7, 0x1, r63, r63
 mov 0x10, SPR_BTCX_PRI_WIN
 or [0xADF], 0x0, SPR_BTCX_TX_Conf_Timer
 orx 0, 10, 0x1, SPR_BRPO3, SPR_BRPO3
 orx 0, 10, 0x1, SPR_BRWK3, SPR_BRWK3
 jnzx 0, 0, SPR_BTCX_Control, 0x0, L1067
 orx 1, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1065
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1065:
 jne [0xC3D], 0x0, L1066
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1066:
 orx 1, 0, 0x3, SPR_BTCX_Control, SPR_BTCX_Control
L1067:
 mov 0x1, r35
 calls L1128
 je [0xAE8], 0x0, L1068
 orx 0, 8, 0x1, r63, r63
 mov 0x0, [0xAE8]
L1068:
 calls L1063
 sub SPR_TSF_WORD1, [0xB38], r33
 jle r33, 0x1, L1069
 or [0xB2F], 0x0, [0xB2A]
 mov 0x0, [0xB29]
 je [0xAF4], 0x0, L1069
 or SPR_TSF_WORD0, 0x0, [0xAF3]
 sub SPR_TSF_WORD0, [0xAE4], [0xAF4]
 or [0xAE6], 0x0, r33
 sub [0xAF4], r33, [0xAF4]
L1069:
 jnzx 0, 1, [SHM_HOST_FLAGS1], 0x0, L1070
 jnzx 0, 1, r46, 0x0, L1072
 jzx 0, 0, SPR_BTCX_Stat, 0x0, L1070
 jnzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1070
 jne SPR_BTCX_CUR_RFACT_Timer, 0xFFFF, L1072
L1070:
 orx 1, 6, 0x3, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 1, 6, [0xB05], SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 je [0xC3D], 0x0, L1071
 sub. SPR_TSF_WORD0, [0xC3D], r38
 subc SPR_TSF_WORD1, [0xC3E], r59
 add. [0x400], r38, [0x400]
 addc [0x401], r59, [0x401]
 mov 0x0, [0xC3D]
L1071:
 orx 0, 4, 0x0, r45, r45
 orx 0, 9, 0x0, r43, r43
 jmp L1109
L1072:
 orx 0, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L984
 orx 0, 4, 0x1, r45, r45
 orx 0, 9, 0x1, r43, r43
 jmp L1109
L1073:
 orx 1, 10, 0x0, SPR_BRWK3, SPR_BRWK3
 orx 1, 0, 0x3, SPR_BTCX_Control, SPR_BTCX_Control
 jnzx 0, 3, [SHM_HOST_FLAGS5], 0x0, L1076
 orx 1, 6, 0x1, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1074
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1074:
 jne [0xC3D], 0x0, L1075
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1075:
 jmp L1078
L1076:
 orx 1, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1077
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1077:
 jne [0xC3D], 0x0, L1078
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1078:
 orx 0, 4, 0x0, r45, r45
 orx 0, 9, 0x0, r43, r43
 calls L1063
L1079:
 rets
L1080:
 or SPR_TSF_WORD1, 0x0, [0xB38]
 jzx 0, 5, r44, 0x0, L1081
 orx 0, 6, 0x1, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L983
L1081:
 jzx 0, 4, [SHM_HOST_FLAGS1], 0x0, L1086
 orx 0, 7, 0x0, r63, r63
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1083
 jzx 0, 1, [SHM_HOST_FLAGS1], 0x0, L1083
 orx 1, 6, 0x3, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 1, 6, [0xB05], SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 je [0xC3D], 0x0, L1082
 sub. SPR_TSF_WORD0, [0xC3D], r38
 subc SPR_TSF_WORD1, [0xC3E], r59
 add. [0x400], r38, [0x400]
 addc [0x401], r59, [0x401]
 mov 0x0, [0xC3D]
L1082:
 jmp L1085
L1083:
 orx 1, 6, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1084
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1084:
 jne [0xC3D], 0x0, L1085
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1085:
 orx 0, 5, 0x0, r44, r44
L1086:
 mov 0x0, r35
 calls L1128
 rets
L1087:
 mov 0x1, r34
L1088:
 jnand 0xFF, SPR_BRC, L1099
 jnand 0x8, SPR_PSM_COND, L1099
 jnzx 0, 0, SPR_TXE0_CTL, 0x0, L1099
 jnzx 0, 8, SPR_IFS_STAT, 0x0, L1099
 jext COND_TX_DONE, L1099
 jne [0xB0D], 0x0, L1099
 jnzx 0, 5, r63, 0x0, L1099
 jnzx 0, 0, r63, 0x0, L1113
 jzx 0, 3, [SHM_HOST_FLAGS3], 0x0, L1109
 jnzx 0, 5, r44, 0x0, L1099
 jzx 0, 9, [SHM_HOST_FLAGS3], 0x0, L1095
 je r34, 0x0, L1090
 jnzx 0, 3, r46, 0x0, L1095
 or [0xB1A], 0x0, r33
 jle [0xB14], r33, L1090
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1095
 je [0xAE0], 0x0, L1089
 je [0xAE8], 0x0, L1090
 sub SPR_TSF_WORD0, [0xAE8], r33
 sub [0xAE0], r33, r33
 jles r33, [0xAE1], L1095
 jles r33, [0xB0C], L1095
L1089:
 je [0xAF3], 0x0, L1095
L1090:
 jnzx 2, 8, [0x794], 0x0, L1091
 jzx 0, 7, r20, 0x0, L1093
 jmp L1092
L1091:
 srx 2, 8, [0x794], 0x0, r38
 sr [0x746], r38, r38
 jzx 0, 0, r38, 0x0, L1093
L1092:
 or [0xB1B], 0x0, [0xAE1]
 jmp L1109
L1093:
 mov 0x12, r18
 mov 0xFFFF, SPR_TME_MASK12
 mov MAC_SUBTYPE_DATA_NULL, SPR_TME_VAL12
 orx 0, 12, r34, SPR_TME_VAL12, SPR_TME_VAL12
 orx 0, 8, 0x1, SPR_TME_VAL12, SPR_TME_VAL12
 je [0xAF5], 0x0, L1094
 orx 0, 11, 0x1, SPR_TME_VAL12, SPR_TME_VAL12
L1094:
 mov 0x1C, r2
 calls L1102
 or [0x03,off2], 0x0, SPR_TME_VAL14
 add SPR_TME_VAL14, [0xB13], SPR_TME_VAL14
 mov 0x0, SPR_TME_VAL34
 add [0xAF5], 0x1, [0xAF5]
 jmp L1097
L1095:
 jnzx 0, 3, r45, 0x0, L1099
 calls L122
 or r51, 0x0, SPR_TME_VAL14
 je [0xAE0], 0x0, L1096
 or [0xAF0], 0x0, SPR_TME_VAL14
 jnzx 0, 0, SPR_BTCX_Stat, 0x0, L1096
 sub SPR_TSF_WORD0, [0xAE8], r33
 sub [0xAE0], r33, r33
 jls r33, 0x0, L1096
 add r33, [0xAF0], SPR_TME_VAL14
L1096:
 mov 0xE, r2
 calls L1102
 jmp L1097
L1097:
 orx 1, 0, r1, [SHM_TXFIFO_SIZE01], SPR_TXE0_PHY_CTL
 calls L891
 jne r18, 0x12, L1098
 orx 1, 0, [0x86B], SPR_TXE0_PHY_CTL, r1
 calls L907
 sl r33, 0x3, SPR_TXE0_TIMEOUT
L1098:
 orx 2, 0, 0x2, SPR_BRC, SPR_BRC
 orx 0, 8, 0x1, r44, r44
 mov 0x4C03, SPR_TXE0_CTL
L1099:
 rets
L1100:
 jnzx 0, 0, r63, 0x0, L1101
 jnzx 0, 1, r46, 0x0, L1101
 jzx 0, 3, [SHM_HOST_FLAGS3], 0x0, L1109
 jzx 0, 9, [SHM_HOST_FLAGS3], 0x0, L1109
L1101:
 orx 0, 0, 0x0, r63, r63
 jnzx 0, 1, SPR_AQM_FIFO_Ready, 0x0, L1110
 jzx 0, 1, r46, 0x0, L1110
 mov 0x0, r34
 jmp L1088
L1102:
 jnzx 0, 11, r63, 0x0, L1105
 je r18, 0x31, L1103
 or [0xB07], 0x0, r33
 jge [0xAF5], r33, L1105
 mov 0x9, r0
 or [0xB08], 0x0, r33
 jl [0xAF5], r33, L1104
L1103:
 jnzx 0, 2, [0xB2E], 0x0, L1104
 mov 0xB, r0
L1104:
 mov 0x1, r1
 calls L58
 orx 10, 5, r2, [0x01,off2], SPR_TX_PLCP_HT_Sig0
 or [0x02,off2], 0x0, SPR_TX_PLCP_HT_Sig1
 jmp L1106
L1105:
 jnzx 0, 1, [0xB2E], 0x0, L1103
 mov 0xA, r0
 mov 0x0, r1
 calls L58
 or [0x01,off2], 0x0, SPR_TX_PLCP_HT_Sig0
 sl r2, 0x3, SPR_TX_PLCP_HT_Sig1
L1106:
 rets
L1107:
 je [0xAF6], 0x0, L1109
 jzx 0, 9, r43, 0x0, L1109
 sub SPR_TSF_WORD0, [0xAF6], r36
 jg r36, [0xAE1], L1109
 sl r36, 0x1, r36
 jl r36, [0xAE1], L1109
 calls L1125
 jmp L1114
L1108:
 sub SPR_TSF_WORD0, [0xAF6], r36
 sl r36, 0x1, r36
 calls L1125
L1109:
 jmp L1114
L1110:
 jnzx 0, 9, r43, 0x0, L1111
 orx 0, 1, 0x0, r46, r46
 jmp L1114
L1111:
 je [0xB13], 0x0, L1113
 add SPR_TSF_WORD0, [0xB13], [0xB0D]
 je [0xB14], 0x0, L1112
 add SPR_TSF_WORD0, [0xB0C], [0xB0D]
L1112:
 rets
L1113:
 orx 0, 0, 0x1, r63, r63
 je [0xAF6], 0x0, L1114
 sub SPR_TSF_WORD0, [0xAF6], r36
 calls L1125
L1114:
 orx 0, 8, 0x0, r44, r44
 mov 0x0, [0xAF6]
 mov 0x0, [0xB0D]
 mov 0x0, [0xAF5]
 srx 0, 9, r43, 0x0, r33
 orx 0, 3, r33, r45, r45
 jnzx 0, 9, r43, 0x0, L1115
 orx 0, 0, 0x1, SPR_PSM_COND, SPR_PSM_COND
 rets
L1115:
 or [0xADD], 0x0, r35
 jzx 0, 8, [SHM_HOST_FLAGS2], 0x0, L1116
 or [0xAE5], 0x0, r35
L1116:
 jzx 0, 3, r46, 0x0, L1117
 or [0xADC], 0x0, r35
L1117:
 add SPR_TSF_WORD0, r35, [0xAED]
 or SPR_TSF_WORD0, 0x0, [0xB3D]
 orx 0, 7, 0x0, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 0, 0, 0x0, SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 jzx 0, 14, r44, 0x0, L1118
 orx 0, 14, 0x0, r44, r44
 add. [0x3FE], 0x1, [0x3FE]
 addc [0x3FF], 0x0, [0x3FF]
L1118:
 jne [0xC3D], 0x0, L1119
 or SPR_TSF_WORD0, 0x0, [0xC3D]
 or SPR_TSF_WORD1, 0x0, [0xC3E]
L1119:
 rets
L1120:
 jzx 0, 5, r44, 0x0, L1121
 orx 0, 6, 0x1, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 calls L983
L1121:
 jzx 0, 7, SPR_BTCX_Transmit_Control, 0x0, L1122
 jnzx 0, 9, r43, 0x0, L1122
 jnzx 0, 1, r46, 0x0, L1122
 jnzx 0, 0, r63, 0x0, L1122
 jzx 0, 3, r45, 0x0, L1124
L1122:
 orx 1, 6, 0x3, SPR_BTCX_Transmit_Control, SPR_BTCX_Transmit_Control
 mov 0xC2, SPR_BTCX_ECI_Address
 or SPR_BTCX_ECI_Address, 0x0, 0x0
 orx 1, 6, [0xB05], SPR_BTCX_ECI_Data, SPR_BTCX_ECI_Data
 je [0xC3D], 0x0, L1123
 sub. SPR_TSF_WORD0, [0xC3D], r38
 subc SPR_TSF_WORD1, [0xC3E], r59
 add. [0x400], r38, [0x400]
 addc [0x401], r59, [0x401]
 mov 0x0, [0xC3D]
L1123:
 orx 0, 7, 0x0, [0xB42], [0xB42]
 orx 0, 3, 0x1, r45, r45
 orx 0, 9, 0x0, r43, r43
 mov 0x0, [0xAF5]
L1124:
 rets
L1125:
 je [0xB10], 0x0, L1126
 or [0xB10], 0x0, r36
L1126:
 jl r36, [0xAE4], L1127
 or [0xAE4], 0x0, r36
L1127:
 sl [0xAFB], 0x1, r37
 sub [0xAFC], r37, [0xAFC]
 sl r36, 0x1, r36
 add [0xAFC], r36, [0xAFC]
 sr [0xAFC], 0x5, [0xAFB]
 or [0xAFB], 0x0, [0xAE1]
 rets
L1128:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L1128
 mov 0x1800, SPR_PSM_0x76
 mov 0x100, SPR_PSM_0x74
 mov 0x1FE0, SPR_PSM_0x6a
L1129:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L1129
 orx 0, 8, r35, SPR_PSM_0x6c, SPR_PSM_0x6c
 orx 5, 8, 0x2F, 0xE0, SPR_PSM_0x6a
L1130:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L1130
 rets
L1131:
 mov 0x0, SPR_AQM_BASSN
 mov 0x0, SPR_AQM_REFSN
 mov 0xFFFF, SPR_AQM_RCVD_BA0
 mov 0xFFFF, SPR_AQM_RCVD_BA1
 mov 0xFFFF, SPR_AQM_RCVD_BA2
 mov 0xFFFF, SPR_AQM_RCVD_BA3
 orx 0, 7, 0x1, SPR_TXE0_FIFO_PRI_RDY, SPR_TXE0_FIFO_PRI_RDY
 or SPR_TXE0_FIFO_PRI_RDY, 0x0, 0x0
L1132:
 jnzx 0, 7, SPR_TXE0_FIFO_PRI_RDY, 0x0, L1132
 rets
L1133:
 jext COND_PSM(1), L1134
 mov 0x1, SPR_AQM_RCVD_BA0
 mov 0x0, SPR_AQM_BASSN
 mov 0x0, SPR_AQM_REFSN
 mov 0x0, SPR_AQM_Max_IDX
 jmp L1135
L1134:
 or [0x0D,off1], 0x0, SPR_AQM_RCVD_BA0
 or [0x0E,off1], 0x0, SPR_AQM_RCVD_BA1
 or [0x0F,off1], 0x0, SPR_AQM_RCVD_BA2
 or [0x10,off1], 0x0, SPR_AQM_RCVD_BA3
 sr [0x0C,off1], 0x4, SPR_AQM_BASSN
 sr [0x07,off0], 0x4, SPR_AQM_REFSN
 or [0x1B,off0], 0x0, SPR_AQM_Max_IDX
L1135:
 orx 0, 7, 0x1, SPR_TXE0_FIFO_PRI_RDY, SPR_TXE0_FIFO_PRI_RDY
 or r7, 0x0, r35
 jzx 0, 8, [SHM_HOST_FLAGS1], 0x0, L1136
 add 0x180, [SHM_TXFCUR], SPR_BASE5
 jg SPR_BASE5, 0x183, L1136
 srx 3, 8, [0x00,off5], 0x0, r35
L1136:
 jnzx 0, 7, SPR_TXE0_FIFO_PRI_RDY, 0x0, L1136
 jzx 0, 1, [0x02,off0], 0x0, L1137
 add [0x16,off0], SPR_AQM_ACK_Control, [0x16,off0]
 jmp L1139
L1137:
 srx 1, 4, [0x0B,off0], 0x0, r33
 add SPR_BASE0, r33, SPR_BASE4
 srx 7, 8, [0x15,off4], 0x0, r33
 add r33, SPR_AQM_ACK_Control, r33
 jle r33, 0xFF, L1138
 mov 0xFF, r33
L1138:
 orx 7, 8, r33, [0x15,off4], [0x15,off4]
L1139:
 jge r11, r35, L386
 mov 0x0, [0x14,off0]
 jnzx 0, 0, SPR_AQM_Upd_BA0, 0x0, L386
 jl r11, [0x1C,off0], L425
 calls L811
 jmp L425
L1140:
 mov 0xFFFF, SPR_AQM_Max_Agg_Len_Low
 mov 0x0, SPR_AQM_Max_Agg_Len_High
 jnzx 0, 3, [0x0A,off0], 0x0, L1141
 mov 0xFC0, SPR_AQM_Agg_Params
 mov 0x0, SPR_AQM_Min_MPDU_Length
 jmp L1149
L1141:
 srx 7, 0, [0x6AD], 0x0, r33
 jzx 1, 4, [0x0B,off0], 0x0, L1142
 srx 7, 8, [0x6AD], 0x0, r33
L1142:
 sub r33, 0x1, r33
 orx 5, 6, [0x6AF], r33, SPR_AQM_Agg_Params
 je [0x1A,off0], 0x0, L1143
 sub [0x1A,off0], 0x1, r34
 orx 5, 6, r34, r33, SPR_AQM_Agg_Params
L1143:
 sr SPR_TSF_0x2a, 0x4, r34
 jext 0x28, L1144
 mov 0xFFFF, r34
L1144:
 srx 11, 4, [0x6AE], 0x0, r33
 jge r34, r33, L1145
 or r34, 0x0, r33
L1145:
 mul r33, r40, r33
 jnzx 0, 0, [0x00,off6], 0x0, L1147
 jne r33, 0x0, L1146
 or SPR_PSM_0x5a, 0x0, SPR_AQM_Max_Agg_Len_Low
L1146:
 jmp L1148
L1147:
 mov 0xF, SPR_AQM_Max_Agg_Len_High
 jnzx 11, 4, r33, 0x0, L1148
 or SPR_PSM_0x5a, 0x0, SPR_AQM_Max_Agg_Len_Low
 or r33, 0x0, SPR_AQM_Max_Agg_Len_High
L1148:
 jzx 3, 0, [0x6AE], 0x0, L1149
 srx 3, 0, [0x6AE], 0x0, r33
 sub 0x7, r33, r33
 sr r40, r33, r33
 add r33, 0x3, r33
 nand r33, 0x3, SPR_AQM_Min_MPDU_Length
L1149:
 or [0x1F,off0], 0x0, SPR_AQM_MAC_Adj_Length
 jzx 0, 13, [0x01,off0], 0x0, L1150
 add SPR_AQM_MAC_Adj_Length, 0x8, SPR_AQM_MAC_Adj_Length
L1150:
 srx 7, 8, [0x04,off0], 0x0, r33
 jzx 0, 0, [0x01,off0], 0x0, L1151
 add SPR_AQM_MAC_Adj_Length, r33, SPR_AQM_MAC_Adj_Length
L1151:
 orx 0, 9, 0x1, SPR_TXE0_FIFO_PRI_RDY, SPR_TXE0_FIFO_PRI_RDY
L1152:
 jnzx 0, 9, SPR_TXE0_FIFO_PRI_RDY, 0x0, L1152
 srx 5, 7, SPR_AQM_Agg_Stats, 0x0, r33
 jle r33, [0x1B,off0], L1153
 or r33, 0x0, [0x1B,off0]
L1153:
 jzx 0, 3, [0x0A,off0], 0x0, L1154
 srx 2, 13, SPR_AQM_Agg_Stats, 0x0, r33
 mov 0xBE4, SPR_BASE5
 add SPR_BASE5, r33, SPR_BASE5
 add [0x00,off5], 0x1, [0x00,off5]
L1154:
 rets
 rets
L1155:
 mov 0x20, SPR_PMQ_dat
 jnzx 0, 0, SPR_PMQ_control_high, 0x0, L1156
 or [0x6BA], 0x0, SPR_PMQ_pat_0
 or [0x6BB], 0x0, SPR_PMQ_pat_1
 or [0x6BC], 0x0, SPR_PMQ_pat_2
 mov 0x2, SPR_PMQ_control_low
 mov 0x40, SPR_MAC_IRQLO
L1156:
 rets
L1157:
 srx 13, 0, 0x0, 0x0, SPR_RXE_0x54
 mov 0x14, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 mov 0x110, SPR_RXE_FIFOCTL1
 or SPR_RXE_FIFOCTL1, 0x0, 0x0
 orx 1, 2, 0x0, SPR_PSM_COND, SPR_PSM_COND
 rets
L1158:
 orx 0, 6, 0x1, SPR_PSM_0x70, SPR_PSM_0x70
 or SPR_PSM_0x70, 0x0, 0x0
 or SPR_TSF_WORD0, 0x0, r33
L1159:
 je r33, SPR_TSF_WORD0, L1159
 orx 1, 4, 0x1, SPR_PHY_HDR_Parameter, SPR_PHY_HDR_Parameter
 or SPR_PHY_HDR_Parameter, 0x0, 0x0
 jext EOI(0x34), L1160
L1160:
 mov 0x0, [0x3CA]
 jne [0x3C9], 0x0, L1161
 mov 0xC000, SPR_TSF_GPT2_STAT
L1161:
 rets
L1162:
 je [0xB2C], 0x0, L1163
 or [0xB36], 0x0, r33
 add r33, [0xB37], r33
 jdpz r33, SPR_TSF_WORD0, L1163
 orx 0, 13, 0x1, r63, r63
L1163:
 rets
L1164:
 mov 0xD, r33
 mov 0x47, r34
 calls L54
 mov 0xE, r33
 mov 0x0, r34
 calls L54
 mov 0x684, SPR_BASE5
 add SPR_BASE5, 0x80, r35
 je [SHM_UCODESTAT], 0x2, L1166
L1165:
 je SPR_BASE5, r35, L1167
 mov 0xF, r33
 calls L52
 or SPR_Ext_IHR_Data, 0x0, [0x00,off5]
 mov 0x10, r33
 calls L52
 or SPR_Ext_IHR_Data, 0x0, [0x01,off5]
 add SPR_BASE5, 0x2, SPR_BASE5
 jmp L1165
L1166:
 je SPR_BASE5, r35, L1167
 mov 0x10, r33
 or [0x01,off5], 0x0, r34
 calls L54
 mov 0xF, r33
 or [0x00,off5], 0x0, r34
 add SPR_BASE5, 0x2, SPR_BASE5
 calls L54
 jmp L1166
L1167:
 rets
L1168:
 or r33, 0x0, r35
 or r34, 0x0, SPR_BASE5
L1169:
 or [0x00,off5], 0x0, r33
 or [0x01,off5], 0x0, r34
 calls L54
 add SPR_BASE5, 0x2, SPR_BASE5
 sub r35, 0x1, r35
 jne r35, 0x0, L1169
 rets
L1170:
 or r33, 0x0, r35
 or r34, 0x0, SPR_BASE5
L1171:
 or [0x00,off5], 0x0, r0
 or [0x01,off5], 0x0, r1
 calls L921
 add SPR_BASE5, 0x2, SPR_BASE5
 sub r35, 0x1, r35
 jne r35, 0x0, L1171
 rets
L1172:
 mov 0x19E, r33
 calls L52
 or SPR_Ext_IHR_Data, 0x3, r34
 calls L54
 jzx 0, 0, [0x3CF], 0x0, L1173
 calls L1199
L1173:
 mov 0x3CB, SPR_BASE3
 mov 0x0, r36
 mov 0x7, SPR_TXE0_FIFO_PRI_RDY
 srx 8, 9, [0x3D0], 0x3, SPR_TXE0_FIFO_Head
 srx 8, 0, [0x3D0], 0x0, SPR_TXE0_FIFO_Read_Pointer
L1174:
 or [0x00,off3], 0x0, r37
 je r37, 0x0, L1190
 mov 0x0, r59
L1175:
 mov 0xFC8, SPR_TXE0_AGGFIFO_CMD
 or [0x00A], 0x0, r38
 jg r37, [0x00A], L1176
 or r37, 0x0, r38
L1176:
 or r38, 0x0, SPR_TXE0_FIFO_Write_Pointer
 orx 0, 15, 0x1, SPR_TXE0_FIFO_Head, SPR_TXE0_FIFO_Head
L1177:
 jnext COND_TX_BUSY, L1177
L1178:
 jext COND_TX_BUSY, L1178
 je r36, 0x1, L1180
 je r36, 0x2, L1180
 sr r38, 0x2, r33
 mov 0x7E4, r34
 jne r36, 0x0, L1179
 calls L1170
 jne r36, 0x3, L1189
L1179:
 calls L1168
 jmp L1189
L1180:
 mov 0x7E4, SPR_BASE5
 or r38, 0x0, [0x3D1]
L1181:
 jne r59, 0x0, L1182
 mov 0xD, r33
 srx 5, 10, [0x00,off5], 0x0, r34
 calls L54
 mov 0xE, r33
 srx 9, 0, [0x00,off5], 0x0, r34
 calls L54
 or [0x01,off5], 0x0, r59
 add SPR_BASE5, 0x2, SPR_BASE5
 sub r38, 0x4, r38
 je r38, 0x0, L1188
L1182:
 sr r38, 0x1, r33
 je r36, 0x1, L1183
 sr r38, 0x2, r33
L1183:
 jle r33, r59, L1184
 or r59, 0x0, r33
L1184:
 sub r59, r33, r59
 sl r33, 0x1, r35
 je r36, 0x1, L1185
 sl r33, 0x2, r35
L1185:
 sub r38, r35, r38
 je r36, 0x2, L1186
 calls L1191
 jmp L1187
L1186:
 calls L1194
L1187:
 jne r38, 0x0, L1181
L1188:
 or [0x3D1], 0x0, r38
L1189:
 sub r37, r38, r37
 orx 0, 9, 0x1, SPR_TXE0_FIFO_Head, SPR_TXE0_FIFO_Head
 mov 0x0, SPR_TXE0_FIFO_Read_Pointer
 jne r37, 0x0, L1175
 jne r36, 0x0, L1190
 calls L1198
L1190:
 add SPR_BASE3, 0x1, SPR_BASE3
 add r36, 0x1, r36
 jl r36, 0x4, L1174
 mov 0x0, [0x3D0]
 mov 0x19E, r33
 calls L52
 nand SPR_Ext_IHR_Data, 0x3, r34
 calls L54
 rets
L1191:
 je r33, 0x0, L1193
 add SPR_BASE5, r33, r33
L1192:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L1192
 or [0x00,off5], 0x0, SPR_Ext_IHR_Data
 add SPR_BASE5, 0x1, SPR_BASE5
 orx 1, 13, 0x2, 0xF, SPR_Ext_IHR_Address
 jne SPR_BASE5, r33, L1192
 jzx 0, 0, SPR_BASE5, 0x0, L1193
 add SPR_BASE5, 0x1, SPR_BASE5
 sub r38, 0x2, r38
L1193:
 rets
L1194:
 je r33, 0x0, L1197
 sl r33, 0x1, r33
 add SPR_BASE5, r33, r33
L1195:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L1195
 or [0x01,off5], 0x0, SPR_Ext_IHR_Data
 orx 1, 13, 0x2, 0x10, SPR_Ext_IHR_Address
L1196:
 jnzx 0, 14, SPR_Ext_IHR_Address, 0x0, L1196
 or [0x00,off5], 0x0, SPR_Ext_IHR_Data
 add SPR_BASE5, 0x2, SPR_BASE5
 orx 1, 13, 0x2, 0xF, SPR_Ext_IHR_Address
 jne SPR_BASE5, r33, L1195
L1197:
 rets
L1198:
 mov 0x2B, r33
 calls L52
 orx 0, 0, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
 mov 0x2E, r33
 calls L52
 orx 0, 2, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
 mov 0x2E, r33
 calls L52
 orx 0, 2, 0x1, SPR_Ext_IHR_Data, r34
 calls L54
 mov 0x2B, r33
 calls L52
 orx 0, 0, 0x1, SPR_Ext_IHR_Data, r34
 calls L54
 rets
L1199:
 jzx 0, 1, [0x3CF], 0x0, L1200
 mov 0x9, r33
 calls L52
 orx 0, 0, 0x0, SPR_Ext_IHR_Data, r34
 calls L54
L1200:
 or SPR_PHY_HDR_Parameter, 0x0, r35
 orx 0, 2, 0x1, SPR_PHY_HDR_Parameter, SPR_PHY_HDR_Parameter
 or [0x055], 0x1, r33
 calls L52
 orx 1, 14, 0x3, SPR_Ext_IHR_Data, r34
 jzx 0, 1, [0x3CF], 0x0, L1201
 orx 1, 14, 0x0, SPR_Ext_IHR_Data, r34
L1201:
 calls L54
 or r35, 0x0, SPR_PHY_HDR_Parameter
 jnzx 0, 1, [0x3CF], 0x0, L1202
 mov 0x9, r33
 calls L52
 orx 0, 0, 0x1, SPR_Ext_IHR_Data, r34
 calls L54
L1202:
 mov 0x0, [0x3CF]
 rets
 mov 0x1800, SPR_PSM_0x76
 mov 0x0, SPR_PSM_0x74
 orx 5, 8, 0x1F, r33, SPR_PSM_0x6a
L1203:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L1203
 rets
 mov 0x1800, SPR_PSM_0x76
 or r34, 0x0, SPR_PSM_0x74
 orx 5, 8, 0x2F, r33, SPR_PSM_0x6a
L1204:
 jnzx 0, 14, SPR_PSM_0x6a, 0x0, L1204
 rets
 @0 @0, @0, @0
