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
typedef struct tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A;
typedef struct tySequence__9aKpvUh0ca6Bp9cKAwrowqUg tySequence__9aKpvUh0ca6Bp9cKAwrowqUg;
typedef struct tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content;
typedef struct tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA;
typedef struct tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg;
typedef struct NimStrPayload NimStrPayload;
typedef struct NimStringV2 NimStringV2;
struct tySequence__9aKpvUh0ca6Bp9cKAwrowqUg {
  NI len; tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content* p;
};
struct tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A {
tySequence__9aKpvUh0ca6Bp9cKAwrowqUg data;
};
struct tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA {
NI len;
tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg* p;
};
struct tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg {
NI cap;
NI16 data[SEQ_DECL_SIZE];
};
struct NimStrPayload {
NI cap;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct NimStringV2 {
NI len;
NimStrPayload* p;
};
typedef NI16 tyUncheckedArray__5WAtReG1juofV6itYKi25g[1];


#ifndef tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content_PP
#define tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content_PP
struct tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content { NI cap; NI16 data[SEQ_DECL_SIZE];};
#endif

      

#ifndef tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content_PP
#define tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content_PP
struct tySequence__9aKpvUh0ca6Bp9cKAwrowqUg_Content { NI cap; NI16 data[SEQ_DECL_SIZE];};
#endif

