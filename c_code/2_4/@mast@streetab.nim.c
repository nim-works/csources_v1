/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 64
#define NIM_EmulateOverflowChecks

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
typedef struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw;
typedef struct tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag tyObject_TSym__RjHO5eqpy8QqcomFydmCag;
typedef struct tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA;
typedef struct tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw tySequence__XrT6wRHqo12fVwXeGBWNEw;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content tySequence__XrT6wRHqo12fVwXeGBWNEw_Content;
typedef struct tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ tyObject_TIdObj__DuA5wzye5tnqAnpSAUR9cGQ;
typedef struct RootObj RootObj;
typedef struct TNimTypeV2 TNimTypeV2;
typedef struct tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw tyObject_ItemId__cbA3fLaKVzAXQnA021sOuw;
typedef struct tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ tyObject_TLoc__Ik9a029aeMXt66O72iuGDqrQ;
typedef struct tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg tyObject_TLib__opd9cJK8MZyP52wj5ECgeMg;
typedef struct tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg;
typedef struct tySequence__lYfh7bqVzVYNloJtd3rj1Q tySequence__lYfh7bqVzVYNloJtd3rj1Q;
typedef struct tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content;
typedef struct tyObject_TNodePair__LP6NKZFGa9aruzfS0NHMYkw tyObject_TNodePair__LP6NKZFGa9aruzfS0NHMYkw;
struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q {
NU16 line;
NI16 col;
NI32 fileIndex;
};
typedef NU32 tySet_tyEnum_TNodeFlag__fdrKmI78CfFMjQBGh89cd4A;
typedef NU8 tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg;
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
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
struct tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA {
NI id;
NimStringV2 s;
tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA* next;
NI h;
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
struct tySequence__lYfh7bqVzVYNloJtd3rj1Q {
  NI len; tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content* p;
};
struct tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg {
NI counter;
tySequence__lYfh7bqVzVYNloJtd3rj1Q data;
};
struct tyObject_TNodePair__LP6NKZFGa9aruzfS0NHMYkw {
NI h;
tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key;
NI val;
};
typedef NU8 tySet_tyEnum_TTypeCmpFlag__72pgRXSg7774cr9aCWVPORw;


#ifndef tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
#define tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content { NI cap; tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content_PP
#define tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content_PP
struct tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content { NI cap; tyObject_TNodePair__LP6NKZFGa9aruzfS0NHMYkw data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content_PP
#define tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content_PP
struct tySequence__lYfh7bqVzVYNloJtd3rj1Q_Content { NI cap; tyObject_TNodePair__LP6NKZFGa9aruzfS0NHMYkw data[SEQ_DECL_SIZE];};
#endif

