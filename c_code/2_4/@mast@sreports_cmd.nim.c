/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 64
#define NIM_EmulateOverflowChecks

#include "nimbase.h"
#undef LANGUAGE_C
#undef MIPSEB
#undef MIPSEL
#undef PPC
#undef R3000
#undef R4000
#undef i386
#undef linux
#undef mips
#undef near
#undef far
#undef powerpc
#undef unix
#define nimfr_(x, y)
#define nimln_(x, y)
typedef struct TNimTypeV2 TNimTypeV2;
typedef struct tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ;
typedef struct tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA;
typedef struct RootObj RootObj;
typedef struct tyObject_Option__cTvgZv9bZQKykpX2neAdNPw tyObject_Option__cTvgZv9bZQKykpX2neAdNPw;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
struct TNimTypeV2 {
void* destructor;
NI size;
NI align;
NCSTRING name;
void* traceImpl;
void* typeInfoV1;
NI flags;
};
struct RootObj {
TNimTypeV2* m_type;
};
struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q {
NU16 line;
NI16 col;
NI32 fileIndex;
};
struct tyObject_Option__cTvgZv9bZQKykpX2neAdNPw {
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q val;
NIM_BOOL has;
};
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
struct tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ {
NimStringV2 file;
NU16 line;
NI16 col;
};
struct tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA {
  RootObj Sup;
tyObject_Option__cTvgZv9bZQKykpX2neAdNPw location;
tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ reportInst;
tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ reportFrom;
};
typedef NU16 tyEnum_ReportKind__RGGX4GG6fAWgUwwvGKW19bw;
struct tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ {
  tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA Sup;
NimStringV2 cmd;
NimStringV2 msg;
NI code;
tyEnum_ReportKind__RGGX4GG6fAWgUwwvGKW19bw kind;
union{
struct {NimStringV2 exitOut;
NimStringV2 exitErr;
} _kind_1;
};
};
typedef NU8 tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg;
typedef NU16 tyEnum_ReportKind__XLRsU9a9alTvwABeioQpWcfA;
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports_660)(tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ* dest);
N_LIB_PRIVATE TNimTypeV2 NTIv2__QIY3pdocrJtxyXRhTwSNbQ_;
N_LIB_PRIVATE N_NIMCALL(tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg, severity__astZreports95cmd_10)(tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ* report) {
	tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg result;
	result = (tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg)0;
	switch (((tyEnum_ReportKind__XLRsU9a9alTvwABeioQpWcfA) ((*report).kind))) {
	case ((tyEnum_ReportKind__XLRsU9a9alTvwABeioQpWcfA) 535) ... ((tyEnum_ReportKind__XLRsU9a9alTvwABeioQpWcfA) 538):
	{
		result = ((tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg) 1);
	}
	break;
	case ((tyEnum_ReportKind__XLRsU9a9alTvwABeioQpWcfA) 534):
	{
		result = ((tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg) 3);
	}
	break;
	}
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, compiler_reports_cmdDatInit000)(void) {
NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.destructor = (void*)eqdestroy___astZreports_660; NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.size = sizeof(tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ); NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.align = NIM_ALIGNOF(tyObject_CmdReport__QIY3pdocrJtxyXRhTwSNbQ); NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.name = "|compiler.reports_cmd.CmdReport|compiler.reports_base.ReportBase|RootObj|";
; NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.traceImpl = (void*)NIM_NIL; NTIv2__QIY3pdocrJtxyXRhTwSNbQ_.flags = 0;}