      static N_INLINE(void, nimZeroMem)(void* p, NI size);
static N_INLINE(void, nimSetMem__systemZmemory_7)(void* a, int v, NI size);
N_LIB_PRIVATE N_NIMCALL(void, createWide__systemZwidestrs_8)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A* a, NI len);
N_LIB_PRIVATE N_NIMCALL(void, newSeq__systemZwidestrs_11)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* s, NI len);
N_LIB_PRIVATE N_NIMCALL(void, shrink__systemZwidestrs_15)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* x, NI newLen);
N_LIB_PRIVATE N_NIMCALL(void, setLen__systemZwidestrs_19)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* s, NI newlen);
N_LIB_PRIVATE N_NIMCALL(void*, prepareSeqAdd)(NI len, void* p, NI addlen, NI elemSize, NI elemAlign);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, dollar___systemZwidestrs_399)(NI16* w, NI estimate, NI replacement);
N_LIB_PRIVATE N_NIMCALL(NimStringV2, rawNewString)(NI space);
N_NIMCALL(NimStringV2, rawNewString)(NI cap);
N_LIB_PRIVATE N_NIMCALL(NI, ord__systemZwidestrs_181)(NI16 arg);
static N_INLINE(void, nimAddCharV1)(NimStringV2* s, NIM_CHAR c);
N_LIB_PRIVATE N_NIMCALL(void, prepareAdd)(NimStringV2* s, NI addlen);
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___systemZwidestrs_119)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* dest);
N_LIB_PRIVATE N_NIMCALL(void, alignedDealloc)(void* p, NI align);
static N_INLINE(NI16*, toWideCString__systemZwidestrs_151)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A x);
N_LIB_PRIVATE N_NIMCALL(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A, newWideCString__systemZwidestrs_364)(NCSTRING source, NI L);
static N_INLINE(NCSTRING, nimToCStringConv)(NimStringV2 s);
static N_INLINE(NI, nimCStrLen)(NCSTRING a);
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(void, nimSetMem__systemZmemory_7)(void* a, int v, NI size) {
	void* T1_;
	T1_ = (void*)0;
	T1_ = memset(a, v, ((size_t) (size)));
	(void)(T1_);
}
static N_INLINE(void, nimZeroMem)(void* p, NI size) {
	nimSetMem__systemZmemory_7(p, ((int) 0), size);
}
N_LIB_PRIVATE N_NIMCALL(void, shrink__systemZwidestrs_15)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* x, NI newLen) {
	(*((tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA*) (x))).len = ((NI) (newLen));
}
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, setLen__systemZwidestrs_19)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* s, NI newlen) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	{
		NI oldLen;
		NI T7_;
		tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA* xu;
		NIM_BOOL colontmp_;
		{
			NI T4_;
			T4_ = (*s).len;
			if (!(((NI) (newlen)) < T4_)) goto LA5_;
			shrink__systemZwidestrs_15(s, newlen);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			goto LA1;
		}
		LA5_: ;
		T7_ = (*s).len;
		oldLen = T7_;
		{
			if (!(((NI) (newlen)) <= oldLen)) goto LA10_;
			goto BeforeRet_;
		}
		LA10_: ;
		xu = ((tyObject_NimSeqV2__AYKvrOZmMFQPUhVSysDLsA*) (s));
		colontmp_ = (NIM_BOOL)0;
		{
			colontmp_ = ((*xu).p == ((tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg*) NIM_NIL));
			{
				if (!colontmp_) goto LA15_;
				goto LA12;
			}
			LA15_: ;
			colontmp_ = ((*(*xu).p).cap < ((NI) (newlen)));
		} LA12: ;
		{
			void* T21_;
			if (!colontmp_) goto LA19_;
			T21_ = (void*)0;
			T21_ = prepareSeqAdd(oldLen, ((void*) ((*xu).p)), (NI)(((NI) (newlen)) - oldLen), ((NI) 2), ((NI) 2));
			(*xu).p = ((tyObject_NimSeqPayload__jjrD52VrssMO9bCu9cBn9cQFg*) (T21_));
		}
		LA19_: ;
		(*xu).len = ((NI) (newlen));
	} LA1: ;
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, newSeq__systemZwidestrs_11)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* s, NI len) {
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	shrink__systemZwidestrs_15(s, ((NI) 0));
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	setLen__systemZwidestrs_19(s, len);
	}BeforeRet_: ;
}
N_LIB_PRIVATE N_NIMCALL(void, createWide__systemZwidestrs_8)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A* a, NI len) {
	newSeq__systemZwidestrs_11((&(*a).data), ((NI) (len)));
}
N_LIB_PRIVATE N_NIMCALL(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A, newWideCString__systemZwidestrs_364)(NCSTRING source, NI L) {
	tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A result;
	NI d;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	nimZeroMem((void*)(&result), sizeof(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A));
	createWide__systemZwidestrs_8((&result), (NI)(L + ((NI) 1)));
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	d = ((NI) 0);
	{
		NI ch;
		NI i;
		NI result_2;
		ch = (NI)0;
		i = ((NI) 0);
		result_2 = (NI)0;
		{
			while (1) {
				{
					if (!!((i < L))) goto LA6_;
					goto LA3;
				}
				LA6_: ;
				{
					{
						if (!(((NU8)(source[i])) <= ((NI) 127))) goto LA11_;
						result_2 = ((NU8)(source[i]));
						i += ((NI) 1);
						goto LA8;
					}
					LA11_: ;
					{
						if (!((NI)((NI64)(((NU8)(source[i]))) >> (NU64)(((NI) 5))) == ((NI) 6))) goto LA15_;
						{
							{
								if (!(i <= (NI)(L - ((NI) 2)))) goto LA20_;
								result_2 = (NI)((NI)((NU64)((NI)(((NU8)(source[i])) & ((NI) 31))) << (NU64)(((NI) 6))) | (NI)(((NU8)(source[(NI)(i + ((NI) 1))])) & ((NI) 63)));
								i += ((NI) 2);
								goto LA17;
							}
							LA20_: ;
							result_2 = ((NI) 65533);
							i += ((NI) 1);
						} LA17: ;
						goto LA8;
					}
					LA15_: ;
					{
						if (!((NI)((NI64)(((NU8)(source[i]))) >> (NU64)(((NI) 4))) == ((NI) 14))) goto LA24_;
						{
							{
								if (!(i <= (NI)(L - ((NI) 3)))) goto LA29_;
								result_2 = (NI)((NI)((NI)((NU64)((NI)(((NU8)(source[i])) & ((NI) 15))) << (NU64)(((NI) 12))) | (NI)((NU64)((NI)(((NU8)(source[(NI)(i + ((NI) 1))])) & ((NI) 63))) << (NU64)(((NI) 6)))) | (NI)(((NU8)(source[(NI)(i + ((NI) 2))])) & ((NI) 63)));
								i += ((NI) 3);
								goto LA26;
							}
							LA29_: ;
							result_2 = ((NI) 65533);
							i += ((NI) 1);
						} LA26: ;
						goto LA8;
					}
					LA24_: ;
					{
						if (!((NI)((NI64)(((NU8)(source[i]))) >> (NU64)(((NI) 3))) == ((NI) 30))) goto LA33_;
						{
							{
								if (!(i <= (NI)(L - ((NI) 4)))) goto LA38_;
								result_2 = (NI)((NI)((NI)((NI)((NU64)((NI)(((NU8)(source[i])) & ((NI) 7))) << (NU64)(((NI) 18))) | (NI)((NU64)((NI)(((NU8)(source[(NI)(i + ((NI) 1))])) & ((NI) 63))) << (NU64)(((NI) 12)))) | (NI)((NU64)((NI)(((NU8)(source[(NI)(i + ((NI) 2))])) & ((NI) 63))) << (NU64)(((NI) 6)))) | (NI)(((NU8)(source[(NI)(i + ((NI) 3))])) & ((NI) 63)));
								i += ((NI) 4);
								goto LA35;
							}
							LA38_: ;
							result_2 = ((NI) 65533);
							i += ((NI) 1);
						} LA35: ;
						goto LA8;
					}
					LA33_: ;
					result_2 = ((NI) 65533);
					i += ((NI) 1);
				} LA8: ;
				ch = result_2;
				{
					NI ch_2;
					{
						if (!(ch <= ((NI) 65535))) goto LA43_;
						{
							NIM_BOOL colontmp_;
							colontmp_ = (NIM_BOOL)0;
							{
								colontmp_ = (((NI) 55296) <= ch);
								{
									if (!!(colontmp_)) goto LA49_;
									goto LA46;
								}
								LA49_: ;
								colontmp_ = (ch <= ((NI) 57343));
							} LA46: ;
							{
								if (!colontmp_) goto LA53_;
								result.data.p->data[d] = ((NI16) -3);
								goto LA45;
							}
							LA53_: ;
							result.data.p->data[d] = ((NI16) (((NU16) (ch))));
						} LA45: ;
						goto LA40;
					}
					LA43_: ;
					{
						if (!(((NI) 1114111) < ch)) goto LA57_;
						result.data.p->data[d] = ((NI16) -3);
						goto LA40;
					}
					LA57_: ;
					ch_2 = (NI)(ch - ((NI) 65536));
					result.data.p->data[d] = ((NI16) (((NU16) ((NI)((NI)((NI64)(ch_2) >> (NU64)(((NI) 10))) + ((NI) 55296))))));
					d += ((NI) 1);
					result.data.p->data[d] = ((NI16) (((NU16) ((NI)((NI)(ch_2 & ((NI) 1023)) + ((NI) 56320))))));
				} LA40: ;
				d += ((NI) 1);
			} LA3: ;
		}
	}
	result.data.p->data[d] = ((NI16) 0);
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NI, ord__systemZwidestrs_181)(NI16 arg) {
	NI result;
	result = (NI)0;
	result = ((NI) (((NU16) (arg))));
	return result;
}
static N_INLINE(void, nimAddCharV1)(NimStringV2* s, NIM_CHAR c) {
	prepareAdd(s, ((NI) 1));
	(*(*s).p).data[(*s).len] = c;
	(*(*s).p).data[(NI)((*s).len + ((NI) 1))] = 0;
	(*s).len += ((NI) 1);
}
N_LIB_PRIVATE N_NIMCALL(NimStringV2, dollar___systemZwidestrs_399)(NI16* w, NI estimate, NI replacement) {
	NimStringV2 result;
	NI i;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result.len = 0; result.p = NIM_NIL;
	result = rawNewString(((NI) ((NI)(estimate + (NI)((NI64)(estimate) >> (NU64)(((NI) 2)))))));
	i = ((NI) 0);
	{
		while (1) {
			NI ch;
			{
				if (!!(!((w[i] == ((NI16) 0))))) goto LA5_;
				goto LA2;
			}
			LA5_: ;
			ch = ord__systemZwidestrs_181(w[i]);
			if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
			i += ((NI) 1);
			{
				NIM_BOOL colontmp_;
				NIM_BOOL colontmp__3;
				colontmp_ = (NIM_BOOL)0;
				{
					colontmp_ = (((NI) 55296) <= ch);
					{
						if (!!(colontmp_)) goto LA11_;
						goto LA8;
					}
					LA11_: ;
					colontmp_ = (ch <= ((NI) 56319));
				} LA8: ;
				{
					NI ch2;
					if (!colontmp_) goto LA15_;
					ch2 = ord__systemZwidestrs_181(w[i]);
					if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
					{
						NIM_BOOL colontmp__2;
						colontmp__2 = (NIM_BOOL)0;
						{
							colontmp__2 = (((NI) 56320) <= ch2);
							{
								if (!!(colontmp__2)) goto LA21_;
								goto LA18;
							}
							LA21_: ;
							colontmp__2 = (ch2 <= ((NI) 57343));
						} LA18: ;
						{
							if (!colontmp__2) goto LA25_;
							ch = (NI)((NI)((NI)((NU64)((NI)(ch & ((NI) 1023))) << (NU64)(((NI) 10))) + (NI)(ch2 & ((NI) 1023))) + ((NI) 65536));
							i += ((NI) 1);
							goto LA17;
						}
						LA25_: ;
						ch = replacement;
					} LA17: ;
					goto LA7;
				}
				LA15_: ;
				colontmp__3 = (NIM_BOOL)0;
				{
					colontmp__3 = (((NI) 56320) <= ch);
					{
						if (!!(colontmp__3)) goto LA30_;
						goto LA27;
					}
					LA30_: ;
					colontmp__3 = (ch <= ((NI) 57343));
				} LA27: ;
				{
					if (!colontmp__3) goto LA34_;
					ch = replacement;
					goto LA7;
				}
				LA34_: ;
			} LA7: ;
			{
				{
					if (!(ch < ((NI) 128))) goto LA39_;
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) (ch)))));
					goto LA36;
				}
				LA39_: ;
				{
					if (!(ch < ((NI) 2048))) goto LA43_;
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 6))) | ((NI) 192)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)(ch & ((NI) 63)) | ((NI) 128)))))));
					goto LA36;
				}
				LA43_: ;
				{
					if (!(ch < ((NI) 65536))) goto LA47_;
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 12))) | ((NI) 224)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 6))) & ((NI) 63)) | ((NI) 128)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)(ch & ((NI) 63)) | ((NI) 128)))))));
					goto LA36;
				}
				LA47_: ;
				{
					if (!(ch <= ((NI) 1114111))) goto LA51_;
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 18))) | ((NI) 240)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 12))) & ((NI) 63)) | ((NI) 128)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)((NI)((NI64)(ch) >> (NU64)(((NI) 6))) & ((NI) 63)) | ((NI) 128)))))));
					nimAddCharV1((&result), ((NIM_CHAR) (((NI) ((NI)((NI)(ch & ((NI) 63)) | ((NI) 128)))))));
					goto LA36;
				}
				LA51_: ;
				nimAddCharV1((&result), 239);
				nimAddCharV1((&result), 191);
				nimAddCharV1((&result), 189);
			} LA36: ;
		} LA2: ;
	}
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NimStringV2, dollar___systemZwidestrs_463)(NI16* s) {
	NimStringV2 result;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result.len = 0; result.p = NIM_NIL;
	result = dollar___systemZwidestrs_399(s, ((NI) 80), ((NI) 65533));
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___systemZwidestrs_119)(tySequence__9aKpvUh0ca6Bp9cKAwrowqUg* dest) {
	if ((*dest).p && !((*dest).p->cap & NIM_STRLIT_FLAG)) {
 alignedDealloc((*dest).p, NIM_ALIGNOF(NI16));
}
}
N_LIB_PRIVATE N_NIMCALL(void, eqsink___systemZwidestrs_389)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A* dest, tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A src) {
	if ((*dest).data.p != src.data.p) {	eqdestroy___systemZwidestrs_119((&(*dest).data));
	}
(*dest).data.len = src.data.len; (*dest).data.p = src.data.p;
}
static N_INLINE(NI16*, toWideCString__systemZwidestrs_151)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A x) {
	NI16* result;
	result = (NI16*)0;
	{
		{
			NI T4_;
			T4_ = x.data.len;
			if (!(((NI) 0) < T4_)) goto LA5_;
			result = ((NI16*) ((&x.data.p->data[((NI) 0)])));
			goto LA1;
		}
		LA5_: ;
		result = ((NI16*) NIM_NIL);
	} LA1: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NimStringV2, dollar___systemZwidestrs_466)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A s, NI estimate, NI replacement) {
	NimStringV2 result;
	NI16* T1_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result.len = 0; result.p = NIM_NIL;
	T1_ = (NI16*)0;
	T1_ = toWideCString__systemZwidestrs_151(s);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	result = dollar___systemZwidestrs_399(T1_, estimate, replacement);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(void, eqdestroy___systemZwidestrs_386)(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A* dest) {
	eqdestroy___systemZwidestrs_119((&(*dest).data));
}
static N_INLINE(NCSTRING, nimToCStringConv)(NimStringV2 s) {
	NCSTRING result;
	result = (NCSTRING)0;
	{
		{
			if (!(s.len == ((NI) 0))) goto LA4_;
			result = "";
			goto LA1;
		}
		LA4_: ;
		result = ((NCSTRING) ((*s.p).data));
	} LA1: ;
	return result;
}
N_LIB_PRIVATE N_NIMCALL(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A, newWideCString__systemZwidestrs_396)(NimStringV2 s) {
	tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A result;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	nimZeroMem((void*)(&result), sizeof(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A));
	result = newWideCString__systemZwidestrs_364(nimToCStringConv(s), s.len);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
static N_INLINE(NI, nimCStrLen)(NCSTRING a) {
	NI result;
	size_t T1_;
	result = (NI)0;
	T1_ = (size_t)0;
	T1_ = strlen(a);
	result = ((NI) (T1_));
	return result;
}
N_LIB_PRIVATE N_NIMCALL(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A, newWideCString__systemZwidestrs_383)(NCSTRING s) {
	tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A result;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	nimZeroMem((void*)(&result), sizeof(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A));
	{
		if (!(s == 0)) goto LA3_;
		nimZeroMem((void*)(&result), sizeof(tyObject_WideCStringObj__BwbUsAz4qeNPsD7q6SJ32A));
		goto BeforeRet_;
	}
	LA3_: ;
	result = newWideCString__systemZwidestrs_364(s, (s ? nimCStrLen(s) : 0));
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	}BeforeRet_: ;
	return result;
}
