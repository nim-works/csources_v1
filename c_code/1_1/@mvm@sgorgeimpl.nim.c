/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 32

#include "nimbase.h"
#include <string.h>
#include <stdio.h>
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
typedef struct tyTuple__XOVT24GHXwqiEj5GCsEGCA tyTuple__XOVT24GHXwqiEj5GCsEGCA;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
typedef struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q;
typedef struct tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw;
typedef struct tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg;
typedef struct RootObj RootObj;
typedef struct TNimTypeV2 TNimTypeV2;
typedef struct tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ;
typedef struct tyObject_StringTableObj__V5PVrt9bIxZEeV7lfvqqtNg tyObject_StringTableObj__V5PVrt9bIxZEeV7lfvqqtNg;
typedef struct tyObject_HSlice__EE5dzjqoOrHT6HJhIPXAvA tyObject_HSlice__EE5dzjqoOrHT6HJhIPXAvA;
typedef struct Exception Exception;
typedef struct tySequence__uB9b75OUPRENsBAu4AnoePA tySequence__uB9b75OUPRENsBAu4AnoePA;
typedef struct tySequence__uB9b75OUPRENsBAu4AnoePA_Content tySequence__uB9b75OUPRENsBAu4AnoePA_Content;
typedef struct tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA tyObject_StackTraceEntry__oLyohQ7O2XOvGnflOss8EA;
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
struct tyTuple__XOVT24GHXwqiEj5GCsEGCA {
NimStringV2 Field0;
NI Field1;
};
struct tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q {
NU16 line;
NI16 col;
NI32 fileIndex;
};
typedef NU8 tyArray__9bMdWY3rbF7YgboQDvW9b15Q[20];
typedef NU64 tySet_tyEnum_TGlobalOption__S69aWnO3aoRkUE69aD9aIT83w;
typedef NU8 tyEnum_TGlobalOption__S69aWnO3aoRkUE69aD9aIT83w;
typedef NU8 tyEnum_FileMode__ZJfK20XeZ9bv2j1pZjw9aswg;
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
typedef NU8 tySet_tyEnum_ProcessOption__bnU6W8LhTMnT4JaSWtGlSA;
struct tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg {
  RootObj Sup;
NI fProcessHandle;
NI fThreadHandle;
int inHandle;
int outHandle;
int errHandle;
NI id;
tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* inStream;
tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* outStream;
tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* errStream;
int exitStatus;
NIM_BOOL exitFlag;
tySet_tyEnum_ProcessOption__bnU6W8LhTMnT4JaSWtGlSA options;
};
typedef NimStringV2 tyArray__0QXWDV9ceouMwtx7v2WmkhA[1];
typedef N_NIMCALL_PTR(void, tyProc__JQrsH08b4uPTH9cyFPlVOZg) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
typedef N_NIMCALL_PTR(NIM_BOOL, tyProc__9bmhFrLahRsL2hltfRDVtlQ) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
typedef N_NIMCALL_PTR(void, tyProc__3svSoGIUJIsHkaBL7q4DAQ) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, NI pos);
typedef N_NIMCALL_PTR(NI, tyProc__xflqkf2D1uVClg70czEDHA) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
typedef N_NIMCALL_PTR(NI, tyProc__c9c0f59ak4YGQ6neEym8LPKw) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, NimStringV2* buffer, tyObject_HSlice__EE5dzjqoOrHT6HJhIPXAvA slice);
typedef N_NIMCALL_PTR(NIM_BOOL, tyProc__7jFfqMk9ajToCz6Hv9atCA4A) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, NimStringV2* line);
typedef N_NIMCALL_PTR(NI, tyProc__2VVzVL9bOnKhj1eZKkf9cEuA) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, void* buffer, NI bufLen);
typedef N_NIMCALL_PTR(void, tyProc__ki6p1QyfOkJLQJ9aw5NI0AQ) (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, void* buffer, NI bufLen);
struct tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ {
  RootObj Sup;
tyProc__JQrsH08b4uPTH9cyFPlVOZg closeImpl;
tyProc__9bmhFrLahRsL2hltfRDVtlQ atEndImpl;
tyProc__3svSoGIUJIsHkaBL7q4DAQ setPositionImpl;
tyProc__xflqkf2D1uVClg70czEDHA getPositionImpl;
tyProc__c9c0f59ak4YGQ6neEym8LPKw readDataStrImpl;
tyProc__7jFfqMk9ajToCz6Hv9atCA4A readLineImpl;
tyProc__2VVzVL9bOnKhj1eZKkf9cEuA readDataImpl;
tyProc__2VVzVL9bOnKhj1eZKkf9cEuA peekDataImpl;
tyProc__ki6p1QyfOkJLQJ9aw5NI0AQ writeDataImpl;
tyProc__JQrsH08b4uPTH9cyFPlVOZg flushImpl;
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
struct tyObject_HSlice__EE5dzjqoOrHT6HJhIPXAvA {
NI a;
NI b;
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

