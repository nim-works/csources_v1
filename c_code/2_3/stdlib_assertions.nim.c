/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 32
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
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ;
typedef struct tyObject_Defect__LbeSGvgPzGzXnW9caIkJqMA tyObject_Defect__LbeSGvgPzGzXnW9caIkJqMA;
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
typedef struct tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA;
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
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
struct tyObject_Defect__LbeSGvgPzGzXnW9caIkJqMA {
  Exception Sup;
};
struct tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ {
  tyObject_Defect__LbeSGvgPzGzXnW9caIkJqMA Sup;
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
struct tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA {
NCSTRING procname;
NI line;
NCSTRING filename;
};


#ifndef tySequence__uB9b75OUPRENsBAu4AnoePA_Content_PP
#define tySequence__uB9b75OUPRENsBAu4AnoePA_Content_PP
struct tySequence__uB9b75OUPRENsBAu4AnoePA_Content { NI cap; tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA data[SEQ_DECL_SIZE];};
#endif

      static N_INLINE(void, sysFatal__systemZassertions_24)(NimStringV2 message);
N_LIB_PRIVATE N_NIMCALL(void*, nimNewObj)(NI size, NI alignment);
static N_INLINE(NIM_BOOL, nimDecRefIsLastCyclicDyn)(void* p);
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y);
N_LIB_PRIVATE N_NOINLINE(void, rememberCycle__system_3163)(NIM_BOOL isDestroyAction, tyObject_RefHeader__Gi7WQzlT1ZRToh9a2ueYb4A* s, TNimTypeV2* desc);
N_LIB_PRIVATE N_NIMCALL(void, nimDestroyAndDispose)(void* p);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___system_3228)(NimStringV2* dest);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___system_3266)(tySequence__uB9b75OUPRENsBAu4AnoePA* dest);
static N_INLINE(void, nimTraceRefDyn)(void* q, void* env);
static N_INLINE(void, add__system_2722)(tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ* s, void** c, TNimTypeV2* t);
N_LIB_PRIVATE N_NOCONV(void*, allocImpl__system_1724)(NI size);
static N_INLINE(void, copyMem__system_1708)(void* dest, void* source, NI size);
static N_INLINE(void, nimCopyMem)(void* dest, void* source, NI size);
N_LIB_PRIVATE N_NOCONV(void, dealloc)(void* p);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE N_NIMCALL(void, raiseExceptionEx)(Exception* e, NCSTRING ename, NCSTRING procname, NCSTRING filename, NI line);
N_LIB_PRIVATE N_NIMCALL(void, eqcopy___system_3231)(NimStringV2* dest, NimStringV2 src);
N_LIB_PRIVATE N_NOINLINE(void, raiseAssert__systemZassertions_22)(NimStringV2 msg);
extern TNimTypeV2 NTIv2__PtYxPmY5X0dorfvxAFbJpQ_;
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(NI, minuspercent___system_704)(NI x, NI y) {
	NI result;
	result = (NI)0;
	result = ((NI) ((NU)((NU32)(((NU) (x))) - (NU32)(((NU) (y))))));
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
		T5_ = minuspercent___system_704(((NI) (ptrdiff_t) (p)), ((NI) 8));
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
		rememberCycle__system_3163(result, cell, (*((TNimTypeV2**) (p))));
	}
	LA3_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___systemZassertions_28)(tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ* dest) {
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = nimDecRefIsLastCyclicDyn((*dest).Sup.Sup.parent);
		if (!T3_) goto LA4_;
		nimDestroyAndDispose((*dest).Sup.Sup.parent);
	}
	LA4_: ;
	eqdestroy___system_3228((&(*dest).Sup.Sup.message));
	eqdestroy___system_3266((&(*dest).Sup.Sup.trace));
	{
		NIM_BOOL T8_;
		T8_ = (NIM_BOOL)0;
		T8_ = nimDecRefIsLastCyclicDyn((*dest).Sup.Sup.up);
		if (!T8_) goto LA9_;
		nimDestroyAndDispose((*dest).Sup.Sup.up);
	}
	LA9_: ;
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
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
static N_INLINE(void, add__system_2722)(tyObject_CellSeq__sGle0igznE2T7vk4dBh5SQ* s, void** c, TNimTypeV2* t) {
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
		T5_ = allocImpl__system_1724(((NI) ((NI)((*s).cap * ((NI) 8)))));
		if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
		d = ((tyTuple__N4J9cV4JZGem3ljqqj5rT0Q*) (T5_));
		copyMem__system_1708(((void*) (d)), ((void*) ((*s).d)), ((NI) ((NI)((*s).len * ((NI) 8)))));
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
		add__system_2722((&(*j).traceStack), p, (*((TNimTypeV2**) ((*p)))));
	}
	LA3_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, eqtrace___systemZassertions_37)(tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ* dest, void* env) {
	nimTraceRefDyn(&(*dest).Sup.Sup.parent, env);
	nimTraceRefDyn(&(*dest).Sup.Sup.up, env);
}
static N_INLINE(void, sysFatal__systemZassertions_24)(NimStringV2 message) {
	tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ* T1_;
{	T1_ = (tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ*)0;
	T1_ = (tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ*) nimNewObj(sizeof(tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ), NIM_ALIGNOF(tyObject_AssertionDefect__PtYxPmY5X0dorfvxAFbJpQ));
	(*T1_).Sup.Sup.Sup.m_type = (&NTIv2__PtYxPmY5X0dorfvxAFbJpQ_);
	(*T1_).Sup.Sup.message = message;
	raiseExceptionEx((Exception*)T1_, "AssertionDefect", "sysFatal", "fatal.nim", 48);
	goto BeforeRet_;
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NOINLINE(void, raiseAssert__systemZassertions_22)(NimStringV2 msg) {
	NimStringV2 colontmp_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	colontmp_.len = 0; colontmp_.p = NIM_NIL;
	colontmp_.len = 0; colontmp_.p = NIM_NIL;
	eqcopy___system_3231((&colontmp_), msg);
	sysFatal__systemZassertions_24(colontmp_);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, failedAssertImpl__systemZassertions_65)(NimStringV2 msg) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	raiseAssert__systemZassertions_22(msg);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
}