      static N_INLINE(NI, emarkamp___pureZhashes_3)(NI h, NI val);
N_LIB_PRIVATE N_NIMCALL(NI, toInt__system_1689)(NF f);
N_LIB_PRIVATE N_NIMCALL(NI, hash__pureZhashes_279)(NimStringV2 x);
static N_INLINE(NI, len__astZast95query_205)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* n);
N_LIB_PRIVATE N_NIMCALL(NI, hashTree__astZtreetab_5)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* n);
static N_INLINE(NI, emarkdollar___pureZhashes_18)(NI h);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE N_NIMCALL(NI, nodeTableRawGet__astZtreetab_85)(tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg t, NI k, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, treesEquivalent__astZtreetab_37)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* a, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* b);
static N_INLINE(NIM_BOOL, eqStrings)(NimStringV2 a, NimStringV2 b);
static N_INLINE(NIM_BOOL, equalMem__system_1716)(void* a, void* b, NI size);
static N_INLINE(int, nimCmpMem)(void* a, void* b, NI size);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, sameTypeOrNil__astZtypes_1361)(tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* a, tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ* b, tySet_tyEnum_TTypeCmpFlag__72pgRXSg7774cr9aCWVPORw flags);
static N_INLINE(NI, nextTry__astZastalgo_35)(NI h, NI maxHash);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, mustRehash__astZastalgo_32)(NI length, NI counter);
N_LIB_PRIVATE N_NIMCALL(tySequence__lYfh7bqVzVYNloJtd3rj1Q, newSeq__astZtreetab_168)(NI len);
N_LIB_PRIVATE N_NIMCALL(void, newSeq__astZast_1168)(tySequence__lYfh7bqVzVYNloJtd3rj1Q* s, NI len);
N_LIB_PRIVATE N_NIMCALL(void, nodeTableRawInsert__astZtreetab_126)(tySequence__lYfh7bqVzVYNloJtd3rj1Q* data, NI k, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key, NI val);
N_LIB_PRIVATE N_NIMCALL(void, eqcopy___astZreports95sem_222)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** dest, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* src);
N_LIB_PRIVATE N_NIMCALL(void, eqsink___astZast_1291)(tySequence__lYfh7bqVzVYNloJtd3rj1Q* dest, tySequence__lYfh7bqVzVYNloJtd3rj1Q src);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZast_1285)(tySequence__lYfh7bqVzVYNloJtd3rj1Q* dest);
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(NI, emarkamp___pureZhashes_3)(NI h, NI val) {
	NI result;
	NU h_2;
	NU val_2;
	NU res;
	result = (NI)0;
	h_2 = ((NU) (h));
	val_2 = ((NU) (val));
	res = (NU)((NU64)(h_2) + (NU64)(val_2));
	res = (NU)((NU64)(res) + (NU64)((NU)((NU64)(res) << (NU64)(((NI) 10)))));
	res = (NU)(res ^ (NU)((NU64)(res) >> (NU64)(((NI) 6))));
	result = ((NI) (res));
	return result;
}
static N_INLINE(NI, len__astZast95query_205)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* n) {
	NI result;
	NI T1_;
	result = (NI)0;
	T1_ = (*n)._kind_8.sons.len;
	result = T1_;
	return result;
}
static N_INLINE(NI, emarkdollar___pureZhashes_18)(NI h) {
	NI result;
	NU h_2;
	NU res;
	result = (NI)0;
	h_2 = ((NU) (h));
	res = (NU)((NU64)(h_2) + (NU64)((NU)((NU64)(h_2) << (NU64)(((NI) 3)))));
	res = (NU)(res ^ (NU)((NU64)(res) >> (NU64)(((NI) 11))));
	res = (NU)((NU64)(res) + (NU64)((NU)((NU64)(res) << (NU64)(((NI) 15)))));
	result = ((NI) (res));
	return result;
}
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NI, hashTree__astZtreetab_5)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* n) {
	NI result;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (NI)0;
	{
		if (!(n == 0)) goto LA3_;
		goto BeforeRet_;
	}
	LA3_: ;
	result = (*n).kind;
	switch ((*n).kind) {
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 1):
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 23):
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 4):
	{
	}
	break;
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 2):
	{
		result = emarkamp___pureZhashes_3(result, (*(*n)._kind_5.ident).h);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 3):
	{
		tyObject_TSym__RjHO5eqpy8QqcomFydmCag* xX60gensym0_;
		xX60gensym0_ = (tyObject_TSym__RjHO5eqpy8QqcomFydmCag*)0;
		xX60gensym0_ = (*n)._kind_4.sym;
		result = emarkamp___pureZhashes_3(result, (NI)((NI)((NU64)(((NI) ((*xX60gensym0_).Sup.itemId.module))) << (NU64)(((NI) 24))) + ((NI) ((*xX60gensym0_).Sup.itemId.item))));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 5) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 15):
	{
		NIM_BOOL colontmp_;
		colontmp_ = (NIM_BOOL)0;
		{
			colontmp_ = ((IL64(-9223372036854775807) - IL64(1)) <= (*n)._kind_1.intVal);
			{
				if (!!(colontmp_)) goto LA12_;
				goto LA9;
			}
			LA12_: ;
			colontmp_ = ((*n)._kind_1.intVal <= IL64(9223372036854775807));
		} LA9: ;
		{
			if (!colontmp_) goto LA16_;
			result = emarkamp___pureZhashes_3(result, ((NI) ((*n)._kind_1.intVal)));
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		}
		LA16_: ;
	}
	break;
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 16) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 18):
	{
		NIM_BOOL colontmp__2;
		colontmp__2 = (NIM_BOOL)0;
		{
			colontmp__2 = (-1000000.0 <= (*n)._kind_2.floatVal);
			{
				if (!!(colontmp__2)) goto LA22_;
				goto LA19;
			}
			LA22_: ;
			colontmp__2 = ((*n)._kind_2.floatVal <= 1000000.0);
		} LA19: ;
		{
			NI T28_;
			if (!colontmp__2) goto LA26_;
			T28_ = (NI)0;
			T28_ = toInt__system_1689((*n)._kind_2.floatVal);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			result = emarkamp___pureZhashes_3(result, T28_);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		}
		LA26_: ;
	}
	break;
	case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 20) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 22):
	{
		NI T30_;
		T30_ = (NI)0;
		T30_ = hash__pureZhashes_279((*n)._kind_3.strVal);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		result = emarkamp___pureZhashes_3(result, T30_);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}
	break;
	default:
	{
		{
			NI i;
			NI colontmp__3;
			NI i_2;
			i = (NI)0;
			colontmp__3 = (NI)0;
			colontmp__3 = len__astZast95query_205(n);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			i_2 = ((NI) 0);
			{
				while (1) {
					NI T39_;
					{
						if (!!((i_2 < colontmp__3))) goto LA37_;
						goto LA34;
					}
					LA37_: ;
					i = i_2;
					T39_ = (NI)0;
					T39_ = hashTree__astZtreetab_5((*n)._kind_8.sons.p->data[i]);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					result = emarkamp___pureZhashes_3(result, T39_);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					i_2 += ((NI) 1);
				} LA34: ;
			}
		}
	}
	break;
	}
	result = emarkdollar___pureZhashes_18(result);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
