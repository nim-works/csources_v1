/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 32
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
typedef struct tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ;
typedef struct tyObject_DebugReportBase__XRBhv0G2cMozNtciQtiH0Q tyObject_DebugReportBase__XRBhv0G2cMozNtciQtiH0Q;
typedef struct tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA;
typedef struct RootObj RootObj;
typedef struct tyObject_Option__cTvgZv9bZQKykpX2neAdNPw tyObject_Option__cTvgZv9bZQKykpX2neAdNPw;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ tyObject_ReportLineInfo__pgZ26CllG5ZGoZyiNZp9aHQ;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyTuple__RatReAwWxXPMMhFBmq29cIQ tyTuple__RatReAwWxXPMMhFBmq29cIQ;
typedef struct tyTuple__qB8t9aA2YcKlbbhdJv0BRnA tyTuple__qB8t9aA2YcKlbbhdJv0BRnA;
typedef struct tyTuple__3k0I0pZ0kPguHeB6bsWYUA tyTuple__3k0I0pZ0kPguHeB6bsWYUA;
typedef struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag tyObject_TSym__RjHO5eqpy8QqcomFydmCag;
typedef struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw;
typedef struct tySequence__dtDa2SDVDw2K759cMbullAw tySequence__dtDa2SDVDw2K759cMbullAw;
typedef struct tySequence__dtDa2SDVDw2K759cMbullAw_Content tySequence__dtDa2SDVDw2K759cMbullAw_Content;
typedef struct tyObject_DebugVmCodeEntry__GFJO0aYw29a0VgGjaHz6fZg tyObject_DebugVmCodeEntry__GFJO0aYw29a0VgGjaHz6fZg;
typedef struct tyTuple__Dw8XXZJaftLunpIqlIWvSQ tyTuple__Dw8XXZJaftLunpIqlIWvSQ;
typedef struct tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ;
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
struct tyObject_DebugReportBase__XRBhv0G2cMozNtciQtiH0Q {
  tyObject_ReportBase__cODuAQhQzLWogsorHGr7HA Sup;
};
typedef NU16 tyEnum_ReportKind__RGGX4GG6fAWgUwwvGKW19bw;
typedef NU32 tySet_tyEnum_TOption__SHwCAjDOxx4rq5Aq5de5Dw;
typedef NU8 tyEnum_TOpcode__KGgiFxdg81Q2wdKj9bZKfEA;
typedef NU8 tyEnum_TRegisterKind__ZPhTrModfAD8eKhjOHemOg;
struct tyTuple__RatReAwWxXPMMhFBmq29cIQ {
NI Field0;
tyEnum_TOpcode__KGgiFxdg81Q2wdKj9bZKfEA Field1;
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q Field2;
tyEnum_TRegisterKind__ZPhTrModfAD8eKhjOHemOg Field3;
tyEnum_TRegisterKind__ZPhTrModfAD8eKhjOHemOg Field4;
tyEnum_TRegisterKind__ZPhTrModfAD8eKhjOHemOg Field5;
};
struct tyTuple__qB8t9aA2YcKlbbhdJv0BRnA {
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q Field0;
tyEnum_TOpcode__KGgiFxdg81Q2wdKj9bZKfEA Field1;
};
struct tySequence__dtDa2SDVDw2K759cMbullAw {
  NI len; tySequence__dtDa2SDVDw2K759cMbullAw_Content* p;
};
struct tyTuple__3k0I0pZ0kPguHeB6bsWYUA {
tyObject_TSym__RjHO5eqpy8QqcomFydmCag* Field0;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* Field1;
tySequence__dtDa2SDVDw2K759cMbullAw Field2;
};
struct tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ {
  tyObject_DebugReportBase__XRBhv0G2cMozNtciQtiH0Q Sup;
tyEnum_ReportKind__RGGX4GG6fAWgUwwvGKW19bw kind;
union{
struct {tySet_tyEnum_TOption__SHwCAjDOxx4rq5Aq5de5Dw optionsNow;
} _kind_1;
struct {tyTuple__RatReAwWxXPMMhFBmq29cIQ vmgenExecFull;
} _kind_2;
struct {tyTuple__qB8t9aA2YcKlbbhdJv0BRnA vmgenExecMinimal;
} _kind_3;
struct {tyTuple__3k0I0pZ0kPguHeB6bsWYUA vmgenListing;
} _kind_4;
};
};
typedef NU8 tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg;
struct tyTuple__Dw8XXZJaftLunpIqlIWvSQ {
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* Field0;
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* Field1;
};
struct tyObject_DebugVmCodeEntry__GFJO0aYw29a0VgGjaHz6fZg {
NIM_BOOL isTarget;
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q info;
NI pc;
NI idx;
tyEnum_TOpcode__KGgiFxdg81Q2wdKj9bZKfEA opc;
union{
struct {tyTuple__Dw8XXZJaftLunpIqlIWvSQ types;
} _opc_1;
struct {tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* ast;
} _opc_2;
};
NI ra;
NI rb;
NI rc;
};


#ifndef tySequence__dtDa2SDVDw2K759cMbullAw_Content_PP
#define tySequence__dtDa2SDVDw2K759cMbullAw_Content_PP
struct tySequence__dtDa2SDVDw2K759cMbullAw_Content { NI cap; tyObject_DebugVmCodeEntry__GFJO0aYw29a0VgGjaHz6fZg data[SEQ_DECL_SIZE];};
#endif

      N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports_759)(tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ* dest);
N_LIB_PRIVATE TNimTypeV2 NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_;
N_LIB_PRIVATE N_NIMCALL(tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg, severity__astZreports95debug_37)(tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ* report) {
	tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg result;
	result = (tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg)0;
	result = ((tyEnum_ReportSeverity__tASZjvREOIP4VdNgI9aXxQg) 0);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, compiler_reports_debugDatInit000)(void) {
NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.destructor = (void*)eqdestroy___astZreports_759; NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.size = sizeof(tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ); NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.align = NIM_ALIGNOF(tyObject_DebugReport__6BPhLQQ9b9btuq0xJYLc8HpQ); NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.name = "|compiler.reports_debug.DebugReport|compiler.reports_base.DebugReportBase|compiler.reports_base.ReportBase|RootObj|";
; NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.traceImpl = (void*)NIM_NIL; NTIv2__6BPhLQQ9b9btuq0xJYLc8HpQ_.flags = 0;}

