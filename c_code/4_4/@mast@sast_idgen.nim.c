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
typedef struct tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q;
typedef struct tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A;
typedef struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag tyObject_TSym__RjHO5eqpy8QqcomFydmCag;
typedef struct tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ;
typedef struct RootObj RootObj;
typedef struct TNimTypeV2 TNimTypeV2;
typedef struct tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw;
typedef struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw;
typedef struct tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ;
typedef struct tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg;
struct tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A {
NI rc;
NI rootIdx;
};
struct tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q {
NI32 module;
NI32 symId;
NI32 typeId_0;
NIM_BOOL sealed;
};
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
struct tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw {
NI32 module;
NI32 item;
};
struct tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ {
  RootObj Sup;
tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw itemId;
};
typedef NU8 tyEnum_TSymKind__QC5XTxbIvp03IeGJbMaNmw;
typedef NU16 tyEnum_TMagic__dZ79abhKgFxImGqMv0skU9cQ;
struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q {
NU16 line;
NI16 col;
NI32 fileIndex;
};
typedef NU64 tySet_tyEnum_TSymFlag__83TyF66HwB5ghwWNcLZSIw;
typedef NU32 tySet_tyEnum_TOption__SHwCAjDOxx4rq5Aq5de5Dw;
typedef NU8 tyEnum_TLocKind__s3UJ0JRj0Uh0nsoOkqjTUg;
typedef NU8 tyEnum_TStorageLoc__E4nyHqvvj5aRD9chA1gJIbg;
typedef NU16 tySet_tyEnum_TLocFlag__E4lzeJwyOgwvXtsvUNDh5Q;
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
struct tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ {
tyEnum_TLocKind__s3UJ0JRj0Uh0nsoOkqjTUg k;
tyEnum_TStorageLoc__E4nyHqvvj5aRD9chA1gJIbg storage;
tySet_tyEnum_TLocFlag__E4lzeJwyOgwvXtsvUNDh5Q flags;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* lode;
NimStringV2 r;
};
struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag {
  tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ Sup;
tyEnum_TSymKind__QC5XTxbIvp03IeGJbMaNmw kind;
union{
struct {tyObject_TSym__RjHO5eqpy8QqcomFydmCag* gcUnsafetyReason;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* transformedBody;
} _kind_1;
struct {tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* internal;
} _kind_2;
struct {tyObject_TSym__RjHO5eqpy8QqcomFydmCag* guard;
NI bitsize;
NI alignment;
} _kind_3;
};
tyEnum_TMagic__dZ79abhKgFxImGqMv0skU9cQ magic;
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* typ;
tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA* name;
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q info;
tyObject_TSym__RjHO5eqpy8QqcomFydmCag* owner;
tySet_tyEnum_TSymFlag__83TyF66HwB5ghwWNcLZSIw flags;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* ast;
tySet_tyEnum_TOption__SHwCAjDOxx4rq5Aq5de5Dw options;
NI position;
NI offset;
tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ loc;
tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg* annex;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* constraint;
};
static N_INLINE(NIM_BOOL, nimDecRefIsLast)(void* p);
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZast95idgen_19)(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* dest);
N_LIB_PRIVATE N_NIMCALL(void, nimRawDispose)(void* p, NI alignment);
static N_INLINE(void, nimIncRef)(void* p);
N_LIB_PRIVATE N_NIMCALL(void*, nimNewObj)(NI size, NI alignment);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZast95idgen_19)(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* dest) {
}
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y) {
	NI result;
	result = (NI)0;
	result = ((NI) ((NU)((NU64)(((NU) (x))) - (NU64)(((NU) (y))))));
	return result;
}
static N_INLINE(NIM_BOOL, nimDecRefIsLast)(void* p) {
	NIM_BOOL result;
	result = (NIM_BOOL)0;
	{
		tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A* cell;
		NI T5_;
		if (!!((p == NIM_NIL))) goto LA3_;
		T5_ = (NI)0;
		T5_ = minuspercent___system_704(((NI) (ptrdiff_t) (p)), ((NI) 16));
		cell = ((tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A*) (T5_));
		{
			{
				if (!((NI)((NI64)((*cell).rc) >> (NU64)(((NI) 4))) == ((NI) 0))) goto LA9_;
				result = NIM_TRUE;
				goto LA6;
			}
			LA9_: ;
			(*cell).rc -= ((NI) 16);
		} LA6: ;
	}
	LA3_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqsink___astZast95idgen_37)(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q** dest, tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* src) {
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = nimDecRefIsLast((*dest));
		if (!T3_) goto LA4_;
		eqdestroy___astZast95idgen_19((*dest));
		nimRawDispose((*dest), ((NI) 4));
	}
	LA4_: ;
	(*dest) = src;
}
static N_INLINE(void, nimIncRef)(void* p) {
	NI T1_;
	T1_ = (NI)0;
	T1_ = minuspercent___system_704(((NI) (ptrdiff_t) (p)), ((NI) 16));
	(*((tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A*) (T1_))).rc += ((NI) 16);
}
N_LIB_PRIVATE N_NIMCALL(void, eqcopy___astZast95idgen_34)(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q** dest, tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* src) {
	{
		if (!src) goto LA3_;
		nimIncRef(src);
	}
	LA3_: ;
	{
		NIM_BOOL T7_;
		T7_ = (NIM_BOOL)0;
		T7_ = nimDecRefIsLast((*dest));
		if (!T7_) goto LA8_;
		eqdestroy___astZast95idgen_19((*dest));
		nimRawDispose((*dest), ((NI) 4));
	}
	LA8_: ;
	(*dest) = src;
}
N_LIB_PRIVATE N_NIMCALL(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q*, idGeneratorFromModule__astZast95idgen_9)(tyObject_TSym__RjHO5eqpy8QqcomFydmCag* m) {
	tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* result;
	tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q* T1_;
	result = (tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q*)0;
	T1_ = (tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q*)0;
	T1_ = (tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q*) nimNewObj(sizeof(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q), NIM_ALIGNOF(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q));
	(*T1_).module = (*m).Sup.itemId.module;
	(*T1_).symId = (*m).Sup.itemId.item;
	(*T1_).typeId_0 = ((NI32) 0);
	result = T1_;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZast95idgen_31)(tyObject_IdGeneratorcolonObjectType___9aJwTlbI8Z2Rnc0ABNPrk4Q** dest) {
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = nimDecRefIsLast((*dest));
		if (!T3_) goto LA4_;
		eqdestroy___astZast95idgen_19((*dest));
		nimRawDispose((*dest), ((NI) 4));
	}
	LA4_: ;
}