static N_INLINE(int, nimCmpMem)(void* a, void* b, NI size) {
	int result;
	result = (int)0;
	result = memcmp(a, b, ((size_t) (size)));
	return result;
}
static N_INLINE(NIM_BOOL, equalMem__system_1716)(void* a, void* b, NI size) {
	NIM_BOOL result;
	int T1_;
	result = (NIM_BOOL)0;
	T1_ = (int)0;
	T1_ = nimCmpMem(a, b, size);
	result = (T1_ == ((NI32) 0));
	return result;
}
static N_INLINE(NIM_BOOL, eqStrings)(NimStringV2 a, NimStringV2 b) {
	NIM_BOOL result;
	NI alen;
	NI blen;
{	result = (NIM_BOOL)0;
	alen = a.len;
	blen = b.len;
	{
		if (!(alen == blen)) goto LA3_;
		{
			if (!(alen == ((NI) 0))) goto LA7_;
			result = NIM_TRUE;
			goto BeforeRet_;
		}
		LA7_: ;
		result = equalMem__system_1716(((void*) ((&a.p->data[((NI) 0)]))), ((void*) ((&b.p->data[((NI) 0)]))), ((NI) (alen)));
		goto BeforeRet_;
	}
	LA3_: ;
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, treesEquivalent__astZtreetab_37)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* a, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* b) {
	NIM_BOOL result;
	NIM_BOOL colontmp_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (NIM_BOOL)0;
	colontmp_ = (NIM_BOOL)0;
	{
		NIM_BOOL colontmp__2;
		{
			if (!(a == b)) goto LA4_;
			result = NIM_TRUE;
			goto LA1;
		}
		LA4_: ;
		colontmp__2 = (NIM_BOOL)0;
		{
			{
				colontmp_ = !((a == ((tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*) NIM_NIL)));
				{
					if (!!(colontmp_)) goto LA10_;
					goto LA7;
				}
				LA10_: ;
				colontmp_ = !((b == ((tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*) NIM_NIL)));
			} LA7: ;
			colontmp__2 = colontmp_;
			{
				if (!!(colontmp__2)) goto LA14_;
				goto LA6;
			}
			LA14_: ;
			colontmp__2 = ((*a).kind == (*b).kind);
		} LA6: ;
		{
			if (!colontmp__2) goto LA18_;
			switch ((*a).kind) {
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 1):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 23):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 4):
			{
				result = NIM_TRUE;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 3):
			{
				tyObject_TSym__RjHO5eqpy8QqcomFydmCag* xX60gensym6_;
				tyObject_TSym__RjHO5eqpy8QqcomFydmCag* xX60gensym7_;
				xX60gensym6_ = (tyObject_TSym__RjHO5eqpy8QqcomFydmCag*)0;
				xX60gensym7_ = (tyObject_TSym__RjHO5eqpy8QqcomFydmCag*)0;
				xX60gensym6_ = (*a)._kind_4.sym;
				xX60gensym7_ = (*b)._kind_4.sym;
				result = ((NI)((NI)((NU64)(((NI) ((*xX60gensym6_).Sup.itemId.module))) << (NU64)(((NI) 24))) + ((NI) ((*xX60gensym6_).Sup.itemId.item))) == (NI)((NI)((NU64)(((NI) ((*xX60gensym7_).Sup.itemId.module))) << (NU64)(((NI) 24))) + ((NI) ((*xX60gensym7_).Sup.itemId.item))));
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 2):
			{
				result = ((*(*a)._kind_5.ident).id == (*(*b)._kind_5.ident).id);
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 5) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 15):
			{
				result = ((*a)._kind_1.intVal == (*b)._kind_1.intVal);
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 16) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 18):
			{
				result = ((*a)._kind_2.floatVal == (*b)._kind_2.floatVal);
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 20) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 22):
			{
				result = eqStrings((*a)._kind_3.strVal, (*b)._kind_3.strVal);
			}
			break;
			default:
			{
				{
					NI T29_;
					NI T30_;
					T29_ = (NI)0;
					T29_ = len__astZast95query_205(a);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					T30_ = (NI)0;
					T30_ = len__astZast95query_205(b);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					if (!(T29_ == T30_)) goto LA31_;
					{
						NI i;
						NI colontmp__3;
						NI i_2;
						i = (NI)0;
						colontmp__3 = (NI)0;
						colontmp__3 = len__astZast95query_205(a);
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						i_2 = ((NI) 0);
						{
							while (1) {
								{
									if (!!((i_2 < colontmp__3))) goto LA38_;
									goto LA35;
								}
								LA38_: ;
								i = i_2;
								{
									NIM_BOOL T42_;
									T42_ = (NIM_BOOL)0;
									T42_ = treesEquivalent__astZtreetab_37((*a)._kind_8.sons.p->data[i], (*b)._kind_8.sons.p->data[i]);
									if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
									if (!!(T42_)) goto LA43_;
									goto BeforeRet_;
								}
								LA43_: ;
								i_2 += ((NI) 1);
							} LA35: ;
						}
					}
					result = NIM_TRUE;
				}
				LA31_: ;
			}
			break;
			}
			{
				tySet_tyEnum_TTypeCmpFlag__72pgRXSg7774cr9aCWVPORw T49_;
				if (!result) goto LA47_;
				T49_ = 0;
				result = sameTypeOrNil__astZtypes_1361((*a).typ, (*b).typ, T49_);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			}
			LA47_: ;
			goto LA1;
		}
		LA18_: ;
	} LA1: ;
	}BeforeRet_: ;
	return result;
}
static N_INLINE(NI, nextTry__astZastalgo_35)(NI h, NI maxHash) {
	NI result;
	result = (NI)0;
	result = (NI)((NI)((NI)(((NI) 5) * h) + ((NI) 1)) & maxHash);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NI, nodeTableRawGet__astZtreetab_85)(tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg t, NI k, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key) {
	NI result;
	NI h;
	NI T1_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (NI)0;
	T1_ = (t.data.len-1);
	h = (NI)(k & T1_);
	{
		while (1) {
			NIM_BOOL colontmp_;
			NI T17_;
			{
				if (!!(!((t.data.p->data[h].key == ((tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*) NIM_NIL))))) goto LA6_;
				goto LA3;
			}
			LA6_: ;
			colontmp_ = (NIM_BOOL)0;
			{
				colontmp_ = (t.data.p->data[h].h == k);
				{
					if (!!(colontmp_)) goto LA11_;
					goto LA8;
				}
				LA11_: ;
				colontmp_ = treesEquivalent__astZtreetab_37(t.data.p->data[h].key, key);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			} LA8: ;
			{
				if (!colontmp_) goto LA15_;
				result = h;
				goto BeforeRet_;
			}
			LA15_: ;
			T17_ = (t.data.len-1);
			h = nextTry__astZastalgo_35(h, T17_);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		} LA3: ;
	}
	result = ((NI) -1);
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(tySequence__lYfh7bqVzVYNloJtd3rj1Q, newSeq__astZtreetab_168)(NI len) {
	tySequence__lYfh7bqVzVYNloJtd3rj1Q result;
	result.len = 0; result.p = NIM_NIL;
	newSeq__astZast_1168((&result), len);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, nodeTableRawInsert__astZtreetab_126)(tySequence__lYfh7bqVzVYNloJtd3rj1Q* data, NI k, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key, NI val) {
	NI h;
	NI T1_;
	tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	T1_ = ((*data).len-1);
	h = (NI)(k & T1_);
	{
		while (1) {
			NI T8_;
			{
				if (!!(!(((*data).p->data[h].key == ((tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*) NIM_NIL))))) goto LA6_;
				goto LA3;
			}
			LA6_: ;
			T8_ = ((*data).len-1);
			h = nextTry__astZastalgo_35(h, T8_);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		} LA3: ;
	}
	(*data).p->data[h].h = k;
	colontmp_ = &(*data).p->data[h].key;
	eqcopy___astZreports95sem_222(colontmp_, key);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	(*data).p->data[h].val = val;
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(NI, nodeTableTestOrSet__astZtreetab_200)(tyObject_TNodeTable__9aAZGWj0Cb9bM5Ppop9bFzWNg* t, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* key, NI val) {
	NI result;
	NI k;
	NI index;
NIM_BOOL oldNimErrFin12_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (NI)0;
	k = hashTree__astZtreetab_5(key);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	index = nodeTableRawGet__astZtreetab_85((*t), k, key);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	{
		{
			if (!(((NI) 0) <= index)) goto LA4_;
			result = (*t).data.p->data[index].val;
			goto LA1;
		}
		LA4_: ;
		{
			NI T8_;
			NIM_BOOL T9_;
			tySequence__lYfh7bqVzVYNloJtd3rj1Q n;
			NI T13_;
			tySequence__lYfh7bqVzVYNloJtd3rj1Q* colontmp__2;
			tySequence__lYfh7bqVzVYNloJtd3rj1Q colontmp__3;
			T8_ = (*t).data.len;
			T9_ = (NIM_BOOL)0;
			T9_ = mustRehash__astZastalgo_32(T8_, (*t).counter);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			if (!T9_) goto LA10_;
			n.len = 0; n.p = NIM_NIL;
			T13_ = (*t).data.len;
			n = newSeq__astZtreetab_168(((NI) ((NI)(T13_ * ((NI) 2)))));
			if (NIM_UNLIKELY(*nimErr_)) goto LA12_;
			{
				NI i;
				NI colontmp_;
				NI T15_;
				NI res;
				i = (NI)0;
				colontmp_ = (NI)0;
				T15_ = ((*t).data.len-1);
				colontmp_ = T15_;
				res = ((NI) 0);
				{
					while (1) {
						{
							if (!!((res <= colontmp_))) goto LA20_;
							goto LA17;
						}
						LA20_: ;
						i = res;
						{
							if (!!(((*t).data.p->data[i].key == ((tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*) NIM_NIL)))) goto LA24_;
							nodeTableRawInsert__astZtreetab_126((&n), (*t).data.p->data[i].h, (*t).data.p->data[i].key, (*t).data.p->data[i].val);
							if (NIM_UNLIKELY(*nimErr_)) goto LA12_;
						}
						LA24_: ;
						res += ((NI) 1);
					} LA17: ;
				}
			}
			colontmp__2 = (&(*t).data);
			colontmp__3 = n;
			n.len = 0; n.p = NIM_NIL;
			eqsink___astZast_1291(colontmp__2, colontmp__3);
			if (NIM_UNLIKELY(*nimErr_)) goto LA12_;
			{
				LA12_:;
			}
			{
				oldNimErrFin12_ = *nimErr_; *nimErr_ = NIM_FALSE;
				eqdestroy___astZast_1285((&n));
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				*nimErr_ = oldNimErrFin12_;
			}
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		}
		LA10_: ;
		nodeTableRawInsert__astZtreetab_126((&(*t).data), k, key, val);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		result = val;
		(*t).counter += ((NI) 1);
	} LA1: ;
	}BeforeRet_: ;
	return result;
}