      static N_INLINE(void, nimZeroMem)(void* p, NI size);
static N_INLINE(void, nimSetMem__systemZmemory_7)(void* a, int v, NI size);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, nosparentDir)(NimStringV2 path);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, toFullPath__frontZmsgs_178)(tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw* conf, NI32 fileIdx);
N_LIB_PRIVATE N_NIMCALL(void, secureHash__stdZsha49_852)(NIM_CHAR* str, NI strLen_0, tyArray__9bMdWY3rbF7YgboQDvW9b15Q Result);
static N_INLINE(void, appendString)(NimStringV2* dest, NimStringV2 src);
static N_INLINE(void, copyMem__system_1708)(void* dest, void* source, NI size);
static N_INLINE(void, nimCopyMem)(void* dest, void* source, NI size);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, rawNewString)(NI space);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, toGeneratedFile__backendZextccomp_767)(tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw* conf, NimStringV2 path, NimStringV2 ext);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, dollar___stdZsha49_900)(tyArray__9bMdWY3rbF7YgboQDvW9b15Q self);
N_LIB_PRIVATE N_NIMCALL(tySet_tyEnum_TGlobalOption__S69aWnO3aoRkUE69aD9aIT83w, globalOptions__frontZoptions_3927)(tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw* confX60gensym63_);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, open__systemZio_562)(FILE** f, NimStringV2 filename, tyEnum_FileMode__ZJfK20XeZ9bv2j1pZjw9aswg mode, NI bufSize);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, readAll__systemZio_515)(FILE* file);
N_LIB_PRIVATE N_NIMCALL(void, close__systemZio_298)(FILE* f);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___system_3226)(NimStringV2* dest);
N_LIB_PRIVATE N_NIMCALL(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg*, nospstartProcess)(NimStringV2 command, NimStringV2 workingDir, NimStringV2* args, NI argsLen_0, tyObject_StringTableObj__V5PVrt9bIxZEeV7lfvqqtNg* env, tySet_tyEnum_ProcessOption__bnU6W8LhTMnT4JaSWtGlSA options);
N_LIB_PRIVATE N_NIMCALL(void, write__pureZstreams_179)(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s, NimStringV2 x);
N_LIB_PRIVATE N_NIMCALL(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*, nospinputStream)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p);
N_LIB_PRIVATE N_NIMCALL(void, close__pureZstreams_57)(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___pureZstreams_627)(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ** dest);
N_LIB_PRIVATE N_NIMCALL(tyTuple__XOVT24GHXwqiEj5GCsEGCA, readOutput__vmZgorgeimpl_9)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p);
N_LIB_PRIVATE N_NIMCALL(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*, nospoutputStream)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, atEnd__pureZstreams_63)(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, readLine__pureZstreams_553)(tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* s);
N_LIB_PRIVATE N_NIMCALL(void, prepareAdd)(NimStringV2* s, NI addlen);
N_LIB_PRIVATE N_NIMCALL(void, setLengthStrV2)(NimStringV2* s, NI newLen);
N_LIB_PRIVATE N_NIMCALL(NI, nospwaitForExit)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p, NI timeout);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE N_NIMCALL(void, nospclose)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p);
N_LIB_PRIVATE N_NIMCALL(void, writeFile__systemZio_651)(NimStringV2 filename, NimStringV2 content);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___pureZosproc_222)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg** dest);
static N_INLINE(NIM_BOOL, isObj)(TNimTypeV2* obj, NCSTRING subclass);
static N_INLINE(Exception*, nimBorrowCurrentException)(void);
N_LIB_PRIVATE N_NIMCALL(void, eqsink___pureZosproc_1423)(tyTuple__XOVT24GHXwqiEj5GCsEGCA* dest, tyTuple__XOVT24GHXwqiEj5GCsEGCA src);
static N_INLINE(void, popCurrentException)(void);
N_LIB_PRIVATE N_NIMCALL(void, eqcopy___system_3893)(Exception** dest, Exception* src, NIM_BOOL cyclic);
static const struct {
  NI cap; NIM_CHAR data[1+1];
} TM__69a9b06YSkBJW7wqzuZfJ29aQ_2 = { 1 | NIM_STRLIT_FLAG, "\011" };
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_3 = {1, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_2};
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_4 = {1, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_2};
static const struct {
  NI cap; NIM_CHAR data[6+1];
} TM__69a9b06YSkBJW7wqzuZfJ29aQ_5 = { 6 | NIM_STRLIT_FLAG, "gorge_" };
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_6 = {6, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_5};
static const struct {
  NI cap; NIM_CHAR data[3+1];
} TM__69a9b06YSkBJW7wqzuZfJ29aQ_7 = { 3 | NIM_STRLIT_FLAG, "txt" };
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_8 = {3, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_7};
static const struct {
  NI cap; NIM_CHAR data[0+1];
} TM__69a9b06YSkBJW7wqzuZfJ29aQ_9 = { 0 | NIM_STRLIT_FLAG, "" };
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_10 = {0, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_9};
static const struct {
  NI cap; NIM_CHAR data[1+1];
} TM__69a9b06YSkBJW7wqzuZfJ29aQ_11 = { 1 | NIM_STRLIT_FLAG, "\012" };
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_12 = {1, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_11};
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_13 = {0, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_9};
static const NimStringV2 TM__69a9b06YSkBJW7wqzuZfJ29aQ_14 = {0, (NimStrPayload*)&TM__69a9b06YSkBJW7wqzuZfJ29aQ_9};
extern NIM_BOOL nimInErrorMode__system_4174;
extern Exception* currException__system_3855;
extern Exception* currException__system_3855;
extern Exception* currException__system_3855;
static N_INLINE(void, nimSetMem__systemZmemory_7)(void* a, int v, NI size) {
	void* T1_;
	T1_ = (void*)0;
	T1_ = memset(a, v, ((size_t) (size)));
	(void)(T1_);
}
static N_INLINE(void, nimZeroMem)(void* p, NI size) {
	nimSetMem__systemZmemory_7(p, ((int) 0), size);
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
static N_INLINE(void, appendString)(NimStringV2* dest, NimStringV2 src) {
	{
		if (!(((NI) 0) < src.len)) goto LA3_;
		copyMem__system_1708(((void*) ((&(*(*dest).p).data[(*dest).len]))), ((void*) ((&(*src.p).data[((NI) 0)]))), ((NI) ((NI)(src.len + ((NI) 1)))));
		(*dest).len += src.len;
	}
	LA3_: ;
}
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(tyTuple__XOVT24GHXwqiEj5GCsEGCA, readOutput__vmZgorgeimpl_9)(tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p) {
	tyTuple__XOVT24GHXwqiEj5GCsEGCA result;
	tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* output;
	NI T13_;
NIM_BOOL oldNimErrFin1_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	nimZeroMem((void*)(&result), sizeof(tyTuple__XOVT24GHXwqiEj5GCsEGCA));
	output = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
	result.Field0 = TM__69a9b06YSkBJW7wqzuZfJ29aQ_10;
	output = nospoutputStream(p);
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	{
		while (1) {
			NimStringV2 colontmp_;
			{
				NIM_BOOL T6_;
				T6_ = (NIM_BOOL)0;
				T6_ = atEnd__pureZstreams_63(output);
				if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
				if (!!(!(T6_))) goto LA7_;
				goto LA3;
			}
			LA7_: ;
			colontmp_.len = 0; colontmp_.p = NIM_NIL;
			colontmp_ = readLine__pureZstreams_553(output);
			if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
			prepareAdd((&result.Field0), colontmp_.len + 0);
appendString((&result.Field0), colontmp_);
			prepareAdd((&result.Field0), 1);
appendString((&result.Field0), TM__69a9b06YSkBJW7wqzuZfJ29aQ_12);
			eqdestroy___system_3226((&colontmp_));
		} LA3: ;
	}
	{
		if (!(((NI) 0) < result.Field0.len)) goto LA11_;
		setLengthStrV2((&result.Field0), ((NI) ((NI)(result.Field0.len - ((NI) 1)))));
	}
	LA11_: ;
	T13_ = (NI)0;
	T13_ = nospwaitForExit(p, ((NI) -1));
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	result.Field1 = T13_;
	{
		LA1_:;
	}
	{
		oldNimErrFin1_ = *nimErr_; *nimErr_ = NIM_FALSE;
		eqdestroy___pureZstreams_627(&output);
		*nimErr_ = oldNimErrFin1_;
	}
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
static N_INLINE(NIM_BOOL, isObj)(TNimTypeV2* obj, NCSTRING subclass) {
	NIM_BOOL result;
	NCSTRING T1_;
	result = (NIM_BOOL)0;
	T1_ = (NCSTRING)0;
	T1_ = strstr((*obj).name, subclass);
	result = !((((void*) (T1_)) == NIM_NIL));
	return result;
}
static N_INLINE(Exception*, nimBorrowCurrentException)(void) {
	Exception* result;
	result = (Exception*)0;
	result = currException__system_3855;
	return result;
}
static N_INLINE(void, popCurrentException)(void) {
	Exception** colontmp_;
	colontmp_ = &(*currException__system_3855).up;
	eqcopy___system_3893(&currException__system_3855, (*colontmp_), NIM_FALSE);
}
N_LIB_PRIVATE N_NIMCALL(tyTuple__XOVT24GHXwqiEj5GCsEGCA, opGorge__vmZgorgeimpl_13)(NimStringV2 cmd, NimStringV2 input, NimStringV2 cache, tyObject_TLineInfo__WGx4rAexNXnczy1Avn646Q info, tyObject_ConfigRefcolonObjectType___LaK09ayL9alwKUad7rts0rTw* conf) {
	tyTuple__XOVT24GHXwqiEj5GCsEGCA result;
	NimStringV2 workingDir;
	NimStringV2 colontmp_;
	NimStringV2 colontmp__2;
NIM_BOOL oldNimErrFin28_;
NIM_BOOL oldNimErrFin21_;
NIM_BOOL oldNimErrFin7_;
NIM_BOOL oldNimErrFin57_;
NIM_BOOL oldNimErrFin50_;
NIM_BOOL oldNimErrFin1_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	nimZeroMem((void*)(&result), sizeof(tyTuple__XOVT24GHXwqiEj5GCsEGCA));
	workingDir.len = 0; workingDir.p = NIM_NIL;
	colontmp_.len = 0; colontmp_.p = NIM_NIL;
	colontmp__2 = toFullPath__frontZmsgs_178(conf, info.fileIndex);
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	colontmp_ = colontmp__2;
	workingDir = nosparentDir(colontmp_);
	if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	{
		tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p_2;
		tyArray__0QXWDV9ceouMwtx7v2WmkhA T51_;
		tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* T52_;
		tyTuple__XOVT24GHXwqiEj5GCsEGCA T62_;
		{
			NimStringV2 colontmp__3;
			NimStringV2 filename;
			NimStringV2 colontmp__4;
			NimStringV2 colontmp__5;
			tyArray__9bMdWY3rbF7YgboQDvW9b15Q h;
			NimStringV2 colontmp__6;
			NimStringV2 T8_;
			NimStringV2 colontmp__7;
			NimStringV2 T9_;
			NimStringV2 colontmp__8;
			FILE* f;
			NIM_BOOL colontmp__9;
			NIM_BOOL readSuccessful;
			tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* p;
			tyArray__0QXWDV9ceouMwtx7v2WmkhA T22_;
			tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg* T23_;
			tyTuple__XOVT24GHXwqiEj5GCsEGCA T33_;
			if (!(((NI) 0) < cache.len)) goto LA5_;
			colontmp__3.len = 0; colontmp__3.p = NIM_NIL;
			filename.len = 0; filename.p = NIM_NIL;
			colontmp__4.len = 0; colontmp__4.p = NIM_NIL;
			colontmp__5.len = 0; colontmp__5.p = NIM_NIL;
			nimZeroMem((void*)h, sizeof(tyArray__9bMdWY3rbF7YgboQDvW9b15Q));
			T8_.len = 0; T8_.p = NIM_NIL;
			T8_ = rawNewString(cmd.len + input.len + cache.len + 2);
appendString((&T8_), cmd);
appendString((&T8_), TM__69a9b06YSkBJW7wqzuZfJ29aQ_3);
appendString((&T8_), input);
appendString((&T8_), TM__69a9b06YSkBJW7wqzuZfJ29aQ_4);
appendString((&T8_), cache);
			colontmp__6 = T8_;
			colontmp__3 = colontmp__6;
			secureHash__stdZsha49_852(colontmp__3.p->data, colontmp__3.len, h);
			if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
			T9_.len = 0; T9_.p = NIM_NIL;
			colontmp__8 = dollar___stdZsha49_900(h);
			if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
			colontmp__4 = colontmp__8;
			T9_ = rawNewString(colontmp__4.len + 6);
appendString((&T9_), TM__69a9b06YSkBJW7wqzuZfJ29aQ_6);
appendString((&T9_), colontmp__4);
			colontmp__7 = T9_;
			colontmp__5 = colontmp__7;
			filename = toGeneratedFile__backendZextccomp_767(conf, colontmp__5, TM__69a9b06YSkBJW7wqzuZfJ29aQ_8);
			if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
			f = (FILE*)0;
			colontmp__9 = (NIM_BOOL)0;
			{
				tySet_tyEnum_TGlobalOption__S69aWnO3aoRkUE69aD9aIT83w T11_;
				T11_ = globalOptions__frontZoptions_3927(conf);
				if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
				colontmp__9 = !(((T11_ &((NU64)1<<((NU)(((tyEnum_TGlobalOption__S69aWnO3aoRkUE69aD9aIT83w) 1))&63U)))!=0));
				{
					if (!!(colontmp__9)) goto LA14_;
					goto LA10;
				}
				LA14_: ;
				colontmp__9 = open__systemZio_562(&f, filename, ((tyEnum_FileMode__ZJfK20XeZ9bv2j1pZjw9aswg) 0), ((NI) -1));
				if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
			} LA10: ;
			{
				NimStringV2 colontmp__10;
				NI colontmp__11;
				if (!colontmp__9) goto LA18_;
				colontmp__10.len = 0; colontmp__10.p = NIM_NIL;
				colontmp__10 = readAll__systemZio_515(f);
				if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
				colontmp__11 = ((NI) 0);
				result.Field0 = colontmp__10;
				result.Field1 = colontmp__11;
				close__systemZio_298(f);
				if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
				eqdestroy___system_3226((&colontmp__5));
				eqdestroy___system_3226((&colontmp__4));
				eqdestroy___system_3226((&filename));
				eqdestroy___system_3226((&colontmp__3));
				eqdestroy___system_3226((&colontmp_));
				eqdestroy___system_3226((&workingDir));
				goto BeforeRet_;
			}
			LA18_: ;
			readSuccessful = NIM_FALSE;
			p = (tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg*)0;
			T23_ = (tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg*)0;
			T23_ = nospstartProcess(cmd, workingDir, T22_, 0, ((tyObject_StringTableObj__V5PVrt9bIxZEeV7lfvqqtNg*) NIM_NIL), 12);
			if (NIM_UNLIKELY(*nimErr_)) goto LA21_;
			p = T23_;
			{
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__12;
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__13;
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__14;
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* T29_;
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__15;
				tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* T30_;
				if (!!((input.len == ((NI) 0)))) goto LA26_;
				colontmp__12 = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
				colontmp__13 = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
				T29_ = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
				T29_ = nospinputStream(p);
				if (NIM_UNLIKELY(*nimErr_)) goto LA28_;
				colontmp__14 = T29_;
				colontmp__12 = colontmp__14;
				write__pureZstreams_179(colontmp__12, input);
				if (NIM_UNLIKELY(*nimErr_)) goto LA28_;
				T30_ = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
				T30_ = nospinputStream(p);
				if (NIM_UNLIKELY(*nimErr_)) goto LA28_;
				colontmp__15 = T30_;
				colontmp__13 = colontmp__15;
				close__pureZstreams_57(colontmp__13);
				if (NIM_UNLIKELY(*nimErr_)) goto LA28_;
				{
					LA28_:;
				}
				{
					oldNimErrFin28_ = *nimErr_; *nimErr_ = NIM_FALSE;
					eqdestroy___pureZstreams_627(&colontmp__13);
					eqdestroy___pureZstreams_627(&colontmp__12);
					*nimErr_ = oldNimErrFin28_;
				}
				if (NIM_UNLIKELY(*nimErr_)) goto LA21_;
			}
			LA26_: ;
			nimZeroMem((void*)(&T33_), sizeof(tyTuple__XOVT24GHXwqiEj5GCsEGCA));
			T33_ = readOutput__vmZgorgeimpl_9(p);
			if (NIM_UNLIKELY(*nimErr_)) goto LA21_;
			result = T33_;
			nospclose(p);
			if (NIM_UNLIKELY(*nimErr_)) goto LA21_;
			readSuccessful = NIM_TRUE;
			{
				if (!(result.Field1 == ((NI) 0))) goto LA36_;
				writeFile__systemZio_651(filename, result.Field0);
				if (NIM_UNLIKELY(*nimErr_)) goto LA21_;
			}
			LA36_: ;
			{
				LA21_:;
			}
			{
				oldNimErrFin21_ = *nimErr_; *nimErr_ = NIM_FALSE;
				eqdestroy___pureZosproc_222(&p);
				*nimErr_ = oldNimErrFin21_;
			}
			if (NIM_UNLIKELY(*nimErr_)) goto LA20_;
			if (NIM_UNLIKELY(*nimErr_)) {
				LA20_:;
				if (isObj(nimBorrowCurrentException()->Sup.m_type, "|IOError|CatchableError|Exception|RootObj|")||isObj(nimBorrowCurrentException()->Sup.m_type, "|OSError|CatchableError|Exception|RootObj|")) {
					*nimErr_ = NIM_FALSE;
					{
						NimStringV2 colontmp__16;
						NI colontmp__17;
						tyTuple__XOVT24GHXwqiEj5GCsEGCA colontmp__18;
						if (!!(readSuccessful)) goto LA45_;
						colontmp__16.len = 0; colontmp__16.p = NIM_NIL;
						colontmp__16 = TM__69a9b06YSkBJW7wqzuZfJ29aQ_13;
						colontmp__17 = ((NI) -1);
						colontmp__18.Field0 = colontmp__16;
						colontmp__18.Field1 = colontmp__17;
						eqsink___pureZosproc_1423((&result), colontmp__18);
					}
					LA45_: ;
					popCurrentException();
					LA41_:;
				}
			}
			if (NIM_UNLIKELY(*nimErr_)) goto LA7_;
			eqdestroy___system_3226((&colontmp__5));
			eqdestroy___system_3226((&colontmp__4));
			eqdestroy___system_3226((&filename));
			eqdestroy___system_3226((&colontmp__3));
			goto LA2;
			{
				LA7_:;
			}
			{
				oldNimErrFin7_ = *nimErr_; *nimErr_ = NIM_FALSE;
				eqdestroy___system_3226((&colontmp__5));
				eqdestroy___system_3226((&colontmp__4));
				eqdestroy___system_3226((&filename));
				eqdestroy___system_3226((&colontmp__3));
				*nimErr_ = oldNimErrFin7_;
			}
			if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
		}
		LA5_: ;
		p_2 = (tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg*)0;
		T52_ = (tyObject_ProcessObj__2rGNQnv9bU4hanI2g3svReg*)0;
		T52_ = nospstartProcess(cmd, workingDir, T51_, 0, ((tyObject_StringTableObj__V5PVrt9bIxZEeV7lfvqqtNg*) NIM_NIL), 12);
		if (NIM_UNLIKELY(*nimErr_)) goto LA50_;
		p_2 = T52_;
		{
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__19;
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__20;
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__21;
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* T58_;
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* colontmp__22;
			tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ* T59_;
			if (!!((input.len == ((NI) 0)))) goto LA55_;
			colontmp__19 = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
			colontmp__20 = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
			T58_ = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
			T58_ = nospinputStream(p_2);
			if (NIM_UNLIKELY(*nimErr_)) goto LA57_;
			colontmp__21 = T58_;
			colontmp__19 = colontmp__21;
			write__pureZstreams_179(colontmp__19, input);
			if (NIM_UNLIKELY(*nimErr_)) goto LA57_;
			T59_ = (tyObject_StreamObj__THYguAi9bSgidczZ3ywEIMQ*)0;
			T59_ = nospinputStream(p_2);
			if (NIM_UNLIKELY(*nimErr_)) goto LA57_;
			colontmp__22 = T59_;
			colontmp__20 = colontmp__22;
			close__pureZstreams_57(colontmp__20);
			if (NIM_UNLIKELY(*nimErr_)) goto LA57_;
			{
				LA57_:;
			}
			{
				oldNimErrFin57_ = *nimErr_; *nimErr_ = NIM_FALSE;
				eqdestroy___pureZstreams_627(&colontmp__20);
				eqdestroy___pureZstreams_627(&colontmp__19);
				*nimErr_ = oldNimErrFin57_;
			}
			if (NIM_UNLIKELY(*nimErr_)) goto LA50_;
		}
		LA55_: ;
		nimZeroMem((void*)(&T62_), sizeof(tyTuple__XOVT24GHXwqiEj5GCsEGCA));
		T62_ = readOutput__vmZgorgeimpl_9(p_2);
		if (NIM_UNLIKELY(*nimErr_)) goto LA50_;
		result = T62_;
		nospclose(p_2);
		if (NIM_UNLIKELY(*nimErr_)) goto LA50_;
		{
			LA50_:;
		}
		{
			oldNimErrFin50_ = *nimErr_; *nimErr_ = NIM_FALSE;
			eqdestroy___pureZosproc_222(&p_2);
			*nimErr_ = oldNimErrFin50_;
		}
		if (NIM_UNLIKELY(*nimErr_)) goto LA49_;
		if (NIM_UNLIKELY(*nimErr_)) {
			LA49_:;
			if (isObj(nimBorrowCurrentException()->Sup.m_type, "|IOError|CatchableError|Exception|RootObj|")||isObj(nimBorrowCurrentException()->Sup.m_type, "|OSError|CatchableError|Exception|RootObj|")) {
				NimStringV2 colontmp__23;
				NI colontmp__24;
				tyTuple__XOVT24GHXwqiEj5GCsEGCA colontmp__25;
				*nimErr_ = NIM_FALSE;
				colontmp__23.len = 0; colontmp__23.p = NIM_NIL;
				colontmp__23 = TM__69a9b06YSkBJW7wqzuZfJ29aQ_14;
				colontmp__24 = ((NI) -1);
				colontmp__25.Field0 = colontmp__23;
				colontmp__25.Field1 = colontmp__24;
				eqsink___pureZosproc_1423((&result), colontmp__25);
				popCurrentException();
				LA66_:;
			}
		}
		if (NIM_UNLIKELY(*nimErr_)) goto LA1_;
	} LA2: ;
	{
		LA1_:;
	}
	{
		oldNimErrFin1_ = *nimErr_; *nimErr_ = NIM_FALSE;
		eqdestroy___system_3226((&colontmp_));
		eqdestroy___system_3226((&workingDir));
		*nimErr_ = oldNimErrFin1_;
	}
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
