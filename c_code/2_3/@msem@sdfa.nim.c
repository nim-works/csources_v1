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
typedef struct tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw tySequence__XrT6wRHqo12fVwXeGBWNEw;
typedef struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content tySequence__XrT6wRHqo12fVwXeGBWNEw_Content;
typedef struct tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ tyObject_TType__9bxl8e9cDuDwfQRcyh9cQYOlQ;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_TSym__RjHO5eqpy8QqcomFydmCag tyObject_TSym__RjHO5eqpy8QqcomFydmCag;
typedef struct tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA tyObject_TIdent__1LTsGP7bSxg45u9aHcxh6OA;
typedef struct tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA tyObject_TAstDiag__EVmQyBtA5JqVUf0Ul4PFiA;
typedef NU8 tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg;
struct tySequence__XrT6wRHqo12fVwXeGBWNEw {
  NI len; tySequence__XrT6wRHqo12fVwXeGBWNEw_Content* p;
};
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


#ifndef tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
#define tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content { NI cap; tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
#define tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content { NI cap; tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
#define tySequence__XrT6wRHqo12fVwXeGBWNEw_Content_PP
struct tySequence__XrT6wRHqo12fVwXeGBWNEw_Content { NI cap; tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* data[SEQ_DECL_SIZE];};
#endif

      N_LIB_PRIVATE N_NIMCALL(void, eqcopy___astZreports95sem_222)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** dest, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* src);
