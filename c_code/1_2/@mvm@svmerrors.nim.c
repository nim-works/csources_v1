/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 64

#include "nimbase.h"
#include <string.h>
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
typedef struct tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg;
typedef struct tyTuple__kN8up2W6YKc5YA9avn5mV5w tyTuple__kN8up2W6YKc5YA9avn5mV5w;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw;
typedef struct tyObject_VmTypeMismatch__b2YkQQVQw9bqUxIpu5rICBg tyObject_VmTypeMismatch__b2YkQQVQw9bqUxIpu5rICBg;
typedef struct tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ;
typedef struct tyTuple__meXz8KXqaXZn6NTp4CbtiA tyTuple__meXz8KXqaXZn6NTp4CbtiA;
typedef struct tyObject_Int128__9a9axPfb75jdWY25AamJewkA tyObject_Int128__9a9axPfb75jdWY25AamJewkA;
typedef struct tySequence__O0sgFt9bHfMlIz7qlAwbAEw tySequence__O0sgFt9bHfMlIz7qlAwbAEw;
typedef struct tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content;
typedef struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag tyObject_TSym__RjHO5eqpy8QqcomFydmCag;
typedef struct tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g;
typedef struct tyObject_CatchableError__qrLSDoe2oBoAqNtJ9badtnA tyObject_CatchableError__qrLSDoe2oBoAqNtJ9badtnA;
typedef struct Exception Exception;
typedef struct RootObj RootObj;
typedef struct TNimTypeV2 TNimTypeV2;
typedef struct tySequence__uB9b75OUPRENsBAu4AnoePA tySequence__uB9b75OUPRENsBAu4AnoePA;
typedef struct tySequence__uB9b75OUPRENsBAu4AnoePA_Content tySequence__uB9b75OUPRENsBAu4AnoePA_Content;
typedef struct tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A;
typedef struct tyObject_GcEnv__g0b9ao2MXcYnUpu9b4I8eP9bQ tyObject_GcEnv__g0b9ao2MXcYnUpu9b4I8eP9bQ;
typedef struct tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ;
typedef struct tyTuple__N4J9cV4JZGem3ljqqj5rT0Q tyTuple__N4J9cV4JZGem3ljqqj5rT0Q;
typedef struct tyObject_CellSeq__z4KasHYddby49cXX2MD4LxQ tyObject_CellSeq__z4KasHYddby49cXX2MD4LxQ;
typedef struct tyTuple__0F3Kz25HWtRatQmCDVHWEA tyTuple__0F3Kz25HWtRatQmCDVHWEA;
typedef struct tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA;
typedef struct tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw tySequence__XrT6wRHqo12fVwXeGBWNEw;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content tySequence__XrT6wRHqo12fVwXeGBWNEw_Content;
typedef struct tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ;
typedef struct tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw;
typedef struct tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ;
typedef struct tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg;
typedef struct tyTuple__GKdVZdRSDPlOT338DklnYQ tyTuple__GKdVZdRSDPlOT338DklnYQ;
typedef struct tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA;
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
struct tyTuple__kN8up2W6YKc5YA9avn5mV5w {
NimStringV2 Field0;
NI Field1;
NI Field2;
};
typedef NU8 tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q;
struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q {
NU16 line;
NI16 col;
NI32 fileIndex;
};
struct tyObject_VmTypeMismatch__b2YkQQVQw9bqUxIpu5rICBg {
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* actualType;
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* formalType;
};
typedef NU32 tyArray__o3OkXGrjEd1h16ByV9axwjg[4];
struct tyObject_Int128__9a9axPfb75jdWY25AamJewkA {
tyArray__o3OkXGrjEd1h16ByV9axwjg udata;
};
struct tyTuple__meXz8KXqaXZn6NTp4CbtiA {
tyObject_Int128__9a9axPfb75jdWY25AamJewkA Field0;
tyObject_Int128__9a9axPfb75jdWY25AamJewkA Field1;
tyObject_Int128__9a9axPfb75jdWY25AamJewkA Field2;
};
struct tySequence__O0sgFt9bHfMlIz7qlAwbAEw {
  NI len; tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content* p;
};
struct tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg {
tyTuple__kN8up2W6YKc5YA9avn5mV5w instLoc;
tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q kind;
union{
struct {tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q errLoc;
NimStringV2 errMsg;
} _kind_1;
struct {NimStringV2 callName;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* argAst;
NI argPos;
} _kind_2;
struct {tyObject_VmTypeMismatch__b2YkQQVQw9bqUxIpu5rICBg typeMismatch;
} _kind_3;
struct {tyTuple__meXz8KXqaXZn6NTp4CbtiA indexSpec;
} _kind_4;
struct {NimStringV2 msg;
} _kind_5;
struct {tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* ast;
} _kind_6;
struct {tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* exc;
tySequence__O0sgFt9bHfMlIz7qlAwbAEw trace;
} _kind_7;
struct {tyObject_TSym__RjHO5eqpy8QqcomFydmCag* sym;
} _kind_8;
};
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
struct tySequence__uB9b75OUPRENsBAu4AnoePA {
  NI len; tySequence__uB9b75OUPRENsBAu4AnoePA_Content* p;
};
struct Exception {
  RootObj Sup;
Exception* parent;
NCSTRING name;
NimStringV2 message;
tySequence__uB9b75OUPRENsBAu4AnoePA trace;
Exception* up;
};
struct tyObject_CatchableError__qrLSDoe2oBoAqNtJ9badtnA {
  Exception Sup;
};
struct tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g {
  tyObject_CatchableError__qrLSDoe2oBoAqNtJ9badtnA Sup;
tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg event;
};
struct tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A {
NI rc;
NI rootIdx;
};
struct tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ {
NI len;
NI cap;
tyTuple__N4J9cV4JZGem3ljqqj5rT0Q* d;
};
struct tyTuple__N4J9cV4JZGem3ljqqj5rT0Q {
void** Field0;
TNimTypeV2* Field1;
};
typedef tyTuple__N4J9cV4JZGem3ljqqj5rT0Q tyUncheckedArray__sC1L67m2tqEzJLHInkP5AQ[1];
struct tyObject_CellSeq__z4KasHYddby49cXX2MD4LxQ {
NI len;
NI cap;
tyTuple__0F3Kz25HWtRatQmCDVHWEA* d;
};
struct tyObject_GcEnv__g0b9ao2MXcYnUpu9b4I8eP9bQ {
tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ traceStack;
tyObject_CellSeq__z4KasHYddby49cXX2MD4LxQ toFree;
NI freed;
NI touched;
NI edges;
NI rcSum;
NIM_BOOL keepThreshold;
};
typedef NU32 tySet_tyEnum_TNodeFlag__fdrKmI78CfFMjQBGh89cd4A;
typedef NU8 tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg;
struct tySequence__XrT6wRHqo12fVwXeGBWNEw {
  NI len; tySequence__XrT6wRHqo12fVwXeGBWNEw_Content* p;
};
struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw {
NI32 id;
tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* typ;
tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q info;
tySet_tyEnum_TNodeFlag__fdrKmI78CfFMjQBGh89cd4A flags;
tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg kind;
union{
struct {NI64 intVal;
} _kind_1;
struct {NF floatVal;
} _kind_2;
struct {NimStringV2 strVal;
} _kind_3;
struct {tyObject_TSym__RjHO5eqpy8QqcomFydmCag* sym;
} _kind_4;
struct {tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA* ident;
} _kind_5;
struct {tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA* diag;
} _kind_7;
struct {tySequence__XrT6wRHqo12fVwXeGBWNEw sons;
} _kind_8;
};
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
typedef NU64 tySet_tyEnum_TSymFlag__83TyF66HwB5ghwWNcLZSIw;
typedef NU32 tySet_tyEnum_TOption__SHwCAjDOxx4rq5Aq5de5Dw;
typedef NU8 tyEnum_TLocKind__s3UJ0JRj0Uh0nsoOkqjTUg;
typedef NU8 tyEnum_TStorageLoc__E4nyHqvvj5aRD9chA1gJIbg;
typedef NU16 tySet_tyEnum_TLocFlag__E4lzeJwyOgwvXtsvUNDh5Q;
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
struct tyTuple__GKdVZdRSDPlOT338DklnYQ {
tyObject_TSym__RjHO5eqpy8QqcomFydmCag* Field0;
NI Field1;
};


#ifndef tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content_PP
#define tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content_PP
struct tySequence__O0sgFt9bHfMlIz7qlAwbAEw_Content { NI cap; tyTuple__GKdVZdRSDPlOT338DklnYQ data[SEQ_DECL_SIZE];};
#endif

      struct tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA {
NCSTRING procname;
NI line;
NCSTRING filename;
};


#ifndef tySequence__uB9b75OUPRENsBAu4AnoePA_Content_PP
#define tySequence__uB9b75OUPRENsBAu4AnoePA_Content_PP
struct tySequence__uB9b75OUPRENsBAu4AnoePA_Content { NI cap; tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
#define tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content { NI cap; tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* data[SEQ_DECL_SIZE];};
#endif

      N_LIB_PRIVATE N_NIMCALL(void, eqcopy___astZlexer_672)(tyTuple__kN8up2W6YKc5YA9avn5mV5w* dest, tyTuple__kN8up2W6YKc5YA9avn5mV5w* src);
N_LIB_PRIVATE N_NIMCALL(void*, nimNewObj)(NI size, NI alignment);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___vmZvmerrors_40)(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g* dest);
static N_INLINE(NIM_BOOL, nimDecRefIsLastCyclicDyn)(void* p);
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y);
N_LIB_PRIVATE N_NOINLINE(void, rememberCycle__system_3161)(NIM_BOOL isDestroyAction, tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A* s, TNimTypeV2* desc);
N_LIB_PRIVATE N_NIMCALL(void, nimDestroyAndDispose)(void* p);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___system_3226)(NimStringV2* dest);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___system_3264)(tySequence__uB9b75OUPRENsBAu4AnoePA* dest);
static N_INLINE(NIM_BOOL, nimDecRefIsLast)(void* p);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports95sem_231)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* dest);
N_LIB_PRIVATE N_NIMCALL(void, nimRawDispose)(void* p, NI alignment);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___vmZvmdef_5827)(tySequence__O0sgFt9bHfMlIz7qlAwbAEw* dest);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE N_NIMCALL(void, eqtrace___vmZvmerrors_49)(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g* dest, void* env);
static N_INLINE(void, nimTraceRefDyn)(void* q, void* env);
static N_INLINE(void, add__system_2720)(tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ* s, void** c, TNimTypeV2* t);
N_LIB_PRIVATE N_NOCONV(void*, allocImpl__system_1724)(NI size);
static N_INLINE(void, copyMem__system_1708)(void* dest, void* source, NI size);
static N_INLINE(void, nimCopyMem)(void* dest, void* source, NI size);
N_LIB_PRIVATE N_NOCONV(void, dealloc)(void* p);
N_LIB_PRIVATE N_NIMCALL(void, raiseExceptionEx)(Exception* e, NCSTRING ename, NCSTRING procname, NCSTRING filename, NI line);
N_LIB_PRIVATE TNimTypeV2 NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_;
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y) {
	NI result;
	result = (NI)0;
	result = ((NI) ((NU)((NU64)(((NU) (x))) - (NU64)(((NU) (y))))));
	return result;
}
static N_INLINE(NIM_BOOL, nimDecRefIsLastCyclicDyn)(void* p) {
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
				if (!((NI)((*cell).rc & ((NI) -16)) == ((NI) 0))) goto LA9_;
				result = NIM_TRUE;
				goto LA6;
			}
			LA9_: ;
			(*cell).rc -= ((NI) 16);
		} LA6: ;
		rememberCycle__system_3161(result, cell, (*((TNimTypeV2**) (p))));
	}
	LA3_: ;
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
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___vmZvmerrors_40)(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g* dest) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = nimDecRefIsLastCyclicDyn((*dest).Sup.Sup.parent);
		if (!T3_) goto LA4_;
		nimDestroyAndDispose((*dest).Sup.Sup.parent);
	}
	LA4_: ;
	eqdestroy___system_3226((&(*dest).Sup.Sup.message));
	eqdestroy___system_3264((&(*dest).Sup.Sup.trace));
	{
		NIM_BOOL T8_;
		T8_ = (NIM_BOOL)0;
		T8_ = nimDecRefIsLastCyclicDyn((*dest).Sup.Sup.up);
		if (!T8_) goto LA9_;
		nimDestroyAndDispose((*dest).Sup.Sup.up);
	}
	LA9_: ;
	eqdestroy___system_3226((&(*dest).event.instLoc.Field0));
	switch ((*dest).event.kind) {
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 1):
	{
		eqdestroy___system_3226((&(*dest).event._kind_1.errMsg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 15):
	{
		eqdestroy___system_3226((&(*dest).event._kind_2.callName));
		{
			NIM_BOOL T15_;
			T15_ = (NIM_BOOL)0;
			T15_ = nimDecRefIsLast((*dest).event._kind_2.argAst);
			if (!T15_) goto LA16_;
			eqdestroy___astZreports95sem_231((*dest).event._kind_2.argAst);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest).event._kind_2.argAst, ((NI) 8));
		}
		LA16_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 3):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 19):
	{
		{
			NIM_BOOL T21_;
			T21_ = (NIM_BOOL)0;
			T21_ = nimDecRefIsLast((*dest).event._kind_3.typeMismatch.actualType);
			if (!T21_) goto LA22_;
			nimDestroyAndDispose((*dest).event._kind_3.typeMismatch.actualType);
		}
		LA22_: ;
		{
			NIM_BOOL T26_;
			T26_ = (NIM_BOOL)0;
			T26_ = nimDecRefIsLast((*dest).event._kind_3.typeMismatch.formalType);
			if (!T26_) goto LA27_;
			nimDestroyAndDispose((*dest).event._kind_3.typeMismatch.formalType);
		}
		LA27_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 11):
	{
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 10):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 6):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 18):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 24):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 22):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 21):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 20):
	{
		eqdestroy___system_3226((&(*dest).event._kind_5.msg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 25):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 26):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 27):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 28):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 16):
	{
		{
			NIM_BOOL T34_;
			T34_ = (NIM_BOOL)0;
			T34_ = nimDecRefIsLast((*dest).event._kind_6.ast);
			if (!T34_) goto LA35_;
			eqdestroy___astZreports95sem_231((*dest).event._kind_6.ast);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest).event._kind_6.ast, ((NI) 8));
		}
		LA35_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 2):
	{
		{
			NIM_BOOL T40_;
			T40_ = (NIM_BOOL)0;
			T40_ = nimDecRefIsLast((*dest).event._kind_7.exc);
			if (!T40_) goto LA41_;
			eqdestroy___astZreports95sem_231((*dest).event._kind_7.exc);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest).event._kind_7.exc, ((NI) 8));
		}
		LA41_: ;
		eqdestroy___vmZvmdef_5827((&(*dest).event._kind_7.trace));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 23):
	{
		{
			NIM_BOOL T46_;
			T46_ = (NIM_BOOL)0;
			T46_ = nimDecRefIsLast((*dest).event._kind_8.sym);
			if (!T46_) goto LA47_;
			nimDestroyAndDispose((*dest).event._kind_8.sym);
		}
		LA47_: ;
	}
	break;
	default:
	{
	}
	break;
	}
	}BeforeRet_: ;
}
static N_INLINE(void, nimCopyMem)(void* dest, void* source, NI size) {
	void* T1_;
	T1_ = (void*)0;
	T1_ = memcpy(dest, source, ((size_t) (size)));
	(void)(T1_);
}
static N_INLINE(void, copyMem__system_1708)(void* dest, void* source, NI size) {
	nimCopyMem(dest, source, size);
}
static N_INLINE(void, add__system_2720)(tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ* s, void** c, TNimTypeV2* t) {
	void** colontmp_;
	TNimTypeV2* colontmp__2;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	{
		tyTuple__N4J9cV4JZGem3ljqqj5rT0Q* d;
		void* T5_;
		if (!((*s).cap <= (*s).len)) goto LA3_;
		(*s).cap = (NI)((NI)((*s).cap * ((NI) 3)) / ((NI) 2));
		T5_ = (void*)0;
		T5_ = allocImpl__system_1724(((NI) ((NI)((*s).cap * ((NI) 16)))));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		d = ((tyTuple__N4J9cV4JZGem3ljqqj5rT0Q*) (T5_));
		copyMem__system_1708(((void*) (d)), ((void*) ((*s).d)), ((NI) ((NI)((*s).len * ((NI) 16)))));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		dealloc(((void*) ((*s).d)));
		(*s).d = d;
	}
	LA3_: ;
	colontmp_ = c;
	colontmp__2 = t;
	(*s).d[(*s).len].Field0 = colontmp_;
	(*s).d[(*s).len].Field1 = colontmp__2;
	(*s).len += ((NI) 1);
	}BeforeRet_: ;
}
static N_INLINE(void, nimTraceRefDyn)(void* q, void* env) {
	void** p;
	p = ((void**) (q));
	{
		tyObject_GcEnv__g0b9ao2MXcYnUpu9b4I8eP9bQ* j;
		if (!!(((*p) == NIM_NIL))) goto LA3_;
		j = ((tyObject_GcEnv__g0b9ao2MXcYnUpu9b4I8eP9bQ*) (env));
		add__system_2720((&(*j).traceStack), p, (*((TNimTypeV2**) ((*p)))));
	}
	LA3_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, eqtrace___vmZvmerrors_49)(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g* dest, void* env) {
	nimTraceRefDyn(&(*dest).Sup.Sup.parent, env);
	nimTraceRefDyn(&(*dest).Sup.Sup.up, env);
}
N_LIB_PRIVATE N_NOINLINE(void, raiseVmError__vmZvmerrors_6)(tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg* event, tyTuple__kN8up2W6YKc5YA9avn5mV5w* inst) {
	tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g* T1_;
{	eqcopy___astZlexer_672((&(*event).instLoc), inst);
	T1_ = (tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g*)0;
	T1_ = (tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g*) nimNewObj(sizeof(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g), NIM_ALIGNOF(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g));
	(*T1_).Sup.Sup.Sup.m_type = (&NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_);
	(*T1_).event = (*event);
	raiseExceptionEx((Exception*)T1_, "VmError", "raiseVmError", "vmerrors.nim", 29);
	goto BeforeRet_;
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___vmZvmerrors_81)(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g** dest) {
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = nimDecRefIsLastCyclicDyn((*dest));
		if (!T3_) goto LA4_;
		nimDestroyAndDispose((*dest));
	}
	LA4_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, eqsink___vmZvmerrors_15)(tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg* dest, tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg* src) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	if ((*dest).instLoc.Field0.p != (*src).instLoc.Field0.p) {	eqdestroy___system_3226((&(*dest).instLoc.Field0));
	}
