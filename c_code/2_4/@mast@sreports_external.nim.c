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
typedef struct tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw;
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
struct tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw {
  tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA Sup;
NimStringV2 msg;
tyEnum_ReportKind__RGGX4GG6fAWgUwwvGKW19bw kind;
};
typedef NU8 tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg;
typedef NU16 tyEnum_ReportKind__Nb3od2R9bask9cflZyv89beTA;
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports_812)(tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw* dest);
N_LIB_PRIVATE TNimTypeV2 NTIv2__LlCqMawGT3e4p3j1r19cVzw_;
N_LIB_PRIVATE N_NIMCALL(tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg, severity__astZreports95external_6)(tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw* report) {
	tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg result;
	result = (tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg)0;
	switch (((tyEnum_ReportKind__Nb3od2R9bask9cflZyv89beTA) ((*report).kind))) {
	case ((tyEnum_ReportKind__Nb3od2R9bask9cflZyv89beTA) 23):
	{
		result = ((tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg) 3);
	}
	break;
	case ((tyEnum_ReportKind__Nb3od2R9bask9cflZyv89beTA) 24) ... ((tyEnum_ReportKind__Nb3od2R9bask9cflZyv89beTA) 25):
	{
		result = ((tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg) 1);
	}
	break;
	}
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, compiler_reports_externalDatInit000)(void) {
NTIv2__LlCqMawGT3e4p3j1r19cVzw_.destructor = (void*)eqdestroy___astZreports_812; NTIv2__LlCqMawGT3e4p3j1r19cVzw_.size = sizeof(tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw); NTIv2__LlCqMawGT3e4p3j1r19cVzw_.align = NIM_ALIGNOF(tyObject_ExternalReport__LlCqMawGT3e4p3j1r19cVzw); NTIv2__LlCqMawGT3e4p3j1r19cVzw_.name = "|compiler.reports_external.ExternalReport|compiler.reports_base.ReportBase|RootObj|";
; NTIv2__LlCqMawGT3e4p3j1r19cVzw_.traceImpl = (void*)NIM_NIL; NTIv2__LlCqMawGT3e4p3j1r19cVzw_.flags = 0;}

