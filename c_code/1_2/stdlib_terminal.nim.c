/* Generated by Nim Compiler v0.1.0-dev.20827 */
#define NIM_INTBITS 64

#include "nimbase.h"
#include <io.h>
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
typedef struct tyObject_PTerminalcolonObjectType___EcU8GhMNGo9bGDXbfqZ82og tyObject_PTerminalcolonObjectType___EcU8GhMNGo9bGDXbfqZ82og;
N_LIB_PRIVATE N_NIMCALL(int, getFileHandle__systemZio_309)(FILE* f);
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void);
N_LIB_PRIVATE tyObject_PTerminalcolonObjectType___EcU8GhMNGo9bGDXbfqZ82og* gTerm__pureZterminal_15;
N_LIB_PRIVATE NI16 defaultForegroundColor__pureZterminal_600 = ((NI16) -1);
N_LIB_PRIVATE NI16 defaultBackgroundColor__pureZterminal_601 = ((NI16) -1);
extern NIM_BOOL nimInErrorMode__system_4174;
static N_INLINE(NIM_BOOL*, nimErrorFlag)(void) {
	NIM_BOOL* result;
	result = (NIM_BOOL*)0;
	result = (&nimInErrorMode__system_4174);
	return result;
}
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, isatty__pureZterminal_757)(FILE* f) {
	NIM_BOOL result;
	int T1_;
	int T2_;
NIM_BOOL* nimErr_;
{nimErr_ = nimErrorFlag();
	result = (NIM_BOOL)0;
	T1_ = (int)0;
	T1_ = getFileHandle__systemZio_309(f);
	if (NIM_UNLIKELY(*nimErr_)) goto BeforeRet_;
	T2_ = (int)0;
	T2_ = _isatty(T1_);
	result = !((T2_ == ((NI32) 0)));
	}BeforeRet_: ;
	return result;
}