N_LIB_PRIVATE N_NIMCALL(void, add__astZast_169)(tySequence__XrT6wRHqo12fVwXeGBWNEw* x, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* value);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports95sem_219)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** dest);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___astZreports95sem_1514)(tySequence__XrT6wRHqo12fVwXeGBWNEw* dest);
static N_INLINE(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw**, X5BX5D___astZast95query_835)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** s, NI sLen_0, NI i);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw**, X5BX5D___astZast95query_835)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** s, NI sLen_0, NI i) {
	tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** result;
	result = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw**)0;
	result = &s[(NI)(sLen_0 - i)];
	return result;
}
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg, aliases__semZdfa_1246)(tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* obj, tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* field) {
	tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg result;
	tySequence__XrT6wRHqo12fVwXeGBWNEw objImportantNodes;
	tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* obj_2;
	tySequence__XrT6wRHqo12fVwXeGBWNEw fieldImportantNodes;
	tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* field_2;
NIM_BOOL oldNimErrFin30_;
NIM_BOOL oldNimErrFin1_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg)0;
	objImportantNodes.len = 0; objImportantNodes.p = NIM_NIL;
	obj_2 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
	fieldImportantNodes.len = 0; fieldImportantNodes.p = NIM_NIL;
	field_2 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
	eqcopy___astZreports95sem_222(&obj_2, obj);
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	{
		while (1) {
			switch ((*obj_2).kind) {
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 45) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 46):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 62) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 66):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp_;
				colontmp_ = &(*obj_2)._kind_8.sons.p->data[((NI) 0)];
				eqcopy___astZreports95sem_222(&obj_2, (*colontmp_));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 57) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 58):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__2;
				colontmp__2 = &(*obj_2)._kind_8.sons.p->data[((NI) 1)];
				eqcopy___astZreports95sem_222(&obj_2, (*colontmp__2));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 44):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 41):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* colontmp__3;
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__4;
				colontmp__3 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				colontmp__3 = 0;
				eqcopy___astZreports95sem_222(&colontmp__3, obj_2);
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
				add__astZast_169((&objImportantNodes), colontmp__3);
				colontmp__4 = &(*obj_2)._kind_8.sons.p->data[((NI) 0)];
				eqcopy___astZreports95sem_222(&obj_2, (*colontmp__4));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 3):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* colontmp__5;
				colontmp__5 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				colontmp__5 = obj_2;
				obj_2 = 0;
				add__astZast_169((&objImportantNodes), colontmp__5);
				goto LA2;
			}
			break;
			default:
			{
				result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
				eqdestroy___astZreports95sem_219(&field_2);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_219(&obj_2);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_1514((&objImportantNodes));
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				goto BeforeRet_;
			}
			break;
			}
		}
	} LA2: ;
	eqcopy___astZreports95sem_222(&field_2, field);
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	{
		while (1) {
			switch ((*field_2).kind) {
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 45) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 46):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 62) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 66):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__6;
				colontmp__6 = &(*field_2)._kind_8.sons.p->data[((NI) 0)];
				eqcopy___astZreports95sem_222(&field_2, (*colontmp__6));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 57) ... ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 58):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__7;
				colontmp__7 = &(*field_2)._kind_8.sons.p->data[((NI) 1)];
				eqcopy___astZreports95sem_222(&field_2, (*colontmp__7));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 44):
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 41):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* colontmp__8;
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__9;
				colontmp__8 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				colontmp__8 = 0;
				eqcopy___astZreports95sem_222(&colontmp__8, field_2);
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
				add__astZast_169((&fieldImportantNodes), colontmp__8);
				colontmp__9 = &(*field_2)._kind_8.sons.p->data[((NI) 0)];
				eqcopy___astZreports95sem_222(&field_2, (*colontmp__9));
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			}
			break;
			case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 3):
			{
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* colontmp__10;
				colontmp__10 = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				colontmp__10 = field_2;
				field_2 = 0;
				add__astZast_169((&fieldImportantNodes), colontmp__10);
				goto LA9;
			}
			break;
			default:
			{
				result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
				eqdestroy___astZreports95sem_219(&field_2);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_219(&obj_2);
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				eqdestroy___astZreports95sem_1514((&objImportantNodes));
				if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
				goto BeforeRet_;
			}
			break;
			}
		}
	} LA9: ;
	{
		NI T18_;
		NI T19_;
		T18_ = fieldImportantNodes.len;
		T19_ = objImportantNodes.len;
		if (!(T18_ < T19_)) goto LA20_;
		result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
		eqdestroy___astZreports95sem_219(&field_2);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_219(&obj_2);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_1514((&objImportantNodes));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		goto BeforeRet_;
	}
	LA20_: ;
	result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 0);
	{
		NI i;
		NI colontmp__11;
		NI T23_;
		NI res;
		i = (NI)0;
		colontmp__11 = (NI)0;
		T23_ = objImportantNodes.len;
		colontmp__11 = T23_;
		res = ((NI) 1);
		{
			while (1) {
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* currFieldPath;
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw* currObjPath;
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__12;
				tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw** colontmp__13;
				{
					if (!!((res <= colontmp__11))) goto LA28_;
					goto LA25;
				}
				LA28_: ;
				currFieldPath = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				currObjPath = (tyObject_TNode__Bujcm1vZNtQEsOsw5ZIYIw*)0;
				i = res;
				colontmp__12 = X5BX5D___astZast95query_835(fieldImportantNodes.p->data, fieldImportantNodes.len, i);
				if (NIM_UNLIKELY(*nimErr_)) goto LA30_;
				eqcopy___astZreports95sem_222(&currFieldPath, (*colontmp__12));
				if (NIM_UNLIKELY(*nimErr_)) goto LA30_;
				colontmp__13 = X5BX5D___astZast95query_835(objImportantNodes.p->data, objImportantNodes.len, i);
				if (NIM_UNLIKELY(*nimErr_)) goto LA30_;
				eqcopy___astZreports95sem_222(&currObjPath, (*colontmp__13));
				if (NIM_UNLIKELY(*nimErr_)) goto LA30_;
				{
					if (!!(((*currFieldPath).kind == (*currObjPath).kind))) goto LA33_;
					result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
					eqdestroy___astZreports95sem_219(&currObjPath);
					if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
					eqdestroy___astZreports95sem_219(&currFieldPath);
					if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
					eqdestroy___astZreports95sem_219(&field_2);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					eqdestroy___astZreports95sem_219(&obj_2);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					eqdestroy___astZreports95sem_1514((&objImportantNodes));
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					goto BeforeRet_;
				}
				LA33_: ;
				switch ((*currFieldPath).kind) {
				case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 3):
				{
					{
						if (!!(((*currFieldPath)._kind_4.sym == (*currObjPath)._kind_4.sym))) goto LA38_;
						result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
						eqdestroy___astZreports95sem_219(&currObjPath);
						if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
						eqdestroy___astZreports95sem_219(&currFieldPath);
						if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
						eqdestroy___astZreports95sem_219(&field_2);
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_219(&obj_2);
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_1514((&objImportantNodes));
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						goto BeforeRet_;
					}
					LA38_: ;
				}
				break;
				case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 44):
				{
					{
						if (!!(((*(*currFieldPath)._kind_8.sons.p->data[((NI) 1)])._kind_4.sym == (*(*currObjPath)._kind_8.sons.p->data[((NI) 1)])._kind_4.sym))) goto LA43_;
						result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
						eqdestroy___astZreports95sem_219(&currObjPath);
						if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
						eqdestroy___astZreports95sem_219(&currFieldPath);
						if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
						eqdestroy___astZreports95sem_219(&field_2);
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_219(&obj_2);
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						eqdestroy___astZreports95sem_1514((&objImportantNodes));
						if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
						goto BeforeRet_;
					}
					LA43_: ;
				}
				break;
				case ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 41):
				{
					{
						NIM_BOOL colontmp__14;
						colontmp__14 = (NIM_BOOL)0;
						{
							colontmp__14 = ((*(*currFieldPath)._kind_8.sons.p->data[((NI) 1)]).kind >= ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 5) && (*(*currFieldPath)._kind_8.sons.p->data[((NI) 1)]).kind <= ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 22));
							{
								if (!!(colontmp__14)) goto LA50_;
								goto LA47;
							}
							LA50_: ;
							colontmp__14 = ((*(*currObjPath)._kind_8.sons.p->data[((NI) 1)]).kind >= ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 5) && (*(*currObjPath)._kind_8.sons.p->data[((NI) 1)]).kind <= ((tyEnum_TNodeKind__J4tQd214cfE1JQGaIm9aMZg) 22));
						} LA47: ;
						{
							if (!colontmp__14) goto LA54_;
							{
								if (!!(((*(*currFieldPath)._kind_8.sons.p->data[((NI) 1)])._kind_1.intVal == (*(*currObjPath)._kind_8.sons.p->data[((NI) 1)])._kind_1.intVal))) goto LA58_;
								result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 1);
								eqdestroy___astZreports95sem_219(&currObjPath);
								if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
								eqdestroy___astZreports95sem_219(&currFieldPath);
								if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
								eqdestroy___astZreports95sem_219(&field_2);
								if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
								eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
								if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
								eqdestroy___astZreports95sem_219(&obj_2);
								if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
								eqdestroy___astZreports95sem_1514((&objImportantNodes));
								if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
								goto BeforeRet_;
							}
							LA58_: ;
							goto LA46;
						}
						LA54_: ;
						result = ((tyEnum_AliasKind__mOZtJx9b3QXuy9bfWq9cuUNCg) 2);
					} LA46: ;
				}
				break;
				default:
				{
				}
				break;
				}
				res += ((NI) 1);
				{
					LA30_:;
				}
				{
					oldNimErrFin30_ = *nimErr_; *nimErr_ = NIM_FALSE;
					eqdestroy___astZreports95sem_219(&currObjPath);
					if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
					eqdestroy___astZreports95sem_219(&currFieldPath);
					if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
					*nimErr_ = oldNimErrFin30_;
				}
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			} LA25: ;
		}
	}
	{
		LA1_:;
	}
	{
		oldNimErrFin1_ = *nimErr_; *nimErr_ = NIM_FALSE;
		eqdestroy___astZreports95sem_219(&field_2);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_1514((&fieldImportantNodes));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_219(&obj_2);
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		eqdestroy___astZreports95sem_1514((&objImportantNodes));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		*nimErr_ = oldNimErrFin1_;
	}
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