(*dest).instLoc.Field0.len = (*src).instLoc.Field0.len; (*dest).instLoc.Field0.p = (*src).instLoc.Field0.p;
	(*dest).instLoc.Field1 = (*src).instLoc.Field1;
	(*dest).instLoc.Field2 = (*src).instLoc.Field2;
	switch ((*dest).kind) {
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 1):
	{
		eqdestroy___system_3226((&(*dest)._kind_1.errMsg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 15):
	{
		eqdestroy___system_3226((&(*dest)._kind_2.callName));
		{
			NIM_BOOL T5_;
			T5_ = (NIM_BOOL)0;
			T5_ = nimDecRefIsLast((*dest)._kind_2.argAst);
			if (!T5_) goto LA6_;
			eqdestroy___astZreports95sem_231((*dest)._kind_2.argAst);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_2.argAst, ((NI) 8));
		}
		LA6_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 3):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 19):
	{
		{
			NIM_BOOL T11_;
			T11_ = (NIM_BOOL)0;
			T11_ = nimDecRefIsLast((*dest)._kind_3.typeMismatch.actualType);
			if (!T11_) goto LA12_;
			nimDestroyAndDispose((*dest)._kind_3.typeMismatch.actualType);
		}
		LA12_: ;
		{
			NIM_BOOL T16_;
			T16_ = (NIM_BOOL)0;
			T16_ = nimDecRefIsLast((*dest)._kind_3.typeMismatch.formalType);
			if (!T16_) goto LA17_;
			nimDestroyAndDispose((*dest)._kind_3.typeMismatch.formalType);
		}
		LA17_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 11):
	{
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 10):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 6):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 18):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 24):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 22):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 21):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 20):
	{
		eqdestroy___system_3226((&(*dest)._kind_5.msg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 25):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 26):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 27):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 28):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 16):
	{
		{
			NIM_BOOL T24_;
			T24_ = (NIM_BOOL)0;
			T24_ = nimDecRefIsLast((*dest)._kind_6.ast);
			if (!T24_) goto LA25_;
			eqdestroy___astZreports95sem_231((*dest)._kind_6.ast);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_6.ast, ((NI) 8));
		}
		LA25_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 2):
	{
		{
			NIM_BOOL T30_;
			T30_ = (NIM_BOOL)0;
			T30_ = nimDecRefIsLast((*dest)._kind_7.exc);
			if (!T30_) goto LA31_;
			eqdestroy___astZreports95sem_231((*dest)._kind_7.exc);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_7.exc, ((NI) 8));
		}
		LA31_: ;
		eqdestroy___vmZvmdef_5827((&(*dest)._kind_7.trace));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 23):
	{
		{
			NIM_BOOL T36_;
			T36_ = (NIM_BOOL)0;
			T36_ = nimDecRefIsLast((*dest)._kind_8.sym);
			if (!T36_) goto LA37_;
			nimDestroyAndDispose((*dest)._kind_8.sym);
		}
		LA37_: ;
	}
	break;
	default:
	{
	}
	break;
	}
	(*dest).kind = (*src).kind;
	switch ((*dest).kind) {
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 1):
	{
		(*dest)._kind_1.errLoc = (*src)._kind_1.errLoc;
		(*dest)._kind_1.errMsg = (*src)._kind_1.errMsg;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 15):
	{
		(*dest)._kind_2.callName = (*src)._kind_2.callName;
		(*dest)._kind_2.argAst = (*src)._kind_2.argAst;
		(*dest)._kind_2.argPos = (*src)._kind_2.argPos;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 3):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 19):
	{
		(*dest)._kind_3.typeMismatch = (*src)._kind_3.typeMismatch;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 11):
	{
		(*dest)._kind_4.indexSpec = (*src)._kind_4.indexSpec;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 10):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 6):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 18):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 24):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 22):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 21):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 20):
	{
		(*dest)._kind_5.msg = (*src)._kind_5.msg;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 25):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 26):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 27):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 28):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 16):
	{
		(*dest)._kind_6.ast = (*src)._kind_6.ast;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 2):
	{
		(*dest)._kind_7.exc = (*src)._kind_7.exc;
		(*dest)._kind_7.trace = (*src)._kind_7.trace;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 23):
	{
		(*dest)._kind_8.sym = (*src)._kind_8.sym;
	}
	break;
	default:
	{
	}
	break;
	}
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___vmZvmerrors_9)(tyObject_VmEvent__WwamVLTvO0nlpML1tn49bpg* dest) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	eqdestroy___system_3226((&(*dest).instLoc.Field0));
	switch ((*dest).kind) {
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 1):
	{
		eqdestroy___system_3226((&(*dest)._kind_1.errMsg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 15):
	{
		eqdestroy___system_3226((&(*dest)._kind_2.callName));
		{
			NIM_BOOL T5_;
			T5_ = (NIM_BOOL)0;
			T5_ = nimDecRefIsLast((*dest)._kind_2.argAst);
			if (!T5_) goto LA6_;
			eqdestroy___astZreports95sem_231((*dest)._kind_2.argAst);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_2.argAst, ((NI) 8));
		}
		LA6_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 3):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 19):
	{
		{
			NIM_BOOL T11_;
			T11_ = (NIM_BOOL)0;
			T11_ = nimDecRefIsLast((*dest)._kind_3.typeMismatch.actualType);
			if (!T11_) goto LA12_;
			nimDestroyAndDispose((*dest)._kind_3.typeMismatch.actualType);
		}
		LA12_: ;
		{
			NIM_BOOL T16_;
			T16_ = (NIM_BOOL)0;
			T16_ = nimDecRefIsLast((*dest)._kind_3.typeMismatch.formalType);
			if (!T16_) goto LA17_;
			nimDestroyAndDispose((*dest)._kind_3.typeMismatch.formalType);
		}
		LA17_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 11):
	{
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 10):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 6):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 18):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 24):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 22):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 21):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 20):
	{
		eqdestroy___system_3226((&(*dest)._kind_5.msg));
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 25):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 26):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 27):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 28):
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 16):
	{
		{
			NIM_BOOL T24_;
			T24_ = (NIM_BOOL)0;
			T24_ = nimDecRefIsLast((*dest)._kind_6.ast);
			if (!T24_) goto LA25_;
			eqdestroy___astZreports95sem_231((*dest)._kind_6.ast);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_6.ast, ((NI) 8));
		}
		LA25_: ;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 2):
	{
		{
			NIM_BOOL T30_;
			T30_ = (NIM_BOOL)0;
			T30_ = nimDecRefIsLast((*dest)._kind_7.exc);
			if (!T30_) goto LA31_;
			eqdestroy___astZreports95sem_231((*dest)._kind_7.exc);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			nimRawDispose((*dest)._kind_7.exc, ((NI) 8));
		}
		LA31_: ;
		eqdestroy___vmZvmdef_5827((&(*dest)._kind_7.trace));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	case ((tyEnum_VmEventKind__eTgzLRBCQcqciUSHj9a1q1Q) 23):
	{
		{
			NIM_BOOL T36_;
			T36_ = (NIM_BOOL)0;
			T36_ = nimDecRefIsLast((*dest)._kind_8.sym);
			if (!T36_) goto LA37_;
			nimDestroyAndDispose((*dest)._kind_8.sym);
		}
		LA37_: ;
	}
	break;
	default:
	{
	}
	break;
	}
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, compiler_vmerrorsDatInit000)(void) {
NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.destructor = (void*)eqdestroy___vmZvmerrors_40; NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.size = sizeof(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g); NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.align = NIM_ALIGNOF(tyObject_VmError__qkY1B8sHoj9ct1wLxbZ1P4g); NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.name = "|compiler.vmerrors.VmError|CatchableError|Exception|RootObj|";
; NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.traceImpl = (void*)eqtrace___vmZvmerrors_49; NTIv2__qkY1B8sHoj9ct1wLxbZ1P4g_.flags = 0;}

