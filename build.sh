#!/bin/sh
# Generated from niminst
# Template is in tools/niminst/buildsh.nimf
# To regenerate run ``niminst csource`` or ``koch csource``

set -e

while :
do
  case "$1" in
    --os)
      optos=$2
      shift 2
      ;;
    --cpu)
      optcpu=$2
      shift 2
      ;;
    --osname)
      optosname=$2
      shift 2
      ;;
    --parallel)
      parallel=$2
      shift 2
      ;;
    --extraBuildArgs)
      extraBuildArgs=" $2"
      shift 2
      ;;
    -h | --help)
      echo "Options:"
      echo "  --os <OS>"
      echo "  --cpu <CPU architecture>"
      echo "  --osname <name>           Additional OS specification (used for Android)"
      echo "  --extraBuildArgs <args>   Additional arguments passed to the compiler"
      echo "  --parallel <number>       Multiprocess build. Requires GNU parallel"
      exit 0
      ;;
    --) # End of all options
      shift
      break;
      ;;
    -*)
      echo 2>&1 "Error: Unknown option: $1" >&2
      exit 1
      ;;
    *)  # No more options
      break
      ;;
  esac
done

parallel="${parallel:-0}"
CC="${CC:-gcc}"
if [ "$parallel" -gt 1 ]; then
  if ! command -v sem > /dev/null; then
    echo "Error: GNU parallel is required to use --parallel"
    exit 1
  fi
  CC="sem -j $parallel --id $$ ${CC}"
fi
COMP_FLAGS="${CPPFLAGS:-} ${CFLAGS:-} -w -fmax-errors=3 -O3 -fno-strict-aliasing -fno-ident $extraBuildArgs"
LINK_FLAGS="${LDFLAGS:-} "
PS4=""
# platform detection
ucpu=`uname -m`
uos=`uname`
uosname=
# bin dir detection
binDir=bin

if [ ! -d $binDir ]; then
  mkdir $binDir
fi

# override OS, CPU and OS Name with command-line arguments
if [ -n "$optos" ]; then
  uos="$optos"
fi
if [ -n "$optcpu" ]; then
  ucpu="$optcpu"
fi
if [ -n "$optcpu" ]; then
  uosname="$optosname"
fi

# convert to lower case:
ucpu=`echo $ucpu | tr "[:upper:]" "[:lower:]"`
uos=`echo $uos | tr "[:upper:]" "[:lower:]"`
uosname=`echo $uosname | tr "[:upper:]" "[:lower:]"`

case $uos in
  *linux* )
    myos="linux"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm -lrt"
    ;;
  *dragonfly* )
    myos="dragonfly"
    LINK_FLAGS="$LINK_FLAGS -lm"
    ;;
  *freebsd* )
    myos="freebsd"
    CC="clang"
    LINK_FLAGS="$LINK_FLAGS -lm"
    ;;
  *crossos* )
    myos="crossos"
    CC="clang"
    LINK_FLAGS="$LINK_FLAGS -lm"
    ;;
  *openbsd* )
    myos="openbsd"
    CC="clang"
    LINK_FLAGS="$LINK_FLAGS -lm"
    ;;
  *netbsd* )
    myos="netbsd"
    LINK_FLAGS="$LINK_FLAGS -lm"
    ;;
  *darwin* )
    myos="macosx"
    CC="clang"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm"
    if [ "$HOSTTYPE" = "x86_64" ] ; then
      ucpu="amd64"
    fi
    ;;
  *aix* )
    myos="aix"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm"
    ;;
  *solaris* | *sun* )
    myos="solaris"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm -lsocket -lnsl"
    ;;
  *SunOS* )
    myos="solaris"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm -lsocket -lnsl"
    isOpenIndiana="yes"
    ;;
  *haiku* )
    myos="haiku"
    LINK_FLAGS="$LINK_FLAGS -lroot -lnetwork"
    ;;
  *mingw* | *msys* )
    myos="windows"
    ;;
  *android* )
    myos="android"
    LINK_FLAGS="$LINK_FLAGS -ldl -lm -lrt"
    LINK_FLAGS="$LINK_FLAGS -landroid-glob"
    ;;
  *)
    echo 2>&1 "Error: unknown operating system: $uos"
    exit 1
    ;;
esac

case $ucpu in
  *i386* | *i486* | *i586* | *i686* | *bepc* | *i86pc* )
    if [ isOpenIndiana -eq "yes" ] ; then
      mycpu="amd64"
    else
      mycpu="i386"
    fi
    ;;
  *amd*64* | *x86-64* | *x86_64* )
    mycpu="amd64" ;;
  *sparc*|*sun* )
    mycpu="sparc"
    if [ "$myos" = "linux" ] ; then
      if [ "$(getconf LONG_BIT)" = "64" ]; then
        mycpu="sparc64"
      elif [ "$(isainfo -b)" = "64" ]; then
        mycpu="sparc64"
      fi
    fi
    ;;
  *ppc64le* )
    mycpu="powerpc64el" ;;
  *ppc64* )
    if [ "$myos" = "linux" ] ; then
      COMP_FLAGS="$COMP_FLAGS -m64"
      LINK_FLAGS="$LINK_FLAGS -m64"
    fi
    mycpu="powerpc64" ;;
  *power*|*ppc* )
    if [ "$myos" = "freebsd" ] ; then
      if [ "$ucpu" != "powerpc" ] ; then
        COMP_FLAGS="$COMP_FLAGS -m64"
        LINK_FLAGS="$LINK_FLAGS -m64"
      fi
      mycpu=`uname -p`
      case $mycpu in
        powerpc64le)
        mycpu="powerpc64el"
      esac
    else
      mycpu="powerpc"
    fi
    ;;
  *hppa*)
    mycpu="hppa" ;;
  *ia64*)
    mycpu="ia64" ;;
  *m68k*)
    mycpu="m68k" ;;
  *mips* )
    mycpu="$("$CC" -dumpmachine | sed 's/-.*//')"
    case $mycpu in
      mips|mipsel|mips64|mips64el)
        ;;
      *)
        echo 2>&1 "Error: unknown MIPS target: $mycpu"
        exit 1
    esac
    ;;
  *alpha* )
    mycpu="alpha" ;;
  *aarch64*|*arm64* )
    mycpu="arm64" ;;
  *arm*|*armv6l*|*armv7l*|*armv8l* )
    mycpu="arm" ;;
  *riscv64|riscv* )
    mycpu="riscv64" ;;
  *e2k* )
    mycpu="e2k" ;;
  *loongarch64* )
    mycpu="loongarch64" ;;
  *)
    echo 2>&1 "Error: unknown processor: $ucpu"
    exit 1
    ;;
esac

case $uosname in
  *android* )
    LINK_FLAGS="$LINK_FLAGS -landroid-glob"
    myosname="android"
    myos="android"
    ;;
esac

# call the compiler:
echo \# OS:  $myos
echo \# CPU: $mycpu

case $myos in
windows)
  case $mycpu in
  i386)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_digitsutils.nim.c -o c_code/1_1/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_assertions.nim.c -o c_code/1_1/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_dragonbox.nim.c -o c_code/1_1/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_schubfach.nim.c -o c_code/1_1/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_formatfloat.nim.c -o c_code/1_1/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_dollars.nim.c -o c_code/1_1/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_widestrs.nim.c -o c_code/1_1/stdlib_widestrs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_io.nim.c -o c_code/1_1/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_system.nim.c -o c_code/1_1/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_parseutils.nim.c -o c_code/1_1/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_math.nim.c -o c_code/1_1/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_enumutils.nim.c -o c_code/1_1/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_unicode.nim.c -o c_code/1_1/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_strutils.nim.c -o c_code/1_1/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_pathnorm.nim.c -o c_code/1_1/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_dynlib.nim.c -o c_code/1_1/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_winlean.nim.c -o c_code/1_1/stdlib_winlean.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_options.nim.c -o c_code/1_1/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_times.nim.c -o c_code/1_1/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_win_setenv.nim.c -o c_code/1_1/stdlib_win_setenv.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_os.nim.c -o c_code/1_1/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_hashes.nim.c -o c_code/1_1/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@spathutils.nim.c -o c_code/1_1/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sropes.nim.c -o c_code/1_1/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sidioms.nim.c -o c_code/1_1/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreport_enums.nim.c -o c_code/1_1/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@slineinfos.nim.c -o c_code/1_1/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@swordrecg.nim.c -o c_code/1_1/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sidents.nim.c -o c_code/1_1/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@splatform.nim.c -o c_code/1_1/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_strtabs.nim.c -o c_code/1_1/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@sin_options.nim.c -o c_code/1_1/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sint128.nim.c -o c_code/1_1/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast_types.nim.c -o c_code/1_1/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_lexer.nim.c -o c_code/1_1/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_parser.nim.c -o c_code/1_1/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_base_sem.nim.c -o c_code/1_1/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@snilcheck_enums.nim.c -o c_code/1_1/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_sem.nim.c -o c_code/1_1/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_vm.nim.c -o c_code/1_1/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svm_enums.nim.c -o c_code/1_1/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_debug.nim.c -o c_code/1_1/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_backend.nim.c -o c_code/1_1/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_internal.nim.c -o c_code/1_1/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_external.nim.c -o c_code/1_1/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_cmd.nim.c -o c_code/1_1/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports.nim.c -o c_code/1_1/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sprefixmatches.nim.c -o c_code/1_1/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@snimpaths.nim.c -o c_code/1_1/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sstrutils2.nim.c -o c_code/1_1/@mutils@sstrutils2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_strformat.nim.c -o c_code/1_1/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_terminal.nim.c -o c_code/1_1/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_globs.nim.c -o c_code/1_1/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@soptions.nim.c -o c_code/1_1/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sllstream.nim.c -o c_code/1_1/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@snimlexbase.nim.c -o c_code/1_1/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@slexer.nim.c -o c_code/1_1/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast_parsed_types.nim.c -o c_code/1_1/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@smsgs.nim.c -o c_code/1_1/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_sequtils.nim.c -o c_code/1_1/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_sha1.nim.c -o c_code/1_1/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_streams.nim.c -o c_code/1_1/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_lexbase.nim.c -o c_code/1_1/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_parsejson.nim.c -o c_code/1_1/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_json.nim.c -o c_code/1_1/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast_idgen.nim.c -o c_code/1_1/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast_query.nim.c -o c_code/1_1/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast.nim.c -o c_code/1_1/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_colortext.nim.c -o c_code/1_1/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sastrepr.nim.c -o c_code/1_1/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sparser.nim.c -o c_code/1_1/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@srenderer.nim.c -o c_code/1_1/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sfilters.nim.c -o c_code/1_1/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sfilter_tmpl.nim.c -o c_code/1_1/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@ssyntaxes.nim.c -o c_code/1_1/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@scondsyms.nim.c -o c_code/1_1/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_intsets.nim.c -o c_code/1_1/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_md5.nim.c -o c_code/1_1/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sastalgo.nim.c -o c_code/1_1/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@srodfiles.nim.c -o c_code/1_1/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@spacked_ast.nim.c -o c_code/1_1/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@sic.nim.c -o c_code/1_1/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@smodulegraphs.nim.c -o c_code/1_1/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_parseopt.nim.c -o c_code/1_1/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@snimblecmd.nim.c -o c_code/1_1/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_win_getsysteminfo.nim.c -o c_code/1_1/stdlib_win_getsysteminfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_cpuinfo.nim.c -o c_code/1_1/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_osproc.nim.c -o c_code/1_1/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_jsonutils.nim.c -o c_code/1_1/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@sextccomp.nim.c -o c_code/1_1/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@soptionsprocessor.nim.c -o c_code/1_1/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@snimconf.nim.c -o c_code/1_1/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@scommands.nim.c -o c_code/1_1/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sastmsgs.nim.c -o c_code/1_1/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@strees.nim.c -o c_code/1_1/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@serrorhandling.nim.c -o c_code/1_1/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@stypes.nim.c -o c_code/1_1/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@stypesrenderer.nim.c -o c_code/1_1/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@scli_reporter.nim.c -o c_code/1_1/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_sexp.nim.c -o c_code/1_1/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_diff.nim.c -o c_code/1_1/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_sexp_diff.nim.c -o c_code/1_1/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@ssexp_reporter.nim.c -o c_code/1_1/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@scmdlinehelper.nim.c -o c_code/1_1/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@sdepfiles.nim.c -o c_code/1_1/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@spasses.nim.c -o c_code/1_1/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@scollectors.nim.c -o c_code/1_1/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@schecked_ast.nim.c -o c_code/1_1/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sbitsets.nim.c -o c_code/1_1/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@snimsets.nim.c -o c_code/1_1/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@serrorreporting.nim.c -o c_code/1_1/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@smagicsys.nim.c -o c_code/1_1/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@senumtostr.nim.c -o c_code/1_1/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@slinter.nim.c -o c_code/1_1/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@smodulepaths.nim.c -o c_code/1_1/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmdef.nim.c -o c_code/1_1/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssemdata.nim.c -o c_code/1_1/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_editdistance.nim.c -o c_code/1_1/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@slookups.nim.c -o c_code/1_1/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@simporter.nim.c -o c_code/1_1/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssemfold.nim.c -o c_code/1_1/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@stypeallowed.nim.c -o c_code/1_1/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sisolation_check.nim.c -o c_code/1_1/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sprocfind.nim.c -o c_code/1_1/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@spragmas.nim.c -o c_code/1_1/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssemtypinst.nim.c -o c_code/1_1/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@slowerings.nim.c -o c_code/1_1/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sparampatterns.nim.c -o c_code/1_1/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssigmatch.nim.c -o c_code/1_1/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssighashes.nim.c -o c_code/1_1/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sndi.nim.c -o c_code/1_1/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@scgendata.nim.c -o c_code/1_1/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@sccgutils.nim.c -o c_code/1_1/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sliftdestructors.nim.c -o c_code/1_1/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@slambdalifting.nim.c -o c_code/1_1/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sclosureiters.nim.c -o c_code/1_1/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@svarpartitions.nim.c -o c_code/1_1/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@ssaturate.nim.c -o c_code/1_1/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sguards.nim.c -o c_code/1_1/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@streetab.nim.c -o c_code/1_1/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@snilcheck.nim.c -o c_code/1_1/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssempass2.nim.c -o c_code/1_1/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@scgmeth.nim.c -o c_code/1_1/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@stransf.nim.c -o c_code/1_1/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@saliases.nim.c -o c_code/1_1/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@spatterns.nim.c -o c_code/1_1/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sevaltempl.nim.c -o c_code/1_1/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@spluginsupport.nim.c -o c_code/1_1/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mplugins@slocals.nim.c -o c_code/1_1/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mplugins@sitersgen.nim.c -o c_code/1_1/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mplugins@sactive.nim.c -o c_code/1_1/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmtypegen.nim.c -o c_code/1_1/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmaux.nim.c -o c_code/1_1/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmtypes.nim.c -o c_code/1_1/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmmemory.nim.c -o c_code/1_1/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmobjects.nim.c -o c_code/1_1/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmcompilerserdes.nim.c -o c_code/1_1/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@smirtrees.nim.c -o c_code/1_1/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@sastgen.nim.c -o c_code/1_1/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@smirgen.nim.c -o c_code/1_1/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@sutils.nim.c -o c_code/1_1/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@saliasanalysis.nim.c -o c_code/1_1/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@smirexec.nim.c -o c_code/1_1/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@sanalysis.nim.c -o c_code/1_1/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@smirchangesets.nim.c -o c_code/1_1/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sinjectdestructors.nim.c -o c_code/1_1/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@smirbridge.nim.c -o c_code/1_1/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmgen.nim.c -o c_code/1_1/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmjit.nim.c -o c_code/1_1/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmlegacy.nim.c -o c_code/1_1/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@sgorgeimpl.nim.c -o c_code/1_1/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmerrors.nim.c -o c_code/1_1/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmdeps.nim.c -o c_code/1_1/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmhooks.nim.c -o c_code/1_1/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmops.nim.c -o c_code/1_1/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@smacrocacheimpl.nim.c -o c_code/1_1/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmprofiler.nim.c -o c_code/1_1/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmchecks.nim.c -o c_code/1_1/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svm.nim.c -o c_code/1_1/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@scompilerbridge.nim.c -o c_code/1_1/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mtools@ssuggest.nim.c -o c_code/1_1/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssem.nim.c -o c_code/1_1/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@spassaux.nim.c -o c_code/1_1/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@sdepends.nim.c -o c_code/1_1/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@sreplayer.nim.c -o c_code/1_1/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmodules@smodules.nim.c -o c_code/1_1/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sdfa.nim.c -o c_code/1_1/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@scgen.nim.c -o c_code/1_1/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@spacked_env.nim.c -o c_code/1_1/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmbackend.nim.c -o c_code/1_1/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@sdce.nim.c -o c_code/1_1/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@scbackend.nim.c -o c_code/1_1/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@sintegrity.nim.c -o c_code/1_1/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@scbackend.nim.c -o c_code/1_1/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@sscripting.nim.c -o c_code/1_1/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@sjsgen.nim.c -o c_code/1_1/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@ssourcemap.nim.c -o c_code/1_1/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mbackend@sjsbackend.nim.c -o c_code/1_1/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_xmltree.nim.c -o c_code/1_1/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@srenderverbatim.nim.c -o c_code/1_1/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_rstast.nim.c -o c_code/1_1/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_highlite.nim.c -o c_code/1_1/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_rst.nim.c -o c_code/1_1/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_rstgen.nim.c -o c_code/1_1/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_base64.nim.c -o c_code/1_1/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_uri.nim.c -o c_code/1_1/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mtools@sdocgen.nim.c -o c_code/1_1/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mtools@sdocgen2.nim.c -o c_code/1_1/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@smain.nim.c -o c_code/1_1/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_browsers.nim.c -o c_code/1_1/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mnim.nim.c -o c_code/1_1/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/1_1/stdlib_digitsutils.nim.o \
c_code/1_1/stdlib_assertions.nim.o \
c_code/1_1/stdlib_dragonbox.nim.o \
c_code/1_1/stdlib_schubfach.nim.o \
c_code/1_1/stdlib_formatfloat.nim.o \
c_code/1_1/stdlib_dollars.nim.o \
c_code/1_1/stdlib_widestrs.nim.o \
c_code/1_1/stdlib_io.nim.o \
c_code/1_1/stdlib_system.nim.o \
c_code/1_1/stdlib_parseutils.nim.o \
c_code/1_1/stdlib_math.nim.o \
c_code/1_1/stdlib_enumutils.nim.o \
c_code/1_1/stdlib_unicode.nim.o \
c_code/1_1/stdlib_strutils.nim.o \
c_code/1_1/stdlib_pathnorm.nim.o \
c_code/1_1/stdlib_dynlib.nim.o \
c_code/1_1/stdlib_winlean.nim.o \
c_code/1_1/stdlib_options.nim.o \
c_code/1_1/stdlib_times.nim.o \
c_code/1_1/stdlib_win_setenv.nim.o \
c_code/1_1/stdlib_os.nim.o \
c_code/1_1/stdlib_hashes.nim.o \
c_code/1_1/@mutils@spathutils.nim.o \
c_code/1_1/@mutils@sropes.nim.o \
c_code/1_1/@mutils@sidioms.nim.o \
c_code/1_1/@mast@sreport_enums.nim.o \
c_code/1_1/@mast@slineinfos.nim.o \
c_code/1_1/@mast@swordrecg.nim.o \
c_code/1_1/@mast@sidents.nim.o \
c_code/1_1/@mutils@splatform.nim.o \
c_code/1_1/stdlib_strtabs.nim.o \
c_code/1_1/@mfront@sin_options.nim.o \
c_code/1_1/@mutils@sint128.nim.o \
c_code/1_1/@mast@sast_types.nim.o \
c_code/1_1/@mast@sreports_lexer.nim.o \
c_code/1_1/@mast@sreports_parser.nim.o \
c_code/1_1/@mast@sreports_base_sem.nim.o \
c_code/1_1/@msem@snilcheck_enums.nim.o \
c_code/1_1/@mast@sreports_sem.nim.o \
c_code/1_1/@mast@sreports_vm.nim.o \
c_code/1_1/@mvm@svm_enums.nim.o \
c_code/1_1/@mast@sreports_debug.nim.o \
c_code/1_1/@mast@sreports_backend.nim.o \
c_code/1_1/@mast@sreports_internal.nim.o \
c_code/1_1/@mast@sreports_external.nim.o \
c_code/1_1/@mast@sreports_cmd.nim.o \
c_code/1_1/@mast@sreports.nim.o \
c_code/1_1/@mutils@sprefixmatches.nim.o \
c_code/1_1/@mmodules@snimpaths.nim.o \
c_code/1_1/@mutils@sstrutils2.nim.o \
c_code/1_1/stdlib_strformat.nim.o \
c_code/1_1/stdlib_terminal.nim.o \
c_code/1_1/stdlib_globs.nim.o \
c_code/1_1/@mfront@soptions.nim.o \
c_code/1_1/@mast@sllstream.nim.o \
c_code/1_1/@mast@snimlexbase.nim.o \
c_code/1_1/@mast@slexer.nim.o \
c_code/1_1/@mast@sast_parsed_types.nim.o \
c_code/1_1/@mfront@smsgs.nim.o \
c_code/1_1/stdlib_sequtils.nim.o \
c_code/1_1/stdlib_sha1.nim.o \
c_code/1_1/stdlib_streams.nim.o \
c_code/1_1/stdlib_lexbase.nim.o \
c_code/1_1/stdlib_parsejson.nim.o \
c_code/1_1/stdlib_json.nim.o \
c_code/1_1/@mast@sast_idgen.nim.o \
c_code/1_1/@mast@sast_query.nim.o \
c_code/1_1/@mast@sast.nim.o \
c_code/1_1/stdlib_colortext.nim.o \
c_code/1_1/@mutils@sastrepr.nim.o \
c_code/1_1/@mast@sparser.nim.o \
c_code/1_1/@mast@srenderer.nim.o \
c_code/1_1/@mast@sfilters.nim.o \
c_code/1_1/@mast@sfilter_tmpl.nim.o \
c_code/1_1/@mast@ssyntaxes.nim.o \
c_code/1_1/@mfront@scondsyms.nim.o \
c_code/1_1/stdlib_intsets.nim.o \
c_code/1_1/stdlib_md5.nim.o \
c_code/1_1/@mast@sastalgo.nim.o \
c_code/1_1/@mic@srodfiles.nim.o \
c_code/1_1/@mic@spacked_ast.nim.o \
c_code/1_1/@mic@sic.nim.o \
c_code/1_1/@mmodules@smodulegraphs.nim.o \
c_code/1_1/stdlib_parseopt.nim.o \
c_code/1_1/@mmodules@snimblecmd.nim.o \
c_code/1_1/stdlib_win_getsysteminfo.nim.o \
c_code/1_1/stdlib_cpuinfo.nim.o \
c_code/1_1/stdlib_osproc.nim.o \
c_code/1_1/stdlib_jsonutils.nim.o \
c_code/1_1/@mbackend@sextccomp.nim.o \
c_code/1_1/@mfront@soptionsprocessor.nim.o \
c_code/1_1/@mfront@snimconf.nim.o \
c_code/1_1/@mfront@scommands.nim.o \
c_code/1_1/@mast@sastmsgs.nim.o \
c_code/1_1/@mast@strees.nim.o \
c_code/1_1/@mast@serrorhandling.nim.o \
c_code/1_1/@mast@stypes.nim.o \
c_code/1_1/@mast@stypesrenderer.nim.o \
c_code/1_1/@mfront@scli_reporter.nim.o \
c_code/1_1/stdlib_sexp.nim.o \
c_code/1_1/stdlib_diff.nim.o \
c_code/1_1/stdlib_sexp_diff.nim.o \
c_code/1_1/@mfront@ssexp_reporter.nim.o \
c_code/1_1/@mfront@scmdlinehelper.nim.o \
c_code/1_1/@mfront@sdepfiles.nim.o \
c_code/1_1/@msem@spasses.nim.o \
c_code/1_1/@msem@scollectors.nim.o \
c_code/1_1/@mast@schecked_ast.nim.o \
c_code/1_1/@mutils@sbitsets.nim.o \
c_code/1_1/@mast@snimsets.nim.o \
c_code/1_1/@mast@serrorreporting.nim.o \
c_code/1_1/@mmodules@smagicsys.nim.o \
c_code/1_1/@mast@senumtostr.nim.o \
c_code/1_1/@mast@slinter.nim.o \
c_code/1_1/@mmodules@smodulepaths.nim.o \
c_code/1_1/@mvm@svmdef.nim.o \
c_code/1_1/@msem@ssemdata.nim.o \
c_code/1_1/stdlib_editdistance.nim.o \
c_code/1_1/@msem@slookups.nim.o \
c_code/1_1/@mmodules@simporter.nim.o \
c_code/1_1/@msem@ssemfold.nim.o \
c_code/1_1/@msem@stypeallowed.nim.o \
c_code/1_1/@msem@sisolation_check.nim.o \
c_code/1_1/@msem@sprocfind.nim.o \
c_code/1_1/@msem@spragmas.nim.o \
c_code/1_1/@msem@ssemtypinst.nim.o \
c_code/1_1/@msem@slowerings.nim.o \
c_code/1_1/@msem@sparampatterns.nim.o \
c_code/1_1/@msem@ssigmatch.nim.o \
c_code/1_1/@msem@ssighashes.nim.o \
c_code/1_1/@mast@sndi.nim.o \
c_code/1_1/@mbackend@scgendata.nim.o \
c_code/1_1/@mbackend@sccgutils.nim.o \
c_code/1_1/@msem@sliftdestructors.nim.o \
c_code/1_1/@msem@slambdalifting.nim.o \
c_code/1_1/@msem@sclosureiters.nim.o \
c_code/1_1/@msem@svarpartitions.nim.o \
c_code/1_1/@mutils@ssaturate.nim.o \
c_code/1_1/@msem@sguards.nim.o \
c_code/1_1/@mast@streetab.nim.o \
c_code/1_1/@msem@snilcheck.nim.o \
c_code/1_1/@msem@ssempass2.nim.o \
c_code/1_1/@mbackend@scgmeth.nim.o \
c_code/1_1/@msem@stransf.nim.o \
c_code/1_1/@msem@saliases.nim.o \
c_code/1_1/@msem@spatterns.nim.o \
c_code/1_1/@msem@sevaltempl.nim.o \
c_code/1_1/@mutils@spluginsupport.nim.o \
c_code/1_1/@mplugins@slocals.nim.o \
c_code/1_1/@mplugins@sitersgen.nim.o \
c_code/1_1/@mplugins@sactive.nim.o \
c_code/1_1/@mvm@svmtypegen.nim.o \
c_code/1_1/@mvm@svmaux.nim.o \
c_code/1_1/@mvm@svmtypes.nim.o \
c_code/1_1/@mvm@svmmemory.nim.o \
c_code/1_1/@mvm@svmobjects.nim.o \
c_code/1_1/@mvm@svmcompilerserdes.nim.o \
c_code/1_1/@mmir@smirtrees.nim.o \
c_code/1_1/@mmir@sastgen.nim.o \
c_code/1_1/@mmir@smirgen.nim.o \
c_code/1_1/@mmir@sutils.nim.o \
c_code/1_1/@msem@saliasanalysis.nim.o \
c_code/1_1/@msem@smirexec.nim.o \
c_code/1_1/@mmir@sanalysis.nim.o \
c_code/1_1/@mmir@smirchangesets.nim.o \
c_code/1_1/@msem@sinjectdestructors.nim.o \
c_code/1_1/@mmir@smirbridge.nim.o \
c_code/1_1/@mvm@svmgen.nim.o \
c_code/1_1/@mvm@svmjit.nim.o \
c_code/1_1/@mvm@svmlegacy.nim.o \
c_code/1_1/@mvm@sgorgeimpl.nim.o \
c_code/1_1/@mvm@svmerrors.nim.o \
c_code/1_1/@mvm@svmdeps.nim.o \
c_code/1_1/@mvm@svmhooks.nim.o \
c_code/1_1/@mvm@svmops.nim.o \
c_code/1_1/@msem@smacrocacheimpl.nim.o \
c_code/1_1/@mvm@svmprofiler.nim.o \
c_code/1_1/@mvm@svmchecks.nim.o \
c_code/1_1/@mvm@svm.nim.o \
c_code/1_1/@mvm@scompilerbridge.nim.o \
c_code/1_1/@mtools@ssuggest.nim.o \
c_code/1_1/@msem@ssem.nim.o \
c_code/1_1/@msem@spassaux.nim.o \
c_code/1_1/@mmodules@sdepends.nim.o \
c_code/1_1/@mic@sreplayer.nim.o \
c_code/1_1/@mmodules@smodules.nim.o \
c_code/1_1/@msem@sdfa.nim.o \
c_code/1_1/@mbackend@scgen.nim.o \
c_code/1_1/@mvm@spacked_env.nim.o \
c_code/1_1/@mvm@svmbackend.nim.o \
c_code/1_1/@mic@sdce.nim.o \
c_code/1_1/@mic@scbackend.nim.o \
c_code/1_1/@mic@sintegrity.nim.o \
c_code/1_1/@mbackend@scbackend.nim.o \
c_code/1_1/@mfront@sscripting.nim.o \
c_code/1_1/@mbackend@sjsgen.nim.o \
c_code/1_1/@msem@ssourcemap.nim.o \
c_code/1_1/@mbackend@sjsbackend.nim.o \
c_code/1_1/stdlib_xmltree.nim.o \
c_code/1_1/@mast@srenderverbatim.nim.o \
c_code/1_1/stdlib_rstast.nim.o \
c_code/1_1/stdlib_highlite.nim.o \
c_code/1_1/stdlib_rst.nim.o \
c_code/1_1/stdlib_rstgen.nim.o \
c_code/1_1/stdlib_base64.nim.o \
c_code/1_1/stdlib_uri.nim.o \
c_code/1_1/@mtools@sdocgen.nim.o \
c_code/1_1/@mtools@sdocgen2.nim.o \
c_code/1_1/@mfront@smain.nim.o \
c_code/1_1/stdlib_browsers.nim.o \
c_code/1_1/@mnim.nim.o $LINK_FLAGS
    ;;
  amd64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_digitsutils.nim.c -o c_code/1_2/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_assertions.nim.c -o c_code/1_2/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dragonbox.nim.c -o c_code/1_2/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_schubfach.nim.c -o c_code/1_2/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_formatfloat.nim.c -o c_code/1_2/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dollars.nim.c -o c_code/1_2/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_widestrs.nim.c -o c_code/1_2/stdlib_widestrs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_io.nim.c -o c_code/1_2/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_system.nim.c -o c_code/1_2/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_parseutils.nim.c -o c_code/1_2/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_math.nim.c -o c_code/1_2/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_enumutils.nim.c -o c_code/1_2/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_unicode.nim.c -o c_code/1_2/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_strutils.nim.c -o c_code/1_2/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_pathnorm.nim.c -o c_code/1_2/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dynlib.nim.c -o c_code/1_2/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_winlean.nim.c -o c_code/1_2/stdlib_winlean.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_options.nim.c -o c_code/1_2/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_times.nim.c -o c_code/1_2/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_win_setenv.nim.c -o c_code/1_2/stdlib_win_setenv.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_os.nim.c -o c_code/1_2/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_hashes.nim.c -o c_code/1_2/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@spathutils.nim.c -o c_code/1_2/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sropes.nim.c -o c_code/1_2/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sidioms.nim.c -o c_code/1_2/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreport_enums.nim.c -o c_code/1_2/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@slineinfos.nim.c -o c_code/1_2/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@swordrecg.nim.c -o c_code/1_2/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sidents.nim.c -o c_code/1_2/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@splatform.nim.c -o c_code/1_2/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_strtabs.nim.c -o c_code/1_2/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@sin_options.nim.c -o c_code/1_2/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sint128.nim.c -o c_code/1_2/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_types.nim.c -o c_code/1_2/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_lexer.nim.c -o c_code/1_2/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_parser.nim.c -o c_code/1_2/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_base_sem.nim.c -o c_code/1_2/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@snilcheck_enums.nim.c -o c_code/1_2/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_sem.nim.c -o c_code/1_2/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_vm.nim.c -o c_code/1_2/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svm_enums.nim.c -o c_code/1_2/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_debug.nim.c -o c_code/1_2/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_backend.nim.c -o c_code/1_2/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_internal.nim.c -o c_code/1_2/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_external.nim.c -o c_code/1_2/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_cmd.nim.c -o c_code/1_2/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports.nim.c -o c_code/1_2/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sprefixmatches.nim.c -o c_code/1_2/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@snimpaths.nim.c -o c_code/1_2/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sstrutils2.nim.c -o c_code/1_2/@mutils@sstrutils2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_strformat.nim.c -o c_code/1_2/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_terminal.nim.c -o c_code/1_2/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_globs.nim.c -o c_code/1_2/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@soptions.nim.c -o c_code/1_2/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sllstream.nim.c -o c_code/1_2/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@snimlexbase.nim.c -o c_code/1_2/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@slexer.nim.c -o c_code/1_2/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_parsed_types.nim.c -o c_code/1_2/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@smsgs.nim.c -o c_code/1_2/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sequtils.nim.c -o c_code/1_2/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sha1.nim.c -o c_code/1_2/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_streams.nim.c -o c_code/1_2/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_lexbase.nim.c -o c_code/1_2/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_parsejson.nim.c -o c_code/1_2/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_json.nim.c -o c_code/1_2/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_idgen.nim.c -o c_code/1_2/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_query.nim.c -o c_code/1_2/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast.nim.c -o c_code/1_2/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_colortext.nim.c -o c_code/1_2/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sastrepr.nim.c -o c_code/1_2/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sparser.nim.c -o c_code/1_2/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@srenderer.nim.c -o c_code/1_2/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sfilters.nim.c -o c_code/1_2/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sfilter_tmpl.nim.c -o c_code/1_2/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@ssyntaxes.nim.c -o c_code/1_2/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@scondsyms.nim.c -o c_code/1_2/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_intsets.nim.c -o c_code/1_2/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_md5.nim.c -o c_code/1_2/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sastalgo.nim.c -o c_code/1_2/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@srodfiles.nim.c -o c_code/1_2/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@spacked_ast.nim.c -o c_code/1_2/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@sic.nim.c -o c_code/1_2/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@smodulegraphs.nim.c -o c_code/1_2/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_parseopt.nim.c -o c_code/1_2/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@snimblecmd.nim.c -o c_code/1_2/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_win_getsysteminfo.nim.c -o c_code/1_2/stdlib_win_getsysteminfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_cpuinfo.nim.c -o c_code/1_2/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_osproc.nim.c -o c_code/1_2/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_jsonutils.nim.c -o c_code/1_2/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@sextccomp.nim.c -o c_code/1_2/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@soptionsprocessor.nim.c -o c_code/1_2/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@snimconf.nim.c -o c_code/1_2/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@scommands.nim.c -o c_code/1_2/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sastmsgs.nim.c -o c_code/1_2/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@strees.nim.c -o c_code/1_2/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@serrorhandling.nim.c -o c_code/1_2/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@stypes.nim.c -o c_code/1_2/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@stypesrenderer.nim.c -o c_code/1_2/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@scli_reporter.nim.c -o c_code/1_2/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sexp.nim.c -o c_code/1_2/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_diff.nim.c -o c_code/1_2/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sexp_diff.nim.c -o c_code/1_2/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@ssexp_reporter.nim.c -o c_code/1_2/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@scmdlinehelper.nim.c -o c_code/1_2/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@sdepfiles.nim.c -o c_code/1_2/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@spasses.nim.c -o c_code/1_2/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@scollectors.nim.c -o c_code/1_2/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@schecked_ast.nim.c -o c_code/1_2/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sbitsets.nim.c -o c_code/1_2/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@snimsets.nim.c -o c_code/1_2/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@serrorreporting.nim.c -o c_code/1_2/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@smagicsys.nim.c -o c_code/1_2/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@senumtostr.nim.c -o c_code/1_2/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@slinter.nim.c -o c_code/1_2/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@smodulepaths.nim.c -o c_code/1_2/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmdef.nim.c -o c_code/1_2/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssemdata.nim.c -o c_code/1_2/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_editdistance.nim.c -o c_code/1_2/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@slookups.nim.c -o c_code/1_2/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@simporter.nim.c -o c_code/1_2/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssemfold.nim.c -o c_code/1_2/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@stypeallowed.nim.c -o c_code/1_2/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sisolation_check.nim.c -o c_code/1_2/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sprocfind.nim.c -o c_code/1_2/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@spragmas.nim.c -o c_code/1_2/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssemtypinst.nim.c -o c_code/1_2/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@slowerings.nim.c -o c_code/1_2/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sparampatterns.nim.c -o c_code/1_2/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssigmatch.nim.c -o c_code/1_2/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssighashes.nim.c -o c_code/1_2/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sndi.nim.c -o c_code/1_2/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@scgendata.nim.c -o c_code/1_2/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@sccgutils.nim.c -o c_code/1_2/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sliftdestructors.nim.c -o c_code/1_2/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@slambdalifting.nim.c -o c_code/1_2/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sclosureiters.nim.c -o c_code/1_2/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@svarpartitions.nim.c -o c_code/1_2/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@ssaturate.nim.c -o c_code/1_2/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sguards.nim.c -o c_code/1_2/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@streetab.nim.c -o c_code/1_2/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@snilcheck.nim.c -o c_code/1_2/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssempass2.nim.c -o c_code/1_2/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@scgmeth.nim.c -o c_code/1_2/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@stransf.nim.c -o c_code/1_2/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliases.nim.c -o c_code/1_2/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@spatterns.nim.c -o c_code/1_2/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sevaltempl.nim.c -o c_code/1_2/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@spluginsupport.nim.c -o c_code/1_2/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@slocals.nim.c -o c_code/1_2/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@sitersgen.nim.c -o c_code/1_2/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@sactive.nim.c -o c_code/1_2/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmtypegen.nim.c -o c_code/1_2/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmaux.nim.c -o c_code/1_2/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmtypes.nim.c -o c_code/1_2/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmmemory.nim.c -o c_code/1_2/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmobjects.nim.c -o c_code/1_2/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmcompilerserdes.nim.c -o c_code/1_2/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirtrees.nim.c -o c_code/1_2/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@sastgen.nim.c -o c_code/1_2/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirgen.nim.c -o c_code/1_2/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@sutils.nim.c -o c_code/1_2/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliasanalysis.nim.c -o c_code/1_2/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@smirexec.nim.c -o c_code/1_2/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@sanalysis.nim.c -o c_code/1_2/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirchangesets.nim.c -o c_code/1_2/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sinjectdestructors.nim.c -o c_code/1_2/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirbridge.nim.c -o c_code/1_2/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmgen.nim.c -o c_code/1_2/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmjit.nim.c -o c_code/1_2/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmlegacy.nim.c -o c_code/1_2/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@sgorgeimpl.nim.c -o c_code/1_2/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmerrors.nim.c -o c_code/1_2/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmdeps.nim.c -o c_code/1_2/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmhooks.nim.c -o c_code/1_2/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmops.nim.c -o c_code/1_2/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@smacrocacheimpl.nim.c -o c_code/1_2/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmprofiler.nim.c -o c_code/1_2/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmchecks.nim.c -o c_code/1_2/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svm.nim.c -o c_code/1_2/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@scompilerbridge.nim.c -o c_code/1_2/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mtools@ssuggest.nim.c -o c_code/1_2/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssem.nim.c -o c_code/1_2/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@spassaux.nim.c -o c_code/1_2/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@sdepends.nim.c -o c_code/1_2/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@sreplayer.nim.c -o c_code/1_2/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmodules@smodules.nim.c -o c_code/1_2/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sdfa.nim.c -o c_code/1_2/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@scgen.nim.c -o c_code/1_2/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@spacked_env.nim.c -o c_code/1_2/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmbackend.nim.c -o c_code/1_2/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@sdce.nim.c -o c_code/1_2/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@scbackend.nim.c -o c_code/1_2/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@sintegrity.nim.c -o c_code/1_2/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@scbackend.nim.c -o c_code/1_2/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@sscripting.nim.c -o c_code/1_2/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@sjsgen.nim.c -o c_code/1_2/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@ssourcemap.nim.c -o c_code/1_2/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mbackend@sjsbackend.nim.c -o c_code/1_2/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_xmltree.nim.c -o c_code/1_2/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@srenderverbatim.nim.c -o c_code/1_2/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_rstast.nim.c -o c_code/1_2/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_highlite.nim.c -o c_code/1_2/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_rst.nim.c -o c_code/1_2/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_rstgen.nim.c -o c_code/1_2/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_base64.nim.c -o c_code/1_2/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_uri.nim.c -o c_code/1_2/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mtools@sdocgen.nim.c -o c_code/1_2/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mtools@sdocgen2.nim.c -o c_code/1_2/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@smain.nim.c -o c_code/1_2/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_browsers.nim.c -o c_code/1_2/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mnim.nim.c -o c_code/1_2/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/1_2/stdlib_digitsutils.nim.o \
c_code/1_2/stdlib_assertions.nim.o \
c_code/1_2/stdlib_dragonbox.nim.o \
c_code/1_2/stdlib_schubfach.nim.o \
c_code/1_2/stdlib_formatfloat.nim.o \
c_code/1_2/stdlib_dollars.nim.o \
c_code/1_2/stdlib_widestrs.nim.o \
c_code/1_2/stdlib_io.nim.o \
c_code/1_2/stdlib_system.nim.o \
c_code/1_2/stdlib_parseutils.nim.o \
c_code/1_2/stdlib_math.nim.o \
c_code/1_2/stdlib_enumutils.nim.o \
c_code/1_2/stdlib_unicode.nim.o \
c_code/1_2/stdlib_strutils.nim.o \
c_code/1_2/stdlib_pathnorm.nim.o \
c_code/1_2/stdlib_dynlib.nim.o \
c_code/1_2/stdlib_winlean.nim.o \
c_code/1_2/stdlib_options.nim.o \
c_code/1_2/stdlib_times.nim.o \
c_code/1_2/stdlib_win_setenv.nim.o \
c_code/1_2/stdlib_os.nim.o \
c_code/1_2/stdlib_hashes.nim.o \
c_code/1_2/@mutils@spathutils.nim.o \
c_code/1_2/@mutils@sropes.nim.o \
c_code/1_2/@mutils@sidioms.nim.o \
c_code/1_2/@mast@sreport_enums.nim.o \
c_code/1_2/@mast@slineinfos.nim.o \
c_code/1_2/@mast@swordrecg.nim.o \
c_code/1_2/@mast@sidents.nim.o \
c_code/1_2/@mutils@splatform.nim.o \
c_code/1_2/stdlib_strtabs.nim.o \
c_code/1_2/@mfront@sin_options.nim.o \
c_code/1_2/@mutils@sint128.nim.o \
c_code/1_2/@mast@sast_types.nim.o \
c_code/1_2/@mast@sreports_lexer.nim.o \
c_code/1_2/@mast@sreports_parser.nim.o \
c_code/1_2/@mast@sreports_base_sem.nim.o \
c_code/1_2/@msem@snilcheck_enums.nim.o \
c_code/1_2/@mast@sreports_sem.nim.o \
c_code/1_2/@mast@sreports_vm.nim.o \
c_code/1_2/@mvm@svm_enums.nim.o \
c_code/1_2/@mast@sreports_debug.nim.o \
c_code/1_2/@mast@sreports_backend.nim.o \
c_code/1_2/@mast@sreports_internal.nim.o \
c_code/1_2/@mast@sreports_external.nim.o \
c_code/1_2/@mast@sreports_cmd.nim.o \
c_code/1_2/@mast@sreports.nim.o \
c_code/1_2/@mutils@sprefixmatches.nim.o \
c_code/1_2/@mmodules@snimpaths.nim.o \
c_code/1_2/@mutils@sstrutils2.nim.o \
c_code/1_2/stdlib_strformat.nim.o \
c_code/1_2/stdlib_terminal.nim.o \
c_code/1_2/stdlib_globs.nim.o \
c_code/1_2/@mfront@soptions.nim.o \
c_code/1_2/@mast@sllstream.nim.o \
c_code/1_2/@mast@snimlexbase.nim.o \
c_code/1_2/@mast@slexer.nim.o \
c_code/1_2/@mast@sast_parsed_types.nim.o \
c_code/1_2/@mfront@smsgs.nim.o \
c_code/1_2/stdlib_sequtils.nim.o \
c_code/1_2/stdlib_sha1.nim.o \
c_code/1_2/stdlib_streams.nim.o \
c_code/1_2/stdlib_lexbase.nim.o \
c_code/1_2/stdlib_parsejson.nim.o \
c_code/1_2/stdlib_json.nim.o \
c_code/1_2/@mast@sast_idgen.nim.o \
c_code/1_2/@mast@sast_query.nim.o \
c_code/1_2/@mast@sast.nim.o \
c_code/1_2/stdlib_colortext.nim.o \
c_code/1_2/@mutils@sastrepr.nim.o \
c_code/1_2/@mast@sparser.nim.o \
c_code/1_2/@mast@srenderer.nim.o \
c_code/1_2/@mast@sfilters.nim.o \
c_code/1_2/@mast@sfilter_tmpl.nim.o \
c_code/1_2/@mast@ssyntaxes.nim.o \
c_code/1_2/@mfront@scondsyms.nim.o \
c_code/1_2/stdlib_intsets.nim.o \
c_code/1_2/stdlib_md5.nim.o \
c_code/1_2/@mast@sastalgo.nim.o \
c_code/1_2/@mic@srodfiles.nim.o \
c_code/1_2/@mic@spacked_ast.nim.o \
c_code/1_2/@mic@sic.nim.o \
c_code/1_2/@mmodules@smodulegraphs.nim.o \
c_code/1_2/stdlib_parseopt.nim.o \
c_code/1_2/@mmodules@snimblecmd.nim.o \
c_code/1_2/stdlib_win_getsysteminfo.nim.o \
c_code/1_2/stdlib_cpuinfo.nim.o \
c_code/1_2/stdlib_osproc.nim.o \
c_code/1_2/stdlib_jsonutils.nim.o \
c_code/1_2/@mbackend@sextccomp.nim.o \
c_code/1_2/@mfront@soptionsprocessor.nim.o \
c_code/1_2/@mfront@snimconf.nim.o \
c_code/1_2/@mfront@scommands.nim.o \
c_code/1_2/@mast@sastmsgs.nim.o \
c_code/1_2/@mast@strees.nim.o \
c_code/1_2/@mast@serrorhandling.nim.o \
c_code/1_2/@mast@stypes.nim.o \
c_code/1_2/@mast@stypesrenderer.nim.o \
c_code/1_2/@mfront@scli_reporter.nim.o \
c_code/1_2/stdlib_sexp.nim.o \
c_code/1_2/stdlib_diff.nim.o \
c_code/1_2/stdlib_sexp_diff.nim.o \
c_code/1_2/@mfront@ssexp_reporter.nim.o \
c_code/1_2/@mfront@scmdlinehelper.nim.o \
c_code/1_2/@mfront@sdepfiles.nim.o \
c_code/1_2/@msem@spasses.nim.o \
c_code/1_2/@msem@scollectors.nim.o \
c_code/1_2/@mast@schecked_ast.nim.o \
c_code/1_2/@mutils@sbitsets.nim.o \
c_code/1_2/@mast@snimsets.nim.o \
c_code/1_2/@mast@serrorreporting.nim.o \
c_code/1_2/@mmodules@smagicsys.nim.o \
c_code/1_2/@mast@senumtostr.nim.o \
c_code/1_2/@mast@slinter.nim.o \
c_code/1_2/@mmodules@smodulepaths.nim.o \
c_code/1_2/@mvm@svmdef.nim.o \
c_code/1_2/@msem@ssemdata.nim.o \
c_code/1_2/stdlib_editdistance.nim.o \
c_code/1_2/@msem@slookups.nim.o \
c_code/1_2/@mmodules@simporter.nim.o \
c_code/1_2/@msem@ssemfold.nim.o \
c_code/1_2/@msem@stypeallowed.nim.o \
c_code/1_2/@msem@sisolation_check.nim.o \
c_code/1_2/@msem@sprocfind.nim.o \
c_code/1_2/@msem@spragmas.nim.o \
c_code/1_2/@msem@ssemtypinst.nim.o \
c_code/1_2/@msem@slowerings.nim.o \
c_code/1_2/@msem@sparampatterns.nim.o \
c_code/1_2/@msem@ssigmatch.nim.o \
c_code/1_2/@msem@ssighashes.nim.o \
c_code/1_2/@mast@sndi.nim.o \
c_code/1_2/@mbackend@scgendata.nim.o \
c_code/1_2/@mbackend@sccgutils.nim.o \
c_code/1_2/@msem@sliftdestructors.nim.o \
c_code/1_2/@msem@slambdalifting.nim.o \
c_code/1_2/@msem@sclosureiters.nim.o \
c_code/1_2/@msem@svarpartitions.nim.o \
c_code/1_2/@mutils@ssaturate.nim.o \
c_code/1_2/@msem@sguards.nim.o \
c_code/1_2/@mast@streetab.nim.o \
c_code/1_2/@msem@snilcheck.nim.o \
c_code/1_2/@msem@ssempass2.nim.o \
c_code/1_2/@mbackend@scgmeth.nim.o \
c_code/1_2/@msem@stransf.nim.o \
c_code/1_2/@msem@saliases.nim.o \
c_code/1_2/@msem@spatterns.nim.o \
c_code/1_2/@msem@sevaltempl.nim.o \
c_code/1_2/@mutils@spluginsupport.nim.o \
c_code/1_2/@mplugins@slocals.nim.o \
c_code/1_2/@mplugins@sitersgen.nim.o \
c_code/1_2/@mplugins@sactive.nim.o \
c_code/1_2/@mvm@svmtypegen.nim.o \
c_code/1_2/@mvm@svmaux.nim.o \
c_code/1_2/@mvm@svmtypes.nim.o \
c_code/1_2/@mvm@svmmemory.nim.o \
c_code/1_2/@mvm@svmobjects.nim.o \
c_code/1_2/@mvm@svmcompilerserdes.nim.o \
c_code/1_2/@mmir@smirtrees.nim.o \
c_code/1_2/@mmir@sastgen.nim.o \
c_code/1_2/@mmir@smirgen.nim.o \
c_code/1_2/@mmir@sutils.nim.o \
c_code/1_2/@msem@saliasanalysis.nim.o \
c_code/1_2/@msem@smirexec.nim.o \
c_code/1_2/@mmir@sanalysis.nim.o \
c_code/1_2/@mmir@smirchangesets.nim.o \
c_code/1_2/@msem@sinjectdestructors.nim.o \
c_code/1_2/@mmir@smirbridge.nim.o \
c_code/1_2/@mvm@svmgen.nim.o \
c_code/1_2/@mvm@svmjit.nim.o \
c_code/1_2/@mvm@svmlegacy.nim.o \
c_code/1_2/@mvm@sgorgeimpl.nim.o \
c_code/1_2/@mvm@svmerrors.nim.o \
c_code/1_2/@mvm@svmdeps.nim.o \
c_code/1_2/@mvm@svmhooks.nim.o \
c_code/1_2/@mvm@svmops.nim.o \
c_code/1_2/@msem@smacrocacheimpl.nim.o \
c_code/1_2/@mvm@svmprofiler.nim.o \
c_code/1_2/@mvm@svmchecks.nim.o \
c_code/1_2/@mvm@svm.nim.o \
c_code/1_2/@mvm@scompilerbridge.nim.o \
c_code/1_2/@mtools@ssuggest.nim.o \
c_code/1_2/@msem@ssem.nim.o \
c_code/1_2/@msem@spassaux.nim.o \
c_code/1_2/@mmodules@sdepends.nim.o \
c_code/1_2/@mic@sreplayer.nim.o \
c_code/1_2/@mmodules@smodules.nim.o \
c_code/1_2/@msem@sdfa.nim.o \
c_code/1_2/@mbackend@scgen.nim.o \
c_code/1_2/@mvm@spacked_env.nim.o \
c_code/1_2/@mvm@svmbackend.nim.o \
c_code/1_2/@mic@sdce.nim.o \
c_code/1_2/@mic@scbackend.nim.o \
c_code/1_2/@mic@sintegrity.nim.o \
c_code/1_2/@mbackend@scbackend.nim.o \
c_code/1_2/@mfront@sscripting.nim.o \
c_code/1_2/@mbackend@sjsgen.nim.o \
c_code/1_2/@msem@ssourcemap.nim.o \
c_code/1_2/@mbackend@sjsbackend.nim.o \
c_code/1_2/stdlib_xmltree.nim.o \
c_code/1_2/@mast@srenderverbatim.nim.o \
c_code/1_2/stdlib_rstast.nim.o \
c_code/1_2/stdlib_highlite.nim.o \
c_code/1_2/stdlib_rst.nim.o \
c_code/1_2/stdlib_rstgen.nim.o \
c_code/1_2/stdlib_base64.nim.o \
c_code/1_2/stdlib_uri.nim.o \
c_code/1_2/@mtools@sdocgen.nim.o \
c_code/1_2/@mtools@sdocgen2.nim.o \
c_code/1_2/@mfront@smain.nim.o \
c_code/1_2/stdlib_browsers.nim.o \
c_code/1_2/@mnim.nim.o $LINK_FLAGS
    ;;
  arm)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  arm64)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  *)
    echo 2>&1 "Error: no C code generated for: [$myos: $mycpu]"
    exit 1
    ;;
  esac
  ;;
linux)
  case $mycpu in
  i386)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_digitsutils.nim.c -o c_code/1_1/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_assertions.nim.c -o c_code/2_1/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_dragonbox.nim.c -o c_code/1_1/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_schubfach.nim.c -o c_code/1_1/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_formatfloat.nim.c -o c_code/1_1/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_dollars.nim.c -o c_code/1_1/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_io.nim.c -o c_code/2_1/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_system.nim.c -o c_code/2_1/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_parseutils.nim.c -o c_code/2_1/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_math.nim.c -o c_code/2_1/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_enumutils.nim.c -o c_code/1_1/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_unicode.nim.c -o c_code/2_1/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_strutils.nim.c -o c_code/2_1/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_pathnorm.nim.c -o c_code/2_1/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_options.nim.c -o c_code/2_1/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_times.nim.c -o c_code/2_1/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_os.nim.c -o c_code/2_1/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_hashes.nim.c -o c_code/1_1/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@spathutils.nim.c -o c_code/2_1/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@sropes.nim.c -o c_code/2_1/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@sidioms.nim.c -o c_code/2_1/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreport_enums.nim.c -o c_code/1_1/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@slineinfos.nim.c -o c_code/2_1/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@swordrecg.nim.c -o c_code/1_1/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sidents.nim.c -o c_code/2_1/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@splatform.nim.c -o c_code/2_1/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_strtabs.nim.c -o c_code/2_1/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mfront@sin_options.nim.c -o c_code/1_1/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@sint128.nim.c -o c_code/2_1/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sast_types.nim.c -o c_code/2_1/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_lexer.nim.c -o c_code/1_1/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_parser.nim.c -o c_code/1_1/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_base_sem.nim.c -o c_code/1_1/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@snilcheck_enums.nim.c -o c_code/1_1/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sreports_sem.nim.c -o c_code/2_1/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_vm.nim.c -o c_code/1_1/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svm_enums.nim.c -o c_code/1_1/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_debug.nim.c -o c_code/1_1/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_backend.nim.c -o c_code/1_1/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_internal.nim.c -o c_code/1_1/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_external.nim.c -o c_code/1_1/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sreports_cmd.nim.c -o c_code/1_1/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sreports.nim.c -o c_code/2_1/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@sprefixmatches.nim.c -o c_code/1_1/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@snimpaths.nim.c -o c_code/2_1/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_strformat.nim.c -o c_code/2_1/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_terminal.nim.c -o c_code/2_1/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_globs.nim.c -o c_code/2_1/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@soptions.nim.c -o c_code/2_1/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sllstream.nim.c -o c_code/2_1/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@snimlexbase.nim.c -o c_code/2_1/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@slexer.nim.c -o c_code/2_1/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sast_parsed_types.nim.c -o c_code/2_1/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@smsgs.nim.c -o c_code/2_1/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_sequtils.nim.c -o c_code/1_1/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_sha1.nim.c -o c_code/2_1/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_streams.nim.c -o c_code/2_1/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_lexbase.nim.c -o c_code/2_1/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_parsejson.nim.c -o c_code/2_1/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_json.nim.c -o c_code/2_1/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@sast_idgen.nim.c -o c_code/1_1/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sast_query.nim.c -o c_code/2_1/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sast.nim.c -o c_code/2_1/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_colortext.nim.c -o c_code/2_1/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@sastrepr.nim.c -o c_code/2_1/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sparser.nim.c -o c_code/2_1/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@srenderer.nim.c -o c_code/2_1/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sfilters.nim.c -o c_code/2_1/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sfilter_tmpl.nim.c -o c_code/2_1/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@ssyntaxes.nim.c -o c_code/2_1/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@scondsyms.nim.c -o c_code/2_1/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_intsets.nim.c -o c_code/2_1/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_md5.nim.c -o c_code/1_1/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sastalgo.nim.c -o c_code/2_1/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@srodfiles.nim.c -o c_code/2_1/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mic@spacked_ast.nim.c -o c_code/1_1/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@sic.nim.c -o c_code/2_1/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@smodulegraphs.nim.c -o c_code/2_1/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_parseopt.nim.c -o c_code/2_1/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@snimblecmd.nim.c -o c_code/2_1/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_cpuinfo.nim.c -o c_code/2_1/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_osproc.nim.c -o c_code/2_1/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_jsonutils.nim.c -o c_code/2_1/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@sextccomp.nim.c -o c_code/2_1/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@soptionsprocessor.nim.c -o c_code/2_1/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@snimconf.nim.c -o c_code/2_1/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@scommands.nim.c -o c_code/2_1/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sastmsgs.nim.c -o c_code/2_1/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@strees.nim.c -o c_code/2_1/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@serrorhandling.nim.c -o c_code/2_1/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@stypes.nim.c -o c_code/2_1/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@stypesrenderer.nim.c -o c_code/2_1/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@scli_reporter.nim.c -o c_code/2_1/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_sexp.nim.c -o c_code/2_1/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_diff.nim.c -o c_code/2_1/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_sexp_diff.nim.c -o c_code/2_1/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@ssexp_reporter.nim.c -o c_code/2_1/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@scmdlinehelper.nim.c -o c_code/2_1/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@sdepfiles.nim.c -o c_code/2_1/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@spasses.nim.c -o c_code/2_1/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@scollectors.nim.c -o c_code/2_1/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@schecked_ast.nim.c -o c_code/2_1/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@sbitsets.nim.c -o c_code/2_1/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@snimsets.nim.c -o c_code/2_1/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@serrorreporting.nim.c -o c_code/1_1/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@smagicsys.nim.c -o c_code/2_1/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@senumtostr.nim.c -o c_code/2_1/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@slinter.nim.c -o c_code/2_1/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@smodulepaths.nim.c -o c_code/2_1/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmdef.nim.c -o c_code/2_1/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssemdata.nim.c -o c_code/2_1/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_editdistance.nim.c -o c_code/2_1/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@slookups.nim.c -o c_code/2_1/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@simporter.nim.c -o c_code/2_1/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssemfold.nim.c -o c_code/2_1/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@stypeallowed.nim.c -o c_code/1_1/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sisolation_check.nim.c -o c_code/1_1/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sprocfind.nim.c -o c_code/1_1/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@spragmas.nim.c -o c_code/2_1/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssemtypinst.nim.c -o c_code/2_1/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@slowerings.nim.c -o c_code/2_1/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sparampatterns.nim.c -o c_code/2_1/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssigmatch.nim.c -o c_code/2_1/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssighashes.nim.c -o c_code/2_1/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@sndi.nim.c -o c_code/2_1/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@scgendata.nim.c -o c_code/2_1/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@sccgutils.nim.c -o c_code/2_1/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sliftdestructors.nim.c -o c_code/2_1/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@slambdalifting.nim.c -o c_code/2_1/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sclosureiters.nim.c -o c_code/2_1/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@svarpartitions.nim.c -o c_code/2_1/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mutils@ssaturate.nim.c -o c_code/2_1/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sguards.nim.c -o c_code/2_1/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mast@streetab.nim.c -o c_code/1_1/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@snilcheck.nim.c -o c_code/2_1/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssempass2.nim.c -o c_code/2_1/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@scgmeth.nim.c -o c_code/2_1/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@stransf.nim.c -o c_code/2_1/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@saliases.nim.c -o c_code/1_1/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@spatterns.nim.c -o c_code/2_1/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sevaltempl.nim.c -o c_code/2_1/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mutils@spluginsupport.nim.c -o c_code/1_1/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mplugins@slocals.nim.c -o c_code/1_1/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mplugins@sitersgen.nim.c -o c_code/2_1/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mplugins@sactive.nim.c -o c_code/1_1/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmtypegen.nim.c -o c_code/2_1/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmaux.nim.c -o c_code/2_1/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmtypes.nim.c -o c_code/2_1/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmmemory.nim.c -o c_code/2_1/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmobjects.nim.c -o c_code/2_1/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmcompilerserdes.nim.c -o c_code/2_1/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@smirtrees.nim.c -o c_code/2_1/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@sastgen.nim.c -o c_code/2_1/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@smirgen.nim.c -o c_code/2_1/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@sutils.nim.c -o c_code/2_1/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@saliasanalysis.nim.c -o c_code/1_1/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@smirexec.nim.c -o c_code/2_1/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@sanalysis.nim.c -o c_code/2_1/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mmir@smirchangesets.nim.c -o c_code/1_1/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@sinjectdestructors.nim.c -o c_code/2_1/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmir@smirbridge.nim.c -o c_code/2_1/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmgen.nim.c -o c_code/2_1/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmjit.nim.c -o c_code/2_1/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@mvm@svmlegacy.nim.c -o c_code/1_1/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@sgorgeimpl.nim.c -o c_code/2_1/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmerrors.nim.c -o c_code/2_1/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmdeps.nim.c -o c_code/2_1/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmhooks.nim.c -o c_code/2_1/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmops.nim.c -o c_code/2_1/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@smacrocacheimpl.nim.c -o c_code/1_1/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmprofiler.nim.c -o c_code/2_1/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmchecks.nim.c -o c_code/2_1/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svm.nim.c -o c_code/2_1/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@scompilerbridge.nim.c -o c_code/2_1/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mtools@ssuggest.nim.c -o c_code/2_1/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssem.nim.c -o c_code/2_1/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@spassaux.nim.c -o c_code/2_1/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@sdepends.nim.c -o c_code/2_1/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@sreplayer.nim.c -o c_code/2_1/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mmodules@smodules.nim.c -o c_code/2_1/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_dynlib.nim.c -o c_code/2_1/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/@msem@sdfa.nim.c -o c_code/1_1/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@scgen.nim.c -o c_code/2_1/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@spacked_env.nim.c -o c_code/2_1/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mvm@svmbackend.nim.c -o c_code/2_1/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@sdce.nim.c -o c_code/2_1/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@scbackend.nim.c -o c_code/2_1/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mic@sintegrity.nim.c -o c_code/2_1/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@scbackend.nim.c -o c_code/2_1/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@sscripting.nim.c -o c_code/2_1/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@sjsgen.nim.c -o c_code/2_1/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@msem@ssourcemap.nim.c -o c_code/2_1/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mbackend@sjsbackend.nim.c -o c_code/2_1/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_xmltree.nim.c -o c_code/1_1/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mast@srenderverbatim.nim.c -o c_code/2_1/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_rstast.nim.c -o c_code/2_1/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_highlite.nim.c -o c_code/2_1/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_rst.nim.c -o c_code/2_1/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_rstgen.nim.c -o c_code/2_1/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_1/stdlib_base64.nim.c -o c_code/1_1/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_uri.nim.c -o c_code/2_1/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mtools@sdocgen.nim.c -o c_code/2_1/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mtools@sdocgen2.nim.c -o c_code/2_1/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mfront@smain.nim.c -o c_code/2_1/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/stdlib_browsers.nim.c -o c_code/2_1/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_1/@mnim.nim.c -o c_code/2_1/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/1_1/stdlib_digitsutils.nim.o \
c_code/2_1/stdlib_assertions.nim.o \
c_code/1_1/stdlib_dragonbox.nim.o \
c_code/1_1/stdlib_schubfach.nim.o \
c_code/1_1/stdlib_formatfloat.nim.o \
c_code/1_1/stdlib_dollars.nim.o \
c_code/2_1/stdlib_io.nim.o \
c_code/2_1/stdlib_system.nim.o \
c_code/2_1/stdlib_parseutils.nim.o \
c_code/2_1/stdlib_math.nim.o \
c_code/1_1/stdlib_enumutils.nim.o \
c_code/2_1/stdlib_unicode.nim.o \
c_code/2_1/stdlib_strutils.nim.o \
c_code/2_1/stdlib_pathnorm.nim.o \
c_code/2_1/stdlib_options.nim.o \
c_code/2_1/stdlib_times.nim.o \
c_code/2_1/stdlib_os.nim.o \
c_code/1_1/stdlib_hashes.nim.o \
c_code/2_1/@mutils@spathutils.nim.o \
c_code/2_1/@mutils@sropes.nim.o \
c_code/2_1/@mutils@sidioms.nim.o \
c_code/1_1/@mast@sreport_enums.nim.o \
c_code/2_1/@mast@slineinfos.nim.o \
c_code/1_1/@mast@swordrecg.nim.o \
c_code/2_1/@mast@sidents.nim.o \
c_code/2_1/@mutils@splatform.nim.o \
c_code/2_1/stdlib_strtabs.nim.o \
c_code/1_1/@mfront@sin_options.nim.o \
c_code/2_1/@mutils@sint128.nim.o \
c_code/2_1/@mast@sast_types.nim.o \
c_code/1_1/@mast@sreports_lexer.nim.o \
c_code/1_1/@mast@sreports_parser.nim.o \
c_code/1_1/@mast@sreports_base_sem.nim.o \
c_code/1_1/@msem@snilcheck_enums.nim.o \
c_code/2_1/@mast@sreports_sem.nim.o \
c_code/1_1/@mast@sreports_vm.nim.o \
c_code/1_1/@mvm@svm_enums.nim.o \
c_code/1_1/@mast@sreports_debug.nim.o \
c_code/1_1/@mast@sreports_backend.nim.o \
c_code/1_1/@mast@sreports_internal.nim.o \
c_code/1_1/@mast@sreports_external.nim.o \
c_code/1_1/@mast@sreports_cmd.nim.o \
c_code/2_1/@mast@sreports.nim.o \
c_code/1_1/@mutils@sprefixmatches.nim.o \
c_code/2_1/@mmodules@snimpaths.nim.o \
c_code/2_1/stdlib_strformat.nim.o \
c_code/2_1/stdlib_terminal.nim.o \
c_code/2_1/stdlib_globs.nim.o \
c_code/2_1/@mfront@soptions.nim.o \
c_code/2_1/@mast@sllstream.nim.o \
c_code/2_1/@mast@snimlexbase.nim.o \
c_code/2_1/@mast@slexer.nim.o \
c_code/2_1/@mast@sast_parsed_types.nim.o \
c_code/2_1/@mfront@smsgs.nim.o \
c_code/1_1/stdlib_sequtils.nim.o \
c_code/2_1/stdlib_sha1.nim.o \
c_code/2_1/stdlib_streams.nim.o \
c_code/2_1/stdlib_lexbase.nim.o \
c_code/2_1/stdlib_parsejson.nim.o \
c_code/2_1/stdlib_json.nim.o \
c_code/1_1/@mast@sast_idgen.nim.o \
c_code/2_1/@mast@sast_query.nim.o \
c_code/2_1/@mast@sast.nim.o \
c_code/2_1/stdlib_colortext.nim.o \
c_code/2_1/@mutils@sastrepr.nim.o \
c_code/2_1/@mast@sparser.nim.o \
c_code/2_1/@mast@srenderer.nim.o \
c_code/2_1/@mast@sfilters.nim.o \
c_code/2_1/@mast@sfilter_tmpl.nim.o \
c_code/2_1/@mast@ssyntaxes.nim.o \
c_code/2_1/@mfront@scondsyms.nim.o \
c_code/2_1/stdlib_intsets.nim.o \
c_code/1_1/stdlib_md5.nim.o \
c_code/2_1/@mast@sastalgo.nim.o \
c_code/2_1/@mic@srodfiles.nim.o \
c_code/1_1/@mic@spacked_ast.nim.o \
c_code/2_1/@mic@sic.nim.o \
c_code/2_1/@mmodules@smodulegraphs.nim.o \
c_code/2_1/stdlib_parseopt.nim.o \
c_code/2_1/@mmodules@snimblecmd.nim.o \
c_code/2_1/stdlib_cpuinfo.nim.o \
c_code/2_1/stdlib_osproc.nim.o \
c_code/2_1/stdlib_jsonutils.nim.o \
c_code/2_1/@mbackend@sextccomp.nim.o \
c_code/2_1/@mfront@soptionsprocessor.nim.o \
c_code/2_1/@mfront@snimconf.nim.o \
c_code/2_1/@mfront@scommands.nim.o \
c_code/2_1/@mast@sastmsgs.nim.o \
c_code/2_1/@mast@strees.nim.o \
c_code/2_1/@mast@serrorhandling.nim.o \
c_code/2_1/@mast@stypes.nim.o \
c_code/2_1/@mast@stypesrenderer.nim.o \
c_code/2_1/@mfront@scli_reporter.nim.o \
c_code/2_1/stdlib_sexp.nim.o \
c_code/2_1/stdlib_diff.nim.o \
c_code/2_1/stdlib_sexp_diff.nim.o \
c_code/2_1/@mfront@ssexp_reporter.nim.o \
c_code/2_1/@mfront@scmdlinehelper.nim.o \
c_code/2_1/@mfront@sdepfiles.nim.o \
c_code/2_1/@msem@spasses.nim.o \
c_code/2_1/@msem@scollectors.nim.o \
c_code/2_1/@mast@schecked_ast.nim.o \
c_code/2_1/@mutils@sbitsets.nim.o \
c_code/2_1/@mast@snimsets.nim.o \
c_code/1_1/@mast@serrorreporting.nim.o \
c_code/2_1/@mmodules@smagicsys.nim.o \
c_code/2_1/@mast@senumtostr.nim.o \
c_code/2_1/@mast@slinter.nim.o \
c_code/2_1/@mmodules@smodulepaths.nim.o \
c_code/2_1/@mvm@svmdef.nim.o \
c_code/2_1/@msem@ssemdata.nim.o \
c_code/2_1/stdlib_editdistance.nim.o \
c_code/2_1/@msem@slookups.nim.o \
c_code/2_1/@mmodules@simporter.nim.o \
c_code/2_1/@msem@ssemfold.nim.o \
c_code/1_1/@msem@stypeallowed.nim.o \
c_code/1_1/@msem@sisolation_check.nim.o \
c_code/1_1/@msem@sprocfind.nim.o \
c_code/2_1/@msem@spragmas.nim.o \
c_code/2_1/@msem@ssemtypinst.nim.o \
c_code/2_1/@msem@slowerings.nim.o \
c_code/2_1/@msem@sparampatterns.nim.o \
c_code/2_1/@msem@ssigmatch.nim.o \
c_code/2_1/@msem@ssighashes.nim.o \
c_code/2_1/@mast@sndi.nim.o \
c_code/2_1/@mbackend@scgendata.nim.o \
c_code/2_1/@mbackend@sccgutils.nim.o \
c_code/2_1/@msem@sliftdestructors.nim.o \
c_code/2_1/@msem@slambdalifting.nim.o \
c_code/2_1/@msem@sclosureiters.nim.o \
c_code/2_1/@msem@svarpartitions.nim.o \
c_code/2_1/@mutils@ssaturate.nim.o \
c_code/2_1/@msem@sguards.nim.o \
c_code/1_1/@mast@streetab.nim.o \
c_code/2_1/@msem@snilcheck.nim.o \
c_code/2_1/@msem@ssempass2.nim.o \
c_code/2_1/@mbackend@scgmeth.nim.o \
c_code/2_1/@msem@stransf.nim.o \
c_code/1_1/@msem@saliases.nim.o \
c_code/2_1/@msem@spatterns.nim.o \
c_code/2_1/@msem@sevaltempl.nim.o \
c_code/1_1/@mutils@spluginsupport.nim.o \
c_code/1_1/@mplugins@slocals.nim.o \
c_code/2_1/@mplugins@sitersgen.nim.o \
c_code/1_1/@mplugins@sactive.nim.o \
c_code/2_1/@mvm@svmtypegen.nim.o \
c_code/2_1/@mvm@svmaux.nim.o \
c_code/2_1/@mvm@svmtypes.nim.o \
c_code/2_1/@mvm@svmmemory.nim.o \
c_code/2_1/@mvm@svmobjects.nim.o \
c_code/2_1/@mvm@svmcompilerserdes.nim.o \
c_code/2_1/@mmir@smirtrees.nim.o \
c_code/2_1/@mmir@sastgen.nim.o \
c_code/2_1/@mmir@smirgen.nim.o \
c_code/2_1/@mmir@sutils.nim.o \
c_code/1_1/@msem@saliasanalysis.nim.o \
c_code/2_1/@msem@smirexec.nim.o \
c_code/2_1/@mmir@sanalysis.nim.o \
c_code/1_1/@mmir@smirchangesets.nim.o \
c_code/2_1/@msem@sinjectdestructors.nim.o \
c_code/2_1/@mmir@smirbridge.nim.o \
c_code/2_1/@mvm@svmgen.nim.o \
c_code/2_1/@mvm@svmjit.nim.o \
c_code/1_1/@mvm@svmlegacy.nim.o \
c_code/2_1/@mvm@sgorgeimpl.nim.o \
c_code/2_1/@mvm@svmerrors.nim.o \
c_code/2_1/@mvm@svmdeps.nim.o \
c_code/2_1/@mvm@svmhooks.nim.o \
c_code/2_1/@mvm@svmops.nim.o \
c_code/1_1/@msem@smacrocacheimpl.nim.o \
c_code/2_1/@mvm@svmprofiler.nim.o \
c_code/2_1/@mvm@svmchecks.nim.o \
c_code/2_1/@mvm@svm.nim.o \
c_code/2_1/@mvm@scompilerbridge.nim.o \
c_code/2_1/@mtools@ssuggest.nim.o \
c_code/2_1/@msem@ssem.nim.o \
c_code/2_1/@msem@spassaux.nim.o \
c_code/2_1/@mmodules@sdepends.nim.o \
c_code/2_1/@mic@sreplayer.nim.o \
c_code/2_1/@mmodules@smodules.nim.o \
c_code/2_1/stdlib_dynlib.nim.o \
c_code/1_1/@msem@sdfa.nim.o \
c_code/2_1/@mbackend@scgen.nim.o \
c_code/2_1/@mvm@spacked_env.nim.o \
c_code/2_1/@mvm@svmbackend.nim.o \
c_code/2_1/@mic@sdce.nim.o \
c_code/2_1/@mic@scbackend.nim.o \
c_code/2_1/@mic@sintegrity.nim.o \
c_code/2_1/@mbackend@scbackend.nim.o \
c_code/2_1/@mfront@sscripting.nim.o \
c_code/2_1/@mbackend@sjsgen.nim.o \
c_code/2_1/@msem@ssourcemap.nim.o \
c_code/2_1/@mbackend@sjsbackend.nim.o \
c_code/1_1/stdlib_xmltree.nim.o \
c_code/2_1/@mast@srenderverbatim.nim.o \
c_code/2_1/stdlib_rstast.nim.o \
c_code/2_1/stdlib_highlite.nim.o \
c_code/2_1/stdlib_rst.nim.o \
c_code/2_1/stdlib_rstgen.nim.o \
c_code/1_1/stdlib_base64.nim.o \
c_code/2_1/stdlib_uri.nim.o \
c_code/2_1/@mtools@sdocgen.nim.o \
c_code/2_1/@mtools@sdocgen2.nim.o \
c_code/2_1/@mfront@smain.nim.o \
c_code/2_1/stdlib_browsers.nim.o \
c_code/2_1/@mnim.nim.o $LINK_FLAGS
    ;;
  amd64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_digitsutils.nim.c -o c_code/1_2/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_assertions.nim.c -o c_code/2_2/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dragonbox.nim.c -o c_code/1_2/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_schubfach.nim.c -o c_code/1_2/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_formatfloat.nim.c -o c_code/1_2/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dollars.nim.c -o c_code/1_2/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_io.nim.c -o c_code/2_2/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_system.nim.c -o c_code/2_2/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_parseutils.nim.c -o c_code/2_2/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_math.nim.c -o c_code/2_2/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_enumutils.nim.c -o c_code/1_2/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_unicode.nim.c -o c_code/2_2/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_strutils.nim.c -o c_code/2_2/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_pathnorm.nim.c -o c_code/2_2/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_posix.nim.c -o c_code/2_2/stdlib_posix.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_options.nim.c -o c_code/2_2/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_times.nim.c -o c_code/2_2/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_os.nim.c -o c_code/2_2/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_hashes.nim.c -o c_code/1_2/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@spathutils.nim.c -o c_code/2_2/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sropes.nim.c -o c_code/2_2/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sidioms.nim.c -o c_code/2_2/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreport_enums.nim.c -o c_code/1_2/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@slineinfos.nim.c -o c_code/2_2/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@swordrecg.nim.c -o c_code/1_2/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sidents.nim.c -o c_code/2_2/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@splatform.nim.c -o c_code/2_2/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_strtabs.nim.c -o c_code/2_2/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@sin_options.nim.c -o c_code/1_2/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sint128.nim.c -o c_code/2_2/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_types.nim.c -o c_code/2_2/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_lexer.nim.c -o c_code/1_2/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_parser.nim.c -o c_code/1_2/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_base_sem.nim.c -o c_code/1_2/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@snilcheck_enums.nim.c -o c_code/1_2/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sreports_sem.nim.c -o c_code/2_2/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_vm.nim.c -o c_code/1_2/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svm_enums.nim.c -o c_code/1_2/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_debug.nim.c -o c_code/1_2/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_backend.nim.c -o c_code/1_2/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_internal.nim.c -o c_code/1_2/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_external.nim.c -o c_code/1_2/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_cmd.nim.c -o c_code/1_2/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sreports.nim.c -o c_code/2_2/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sprefixmatches.nim.c -o c_code/1_2/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@snimpaths.nim.c -o c_code/2_2/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_strformat.nim.c -o c_code/2_2/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_terminal.nim.c -o c_code/2_2/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_globs.nim.c -o c_code/2_2/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@soptions.nim.c -o c_code/2_2/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sllstream.nim.c -o c_code/2_2/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@snimlexbase.nim.c -o c_code/2_2/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@slexer.nim.c -o c_code/2_2/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_parsed_types.nim.c -o c_code/2_2/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@smsgs.nim.c -o c_code/2_2/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sequtils.nim.c -o c_code/1_2/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_sha1.nim.c -o c_code/2_2/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_streams.nim.c -o c_code/2_2/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_lexbase.nim.c -o c_code/2_2/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_parsejson.nim.c -o c_code/2_2/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_json.nim.c -o c_code/2_2/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_idgen.nim.c -o c_code/1_2/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_query.nim.c -o c_code/2_2/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast.nim.c -o c_code/2_2/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_colortext.nim.c -o c_code/2_2/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sastrepr.nim.c -o c_code/2_2/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sparser.nim.c -o c_code/2_2/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@srenderer.nim.c -o c_code/2_2/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sfilters.nim.c -o c_code/2_2/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sfilter_tmpl.nim.c -o c_code/2_2/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@ssyntaxes.nim.c -o c_code/2_2/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@scondsyms.nim.c -o c_code/2_2/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_intsets.nim.c -o c_code/2_2/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_md5.nim.c -o c_code/1_2/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sastalgo.nim.c -o c_code/2_2/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@srodfiles.nim.c -o c_code/2_2/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@spacked_ast.nim.c -o c_code/1_2/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@sic.nim.c -o c_code/2_2/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@smodulegraphs.nim.c -o c_code/2_2/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_parseopt.nim.c -o c_code/2_2/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@snimblecmd.nim.c -o c_code/2_2/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_cpuinfo.nim.c -o c_code/2_2/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_osproc.nim.c -o c_code/2_2/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_jsonutils.nim.c -o c_code/2_2/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@sextccomp.nim.c -o c_code/2_2/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@soptionsprocessor.nim.c -o c_code/2_2/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@snimconf.nim.c -o c_code/2_2/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@scommands.nim.c -o c_code/2_2/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sastmsgs.nim.c -o c_code/2_2/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@strees.nim.c -o c_code/2_2/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@serrorhandling.nim.c -o c_code/2_2/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@stypes.nim.c -o c_code/2_2/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@stypesrenderer.nim.c -o c_code/2_2/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@scli_reporter.nim.c -o c_code/2_2/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_sexp.nim.c -o c_code/2_2/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_diff.nim.c -o c_code/2_2/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_sexp_diff.nim.c -o c_code/2_2/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@ssexp_reporter.nim.c -o c_code/2_2/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@scmdlinehelper.nim.c -o c_code/2_2/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@sdepfiles.nim.c -o c_code/2_2/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@spasses.nim.c -o c_code/2_2/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@scollectors.nim.c -o c_code/2_2/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@schecked_ast.nim.c -o c_code/1_2/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sbitsets.nim.c -o c_code/2_2/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@snimsets.nim.c -o c_code/2_2/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@serrorreporting.nim.c -o c_code/1_2/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@smagicsys.nim.c -o c_code/2_2/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@senumtostr.nim.c -o c_code/2_2/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@slinter.nim.c -o c_code/2_2/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@smodulepaths.nim.c -o c_code/2_2/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmdef.nim.c -o c_code/2_2/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssemdata.nim.c -o c_code/2_2/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_editdistance.nim.c -o c_code/2_2/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@slookups.nim.c -o c_code/2_2/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@simporter.nim.c -o c_code/2_2/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssemfold.nim.c -o c_code/2_2/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@stypeallowed.nim.c -o c_code/1_2/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sisolation_check.nim.c -o c_code/1_2/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sprocfind.nim.c -o c_code/1_2/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@spragmas.nim.c -o c_code/2_2/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssemtypinst.nim.c -o c_code/2_2/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@slowerings.nim.c -o c_code/2_2/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sparampatterns.nim.c -o c_code/2_2/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssigmatch.nim.c -o c_code/2_2/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssighashes.nim.c -o c_code/2_2/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sndi.nim.c -o c_code/2_2/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@scgendata.nim.c -o c_code/2_2/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@sccgutils.nim.c -o c_code/2_2/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sliftdestructors.nim.c -o c_code/2_2/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@slambdalifting.nim.c -o c_code/2_2/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sclosureiters.nim.c -o c_code/2_2/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@svarpartitions.nim.c -o c_code/2_2/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@ssaturate.nim.c -o c_code/2_2/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sguards.nim.c -o c_code/1_2/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@streetab.nim.c -o c_code/1_2/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@snilcheck.nim.c -o c_code/2_2/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssempass2.nim.c -o c_code/2_2/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@scgmeth.nim.c -o c_code/2_2/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@stransf.nim.c -o c_code/2_2/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliases.nim.c -o c_code/1_2/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@spatterns.nim.c -o c_code/2_2/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sevaltempl.nim.c -o c_code/2_2/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@spluginsupport.nim.c -o c_code/1_2/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@slocals.nim.c -o c_code/1_2/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mplugins@sitersgen.nim.c -o c_code/2_2/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@sactive.nim.c -o c_code/1_2/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmtypegen.nim.c -o c_code/2_2/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmaux.nim.c -o c_code/2_2/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmtypes.nim.c -o c_code/2_2/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmmemory.nim.c -o c_code/2_2/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmobjects.nim.c -o c_code/2_2/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmcompilerserdes.nim.c -o c_code/2_2/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@smirtrees.nim.c -o c_code/2_2/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sastgen.nim.c -o c_code/2_2/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@smirgen.nim.c -o c_code/2_2/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sutils.nim.c -o c_code/2_2/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliasanalysis.nim.c -o c_code/1_2/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@smirexec.nim.c -o c_code/2_2/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sanalysis.nim.c -o c_code/2_2/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirchangesets.nim.c -o c_code/1_2/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sinjectdestructors.nim.c -o c_code/2_2/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@smirbridge.nim.c -o c_code/2_2/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmgen.nim.c -o c_code/2_2/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmjit.nim.c -o c_code/2_2/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmlegacy.nim.c -o c_code/1_2/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@sgorgeimpl.nim.c -o c_code/2_2/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmerrors.nim.c -o c_code/2_2/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmdeps.nim.c -o c_code/2_2/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmhooks.nim.c -o c_code/2_2/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmops.nim.c -o c_code/2_2/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@smacrocacheimpl.nim.c -o c_code/1_2/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmprofiler.nim.c -o c_code/2_2/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmchecks.nim.c -o c_code/2_2/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svm.nim.c -o c_code/2_2/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@scompilerbridge.nim.c -o c_code/2_2/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mtools@ssuggest.nim.c -o c_code/2_2/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssem.nim.c -o c_code/2_2/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@spassaux.nim.c -o c_code/2_2/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@sdepends.nim.c -o c_code/2_2/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@sreplayer.nim.c -o c_code/2_2/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmodules@smodules.nim.c -o c_code/2_2/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_dynlib.nim.c -o c_code/2_2/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sdfa.nim.c -o c_code/1_2/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@scgen.nim.c -o c_code/2_2/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@spacked_env.nim.c -o c_code/2_2/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmbackend.nim.c -o c_code/2_2/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@sdce.nim.c -o c_code/2_2/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@scbackend.nim.c -o c_code/2_2/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@sintegrity.nim.c -o c_code/2_2/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@scbackend.nim.c -o c_code/2_2/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@sscripting.nim.c -o c_code/2_2/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@sjsgen.nim.c -o c_code/2_2/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssourcemap.nim.c -o c_code/2_2/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mbackend@sjsbackend.nim.c -o c_code/2_2/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_xmltree.nim.c -o c_code/1_2/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@srenderverbatim.nim.c -o c_code/2_2/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_rstast.nim.c -o c_code/2_2/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_highlite.nim.c -o c_code/2_2/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_rst.nim.c -o c_code/2_2/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_rstgen.nim.c -o c_code/2_2/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_base64.nim.c -o c_code/1_2/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_uri.nim.c -o c_code/2_2/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mtools@sdocgen.nim.c -o c_code/2_2/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mtools@sdocgen2.nim.c -o c_code/2_2/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@smain.nim.c -o c_code/2_2/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_browsers.nim.c -o c_code/2_2/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mnim.nim.c -o c_code/2_2/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/1_2/stdlib_digitsutils.nim.o \
c_code/2_2/stdlib_assertions.nim.o \
c_code/1_2/stdlib_dragonbox.nim.o \
c_code/1_2/stdlib_schubfach.nim.o \
c_code/1_2/stdlib_formatfloat.nim.o \
c_code/1_2/stdlib_dollars.nim.o \
c_code/2_2/stdlib_io.nim.o \
c_code/2_2/stdlib_system.nim.o \
c_code/2_2/stdlib_parseutils.nim.o \
c_code/2_2/stdlib_math.nim.o \
c_code/1_2/stdlib_enumutils.nim.o \
c_code/2_2/stdlib_unicode.nim.o \
c_code/2_2/stdlib_strutils.nim.o \
c_code/2_2/stdlib_pathnorm.nim.o \
c_code/2_2/stdlib_posix.nim.o \
c_code/2_2/stdlib_options.nim.o \
c_code/2_2/stdlib_times.nim.o \
c_code/2_2/stdlib_os.nim.o \
c_code/1_2/stdlib_hashes.nim.o \
c_code/2_2/@mutils@spathutils.nim.o \
c_code/2_2/@mutils@sropes.nim.o \
c_code/2_2/@mutils@sidioms.nim.o \
c_code/1_2/@mast@sreport_enums.nim.o \
c_code/2_2/@mast@slineinfos.nim.o \
c_code/1_2/@mast@swordrecg.nim.o \
c_code/2_2/@mast@sidents.nim.o \
c_code/2_2/@mutils@splatform.nim.o \
c_code/2_2/stdlib_strtabs.nim.o \
c_code/1_2/@mfront@sin_options.nim.o \
c_code/2_2/@mutils@sint128.nim.o \
c_code/2_2/@mast@sast_types.nim.o \
c_code/1_2/@mast@sreports_lexer.nim.o \
c_code/1_2/@mast@sreports_parser.nim.o \
c_code/1_2/@mast@sreports_base_sem.nim.o \
c_code/1_2/@msem@snilcheck_enums.nim.o \
c_code/2_2/@mast@sreports_sem.nim.o \
c_code/1_2/@mast@sreports_vm.nim.o \
c_code/1_2/@mvm@svm_enums.nim.o \
c_code/1_2/@mast@sreports_debug.nim.o \
c_code/1_2/@mast@sreports_backend.nim.o \
c_code/1_2/@mast@sreports_internal.nim.o \
c_code/1_2/@mast@sreports_external.nim.o \
c_code/1_2/@mast@sreports_cmd.nim.o \
c_code/2_2/@mast@sreports.nim.o \
c_code/1_2/@mutils@sprefixmatches.nim.o \
c_code/2_2/@mmodules@snimpaths.nim.o \
c_code/2_2/stdlib_strformat.nim.o \
c_code/2_2/stdlib_terminal.nim.o \
c_code/2_2/stdlib_globs.nim.o \
c_code/2_2/@mfront@soptions.nim.o \
c_code/2_2/@mast@sllstream.nim.o \
c_code/2_2/@mast@snimlexbase.nim.o \
c_code/2_2/@mast@slexer.nim.o \
c_code/2_2/@mast@sast_parsed_types.nim.o \
c_code/2_2/@mfront@smsgs.nim.o \
c_code/1_2/stdlib_sequtils.nim.o \
c_code/2_2/stdlib_sha1.nim.o \
c_code/2_2/stdlib_streams.nim.o \
c_code/2_2/stdlib_lexbase.nim.o \
c_code/2_2/stdlib_parsejson.nim.o \
c_code/2_2/stdlib_json.nim.o \
c_code/1_2/@mast@sast_idgen.nim.o \
c_code/2_2/@mast@sast_query.nim.o \
c_code/2_2/@mast@sast.nim.o \
c_code/2_2/stdlib_colortext.nim.o \
c_code/2_2/@mutils@sastrepr.nim.o \
c_code/2_2/@mast@sparser.nim.o \
c_code/2_2/@mast@srenderer.nim.o \
c_code/2_2/@mast@sfilters.nim.o \
c_code/2_2/@mast@sfilter_tmpl.nim.o \
c_code/2_2/@mast@ssyntaxes.nim.o \
c_code/2_2/@mfront@scondsyms.nim.o \
c_code/2_2/stdlib_intsets.nim.o \
c_code/1_2/stdlib_md5.nim.o \
c_code/2_2/@mast@sastalgo.nim.o \
c_code/2_2/@mic@srodfiles.nim.o \
c_code/1_2/@mic@spacked_ast.nim.o \
c_code/2_2/@mic@sic.nim.o \
c_code/2_2/@mmodules@smodulegraphs.nim.o \
c_code/2_2/stdlib_parseopt.nim.o \
c_code/2_2/@mmodules@snimblecmd.nim.o \
c_code/2_2/stdlib_cpuinfo.nim.o \
c_code/2_2/stdlib_osproc.nim.o \
c_code/2_2/stdlib_jsonutils.nim.o \
c_code/2_2/@mbackend@sextccomp.nim.o \
c_code/2_2/@mfront@soptionsprocessor.nim.o \
c_code/2_2/@mfront@snimconf.nim.o \
c_code/2_2/@mfront@scommands.nim.o \
c_code/2_2/@mast@sastmsgs.nim.o \
c_code/2_2/@mast@strees.nim.o \
c_code/2_2/@mast@serrorhandling.nim.o \
c_code/2_2/@mast@stypes.nim.o \
c_code/2_2/@mast@stypesrenderer.nim.o \
c_code/2_2/@mfront@scli_reporter.nim.o \
c_code/2_2/stdlib_sexp.nim.o \
c_code/2_2/stdlib_diff.nim.o \
c_code/2_2/stdlib_sexp_diff.nim.o \
c_code/2_2/@mfront@ssexp_reporter.nim.o \
c_code/2_2/@mfront@scmdlinehelper.nim.o \
c_code/2_2/@mfront@sdepfiles.nim.o \
c_code/2_2/@msem@spasses.nim.o \
c_code/2_2/@msem@scollectors.nim.o \
c_code/1_2/@mast@schecked_ast.nim.o \
c_code/2_2/@mutils@sbitsets.nim.o \
c_code/2_2/@mast@snimsets.nim.o \
c_code/1_2/@mast@serrorreporting.nim.o \
c_code/2_2/@mmodules@smagicsys.nim.o \
c_code/2_2/@mast@senumtostr.nim.o \
c_code/2_2/@mast@slinter.nim.o \
c_code/2_2/@mmodules@smodulepaths.nim.o \
c_code/2_2/@mvm@svmdef.nim.o \
c_code/2_2/@msem@ssemdata.nim.o \
c_code/2_2/stdlib_editdistance.nim.o \
c_code/2_2/@msem@slookups.nim.o \
c_code/2_2/@mmodules@simporter.nim.o \
c_code/2_2/@msem@ssemfold.nim.o \
c_code/1_2/@msem@stypeallowed.nim.o \
c_code/1_2/@msem@sisolation_check.nim.o \
c_code/1_2/@msem@sprocfind.nim.o \
c_code/2_2/@msem@spragmas.nim.o \
c_code/2_2/@msem@ssemtypinst.nim.o \
c_code/2_2/@msem@slowerings.nim.o \
c_code/2_2/@msem@sparampatterns.nim.o \
c_code/2_2/@msem@ssigmatch.nim.o \
c_code/2_2/@msem@ssighashes.nim.o \
c_code/2_2/@mast@sndi.nim.o \
c_code/2_2/@mbackend@scgendata.nim.o \
c_code/2_2/@mbackend@sccgutils.nim.o \
c_code/2_2/@msem@sliftdestructors.nim.o \
c_code/2_2/@msem@slambdalifting.nim.o \
c_code/2_2/@msem@sclosureiters.nim.o \
c_code/2_2/@msem@svarpartitions.nim.o \
c_code/2_2/@mutils@ssaturate.nim.o \
c_code/1_2/@msem@sguards.nim.o \
c_code/1_2/@mast@streetab.nim.o \
c_code/2_2/@msem@snilcheck.nim.o \
c_code/2_2/@msem@ssempass2.nim.o \
c_code/2_2/@mbackend@scgmeth.nim.o \
c_code/2_2/@msem@stransf.nim.o \
c_code/1_2/@msem@saliases.nim.o \
c_code/2_2/@msem@spatterns.nim.o \
c_code/2_2/@msem@sevaltempl.nim.o \
c_code/1_2/@mutils@spluginsupport.nim.o \
c_code/1_2/@mplugins@slocals.nim.o \
c_code/2_2/@mplugins@sitersgen.nim.o \
c_code/1_2/@mplugins@sactive.nim.o \
c_code/2_2/@mvm@svmtypegen.nim.o \
c_code/2_2/@mvm@svmaux.nim.o \
c_code/2_2/@mvm@svmtypes.nim.o \
c_code/2_2/@mvm@svmmemory.nim.o \
c_code/2_2/@mvm@svmobjects.nim.o \
c_code/2_2/@mvm@svmcompilerserdes.nim.o \
c_code/2_2/@mmir@smirtrees.nim.o \
c_code/2_2/@mmir@sastgen.nim.o \
c_code/2_2/@mmir@smirgen.nim.o \
c_code/2_2/@mmir@sutils.nim.o \
c_code/1_2/@msem@saliasanalysis.nim.o \
c_code/2_2/@msem@smirexec.nim.o \
c_code/2_2/@mmir@sanalysis.nim.o \
c_code/1_2/@mmir@smirchangesets.nim.o \
c_code/2_2/@msem@sinjectdestructors.nim.o \
c_code/2_2/@mmir@smirbridge.nim.o \
c_code/2_2/@mvm@svmgen.nim.o \
c_code/2_2/@mvm@svmjit.nim.o \
c_code/1_2/@mvm@svmlegacy.nim.o \
c_code/2_2/@mvm@sgorgeimpl.nim.o \
c_code/2_2/@mvm@svmerrors.nim.o \
c_code/2_2/@mvm@svmdeps.nim.o \
c_code/2_2/@mvm@svmhooks.nim.o \
c_code/2_2/@mvm@svmops.nim.o \
c_code/1_2/@msem@smacrocacheimpl.nim.o \
c_code/2_2/@mvm@svmprofiler.nim.o \
c_code/2_2/@mvm@svmchecks.nim.o \
c_code/2_2/@mvm@svm.nim.o \
c_code/2_2/@mvm@scompilerbridge.nim.o \
c_code/2_2/@mtools@ssuggest.nim.o \
c_code/2_2/@msem@ssem.nim.o \
c_code/2_2/@msem@spassaux.nim.o \
c_code/2_2/@mmodules@sdepends.nim.o \
c_code/2_2/@mic@sreplayer.nim.o \
c_code/2_2/@mmodules@smodules.nim.o \
c_code/2_2/stdlib_dynlib.nim.o \
c_code/1_2/@msem@sdfa.nim.o \
c_code/2_2/@mbackend@scgen.nim.o \
c_code/2_2/@mvm@spacked_env.nim.o \
c_code/2_2/@mvm@svmbackend.nim.o \
c_code/2_2/@mic@sdce.nim.o \
c_code/2_2/@mic@scbackend.nim.o \
c_code/2_2/@mic@sintegrity.nim.o \
c_code/2_2/@mbackend@scbackend.nim.o \
c_code/2_2/@mfront@sscripting.nim.o \
c_code/2_2/@mbackend@sjsgen.nim.o \
c_code/2_2/@msem@ssourcemap.nim.o \
c_code/2_2/@mbackend@sjsbackend.nim.o \
c_code/1_2/stdlib_xmltree.nim.o \
c_code/2_2/@mast@srenderverbatim.nim.o \
c_code/2_2/stdlib_rstast.nim.o \
c_code/2_2/stdlib_highlite.nim.o \
c_code/2_2/stdlib_rst.nim.o \
c_code/2_2/stdlib_rstgen.nim.o \
c_code/1_2/stdlib_base64.nim.o \
c_code/2_2/stdlib_uri.nim.o \
c_code/2_2/@mtools@sdocgen.nim.o \
c_code/2_2/@mtools@sdocgen2.nim.o \
c_code/2_2/@mfront@smain.nim.o \
c_code/2_2/stdlib_browsers.nim.o \
c_code/2_2/@mnim.nim.o $LINK_FLAGS
    ;;
  arm)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_digitsutils.nim.c -o c_code/2_3/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_assertions.nim.c -o c_code/2_3/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_dragonbox.nim.c -o c_code/2_3/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_schubfach.nim.c -o c_code/2_3/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_formatfloat.nim.c -o c_code/2_3/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_dollars.nim.c -o c_code/2_3/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_io.nim.c -o c_code/2_3/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_system.nim.c -o c_code/2_3/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_parseutils.nim.c -o c_code/2_3/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_math.nim.c -o c_code/2_3/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_enumutils.nim.c -o c_code/2_3/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_unicode.nim.c -o c_code/2_3/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_strutils.nim.c -o c_code/2_3/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_pathnorm.nim.c -o c_code/2_3/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_options.nim.c -o c_code/2_3/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_times.nim.c -o c_code/2_3/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_os.nim.c -o c_code/2_3/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_hashes.nim.c -o c_code/2_3/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@spathutils.nim.c -o c_code/2_3/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sropes.nim.c -o c_code/2_3/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sidioms.nim.c -o c_code/2_3/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreport_enums.nim.c -o c_code/2_3/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@slineinfos.nim.c -o c_code/2_3/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@swordrecg.nim.c -o c_code/2_3/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sidents.nim.c -o c_code/2_3/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@splatform.nim.c -o c_code/2_3/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_strtabs.nim.c -o c_code/2_3/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@sin_options.nim.c -o c_code/2_3/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sint128.nim.c -o c_code/2_3/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sast_types.nim.c -o c_code/2_3/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_lexer.nim.c -o c_code/2_3/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_parser.nim.c -o c_code/2_3/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_base_sem.nim.c -o c_code/2_3/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@snilcheck_enums.nim.c -o c_code/2_3/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_sem.nim.c -o c_code/2_3/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_vm.nim.c -o c_code/2_3/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svm_enums.nim.c -o c_code/2_3/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_debug.nim.c -o c_code/2_3/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_backend.nim.c -o c_code/2_3/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_internal.nim.c -o c_code/2_3/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_external.nim.c -o c_code/2_3/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports_cmd.nim.c -o c_code/2_3/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sreports.nim.c -o c_code/2_3/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sprefixmatches.nim.c -o c_code/2_3/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@snimpaths.nim.c -o c_code/2_3/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_strformat.nim.c -o c_code/2_3/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_terminal.nim.c -o c_code/2_3/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_globs.nim.c -o c_code/2_3/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@soptions.nim.c -o c_code/2_3/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sllstream.nim.c -o c_code/2_3/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@snimlexbase.nim.c -o c_code/2_3/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@slexer.nim.c -o c_code/2_3/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sast_parsed_types.nim.c -o c_code/2_3/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@smsgs.nim.c -o c_code/2_3/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_sequtils.nim.c -o c_code/2_3/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_sha1.nim.c -o c_code/2_3/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_streams.nim.c -o c_code/2_3/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_lexbase.nim.c -o c_code/2_3/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_parsejson.nim.c -o c_code/2_3/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_json.nim.c -o c_code/2_3/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sast_idgen.nim.c -o c_code/2_3/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sast_query.nim.c -o c_code/2_3/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sast.nim.c -o c_code/2_3/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_colortext.nim.c -o c_code/2_3/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sastrepr.nim.c -o c_code/2_3/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sparser.nim.c -o c_code/2_3/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@srenderer.nim.c -o c_code/2_3/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sfilters.nim.c -o c_code/2_3/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sfilter_tmpl.nim.c -o c_code/2_3/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@ssyntaxes.nim.c -o c_code/2_3/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@scondsyms.nim.c -o c_code/2_3/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_intsets.nim.c -o c_code/2_3/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_md5.nim.c -o c_code/2_3/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sastalgo.nim.c -o c_code/2_3/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@srodfiles.nim.c -o c_code/2_3/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@spacked_ast.nim.c -o c_code/2_3/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@sic.nim.c -o c_code/2_3/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@smodulegraphs.nim.c -o c_code/2_3/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_parseopt.nim.c -o c_code/2_3/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@snimblecmd.nim.c -o c_code/2_3/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_cpuinfo.nim.c -o c_code/2_3/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_osproc.nim.c -o c_code/2_3/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_jsonutils.nim.c -o c_code/2_3/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@sextccomp.nim.c -o c_code/2_3/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@soptionsprocessor.nim.c -o c_code/2_3/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@snimconf.nim.c -o c_code/2_3/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@scommands.nim.c -o c_code/2_3/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sastmsgs.nim.c -o c_code/2_3/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@strees.nim.c -o c_code/2_3/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@serrorhandling.nim.c -o c_code/2_3/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@stypes.nim.c -o c_code/2_3/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@stypesrenderer.nim.c -o c_code/2_3/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@scli_reporter.nim.c -o c_code/2_3/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_sexp.nim.c -o c_code/2_3/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_diff.nim.c -o c_code/2_3/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_sexp_diff.nim.c -o c_code/2_3/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@ssexp_reporter.nim.c -o c_code/2_3/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@scmdlinehelper.nim.c -o c_code/2_3/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@sdepfiles.nim.c -o c_code/2_3/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@spasses.nim.c -o c_code/2_3/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@scollectors.nim.c -o c_code/2_3/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@schecked_ast.nim.c -o c_code/2_3/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@sbitsets.nim.c -o c_code/2_3/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@snimsets.nim.c -o c_code/2_3/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@serrorreporting.nim.c -o c_code/2_3/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@smagicsys.nim.c -o c_code/2_3/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@senumtostr.nim.c -o c_code/2_3/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@slinter.nim.c -o c_code/2_3/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@smodulepaths.nim.c -o c_code/2_3/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmdef.nim.c -o c_code/2_3/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssemdata.nim.c -o c_code/2_3/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_editdistance.nim.c -o c_code/2_3/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@slookups.nim.c -o c_code/2_3/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@simporter.nim.c -o c_code/2_3/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssemfold.nim.c -o c_code/2_3/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@stypeallowed.nim.c -o c_code/2_3/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sisolation_check.nim.c -o c_code/2_3/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sprocfind.nim.c -o c_code/2_3/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@spragmas.nim.c -o c_code/2_3/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssemtypinst.nim.c -o c_code/2_3/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@slowerings.nim.c -o c_code/2_3/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sparampatterns.nim.c -o c_code/2_3/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssigmatch.nim.c -o c_code/2_3/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssighashes.nim.c -o c_code/2_3/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@sndi.nim.c -o c_code/2_3/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@scgendata.nim.c -o c_code/2_3/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@sccgutils.nim.c -o c_code/2_3/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sliftdestructors.nim.c -o c_code/2_3/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@slambdalifting.nim.c -o c_code/2_3/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sclosureiters.nim.c -o c_code/2_3/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@svarpartitions.nim.c -o c_code/2_3/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@ssaturate.nim.c -o c_code/2_3/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sguards.nim.c -o c_code/2_3/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@streetab.nim.c -o c_code/2_3/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@snilcheck.nim.c -o c_code/2_3/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssempass2.nim.c -o c_code/2_3/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@scgmeth.nim.c -o c_code/2_3/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@stransf.nim.c -o c_code/2_3/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@saliases.nim.c -o c_code/2_3/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@spatterns.nim.c -o c_code/2_3/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sevaltempl.nim.c -o c_code/2_3/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mutils@spluginsupport.nim.c -o c_code/2_3/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mplugins@slocals.nim.c -o c_code/2_3/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mplugins@sitersgen.nim.c -o c_code/2_3/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mplugins@sactive.nim.c -o c_code/2_3/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmtypegen.nim.c -o c_code/2_3/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmaux.nim.c -o c_code/2_3/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmtypes.nim.c -o c_code/2_3/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmmemory.nim.c -o c_code/2_3/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmobjects.nim.c -o c_code/2_3/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmcompilerserdes.nim.c -o c_code/2_3/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@smirtrees.nim.c -o c_code/2_3/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@sastgen.nim.c -o c_code/2_3/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@smirgen.nim.c -o c_code/2_3/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@sutils.nim.c -o c_code/2_3/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@saliasanalysis.nim.c -o c_code/2_3/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@smirexec.nim.c -o c_code/2_3/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@sanalysis.nim.c -o c_code/2_3/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@smirchangesets.nim.c -o c_code/2_3/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sinjectdestructors.nim.c -o c_code/2_3/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmir@smirbridge.nim.c -o c_code/2_3/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmgen.nim.c -o c_code/2_3/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmjit.nim.c -o c_code/2_3/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmlegacy.nim.c -o c_code/2_3/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@sgorgeimpl.nim.c -o c_code/2_3/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmerrors.nim.c -o c_code/2_3/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmdeps.nim.c -o c_code/2_3/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmhooks.nim.c -o c_code/2_3/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmops.nim.c -o c_code/2_3/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@smacrocacheimpl.nim.c -o c_code/2_3/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmprofiler.nim.c -o c_code/2_3/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmchecks.nim.c -o c_code/2_3/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svm.nim.c -o c_code/2_3/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@scompilerbridge.nim.c -o c_code/2_3/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mtools@ssuggest.nim.c -o c_code/2_3/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssem.nim.c -o c_code/2_3/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@spassaux.nim.c -o c_code/2_3/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@sdepends.nim.c -o c_code/2_3/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@sreplayer.nim.c -o c_code/2_3/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mmodules@smodules.nim.c -o c_code/2_3/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_dynlib.nim.c -o c_code/2_3/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@sdfa.nim.c -o c_code/2_3/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@scgen.nim.c -o c_code/2_3/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@spacked_env.nim.c -o c_code/2_3/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mvm@svmbackend.nim.c -o c_code/2_3/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@sdce.nim.c -o c_code/2_3/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@scbackend.nim.c -o c_code/2_3/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mic@sintegrity.nim.c -o c_code/2_3/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@scbackend.nim.c -o c_code/2_3/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@sscripting.nim.c -o c_code/2_3/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@sjsgen.nim.c -o c_code/2_3/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@msem@ssourcemap.nim.c -o c_code/2_3/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mbackend@sjsbackend.nim.c -o c_code/2_3/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_xmltree.nim.c -o c_code/2_3/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mast@srenderverbatim.nim.c -o c_code/2_3/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_rstast.nim.c -o c_code/2_3/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_highlite.nim.c -o c_code/2_3/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_rst.nim.c -o c_code/2_3/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_rstgen.nim.c -o c_code/2_3/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_base64.nim.c -o c_code/2_3/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_uri.nim.c -o c_code/2_3/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mtools@sdocgen.nim.c -o c_code/2_3/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mtools@sdocgen2.nim.c -o c_code/2_3/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mfront@smain.nim.c -o c_code/2_3/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/stdlib_browsers.nim.c -o c_code/2_3/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_3/@mnim.nim.c -o c_code/2_3/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/2_3/stdlib_digitsutils.nim.o \
c_code/2_3/stdlib_assertions.nim.o \
c_code/2_3/stdlib_dragonbox.nim.o \
c_code/2_3/stdlib_schubfach.nim.o \
c_code/2_3/stdlib_formatfloat.nim.o \
c_code/2_3/stdlib_dollars.nim.o \
c_code/2_3/stdlib_io.nim.o \
c_code/2_3/stdlib_system.nim.o \
c_code/2_3/stdlib_parseutils.nim.o \
c_code/2_3/stdlib_math.nim.o \
c_code/2_3/stdlib_enumutils.nim.o \
c_code/2_3/stdlib_unicode.nim.o \
c_code/2_3/stdlib_strutils.nim.o \
c_code/2_3/stdlib_pathnorm.nim.o \
c_code/2_3/stdlib_options.nim.o \
c_code/2_3/stdlib_times.nim.o \
c_code/2_3/stdlib_os.nim.o \
c_code/2_3/stdlib_hashes.nim.o \
c_code/2_3/@mutils@spathutils.nim.o \
c_code/2_3/@mutils@sropes.nim.o \
c_code/2_3/@mutils@sidioms.nim.o \
c_code/2_3/@mast@sreport_enums.nim.o \
c_code/2_3/@mast@slineinfos.nim.o \
c_code/2_3/@mast@swordrecg.nim.o \
c_code/2_3/@mast@sidents.nim.o \
c_code/2_3/@mutils@splatform.nim.o \
c_code/2_3/stdlib_strtabs.nim.o \
c_code/2_3/@mfront@sin_options.nim.o \
c_code/2_3/@mutils@sint128.nim.o \
c_code/2_3/@mast@sast_types.nim.o \
c_code/2_3/@mast@sreports_lexer.nim.o \
c_code/2_3/@mast@sreports_parser.nim.o \
c_code/2_3/@mast@sreports_base_sem.nim.o \
c_code/2_3/@msem@snilcheck_enums.nim.o \
c_code/2_3/@mast@sreports_sem.nim.o \
c_code/2_3/@mast@sreports_vm.nim.o \
c_code/2_3/@mvm@svm_enums.nim.o \
c_code/2_3/@mast@sreports_debug.nim.o \
c_code/2_3/@mast@sreports_backend.nim.o \
c_code/2_3/@mast@sreports_internal.nim.o \
c_code/2_3/@mast@sreports_external.nim.o \
c_code/2_3/@mast@sreports_cmd.nim.o \
c_code/2_3/@mast@sreports.nim.o \
c_code/2_3/@mutils@sprefixmatches.nim.o \
c_code/2_3/@mmodules@snimpaths.nim.o \
c_code/2_3/stdlib_strformat.nim.o \
c_code/2_3/stdlib_terminal.nim.o \
c_code/2_3/stdlib_globs.nim.o \
c_code/2_3/@mfront@soptions.nim.o \
c_code/2_3/@mast@sllstream.nim.o \
c_code/2_3/@mast@snimlexbase.nim.o \
c_code/2_3/@mast@slexer.nim.o \
c_code/2_3/@mast@sast_parsed_types.nim.o \
c_code/2_3/@mfront@smsgs.nim.o \
c_code/2_3/stdlib_sequtils.nim.o \
c_code/2_3/stdlib_sha1.nim.o \
c_code/2_3/stdlib_streams.nim.o \
c_code/2_3/stdlib_lexbase.nim.o \
c_code/2_3/stdlib_parsejson.nim.o \
c_code/2_3/stdlib_json.nim.o \
c_code/2_3/@mast@sast_idgen.nim.o \
c_code/2_3/@mast@sast_query.nim.o \
c_code/2_3/@mast@sast.nim.o \
c_code/2_3/stdlib_colortext.nim.o \
c_code/2_3/@mutils@sastrepr.nim.o \
c_code/2_3/@mast@sparser.nim.o \
c_code/2_3/@mast@srenderer.nim.o \
c_code/2_3/@mast@sfilters.nim.o \
c_code/2_3/@mast@sfilter_tmpl.nim.o \
c_code/2_3/@mast@ssyntaxes.nim.o \
c_code/2_3/@mfront@scondsyms.nim.o \
c_code/2_3/stdlib_intsets.nim.o \
c_code/2_3/stdlib_md5.nim.o \
c_code/2_3/@mast@sastalgo.nim.o \
c_code/2_3/@mic@srodfiles.nim.o \
c_code/2_3/@mic@spacked_ast.nim.o \
c_code/2_3/@mic@sic.nim.o \
c_code/2_3/@mmodules@smodulegraphs.nim.o \
c_code/2_3/stdlib_parseopt.nim.o \
c_code/2_3/@mmodules@snimblecmd.nim.o \
c_code/2_3/stdlib_cpuinfo.nim.o \
c_code/2_3/stdlib_osproc.nim.o \
c_code/2_3/stdlib_jsonutils.nim.o \
c_code/2_3/@mbackend@sextccomp.nim.o \
c_code/2_3/@mfront@soptionsprocessor.nim.o \
c_code/2_3/@mfront@snimconf.nim.o \
c_code/2_3/@mfront@scommands.nim.o \
c_code/2_3/@mast@sastmsgs.nim.o \
c_code/2_3/@mast@strees.nim.o \
c_code/2_3/@mast@serrorhandling.nim.o \
c_code/2_3/@mast@stypes.nim.o \
c_code/2_3/@mast@stypesrenderer.nim.o \
c_code/2_3/@mfront@scli_reporter.nim.o \
c_code/2_3/stdlib_sexp.nim.o \
c_code/2_3/stdlib_diff.nim.o \
c_code/2_3/stdlib_sexp_diff.nim.o \
c_code/2_3/@mfront@ssexp_reporter.nim.o \
c_code/2_3/@mfront@scmdlinehelper.nim.o \
c_code/2_3/@mfront@sdepfiles.nim.o \
c_code/2_3/@msem@spasses.nim.o \
c_code/2_3/@msem@scollectors.nim.o \
c_code/2_3/@mast@schecked_ast.nim.o \
c_code/2_3/@mutils@sbitsets.nim.o \
c_code/2_3/@mast@snimsets.nim.o \
c_code/2_3/@mast@serrorreporting.nim.o \
c_code/2_3/@mmodules@smagicsys.nim.o \
c_code/2_3/@mast@senumtostr.nim.o \
c_code/2_3/@mast@slinter.nim.o \
c_code/2_3/@mmodules@smodulepaths.nim.o \
c_code/2_3/@mvm@svmdef.nim.o \
c_code/2_3/@msem@ssemdata.nim.o \
c_code/2_3/stdlib_editdistance.nim.o \
c_code/2_3/@msem@slookups.nim.o \
c_code/2_3/@mmodules@simporter.nim.o \
c_code/2_3/@msem@ssemfold.nim.o \
c_code/2_3/@msem@stypeallowed.nim.o \
c_code/2_3/@msem@sisolation_check.nim.o \
c_code/2_3/@msem@sprocfind.nim.o \
c_code/2_3/@msem@spragmas.nim.o \
c_code/2_3/@msem@ssemtypinst.nim.o \
c_code/2_3/@msem@slowerings.nim.o \
c_code/2_3/@msem@sparampatterns.nim.o \
c_code/2_3/@msem@ssigmatch.nim.o \
c_code/2_3/@msem@ssighashes.nim.o \
c_code/2_3/@mast@sndi.nim.o \
c_code/2_3/@mbackend@scgendata.nim.o \
c_code/2_3/@mbackend@sccgutils.nim.o \
c_code/2_3/@msem@sliftdestructors.nim.o \
c_code/2_3/@msem@slambdalifting.nim.o \
c_code/2_3/@msem@sclosureiters.nim.o \
c_code/2_3/@msem@svarpartitions.nim.o \
c_code/2_3/@mutils@ssaturate.nim.o \
c_code/2_3/@msem@sguards.nim.o \
c_code/2_3/@mast@streetab.nim.o \
c_code/2_3/@msem@snilcheck.nim.o \
c_code/2_3/@msem@ssempass2.nim.o \
c_code/2_3/@mbackend@scgmeth.nim.o \
c_code/2_3/@msem@stransf.nim.o \
c_code/2_3/@msem@saliases.nim.o \
c_code/2_3/@msem@spatterns.nim.o \
c_code/2_3/@msem@sevaltempl.nim.o \
c_code/2_3/@mutils@spluginsupport.nim.o \
c_code/2_3/@mplugins@slocals.nim.o \
c_code/2_3/@mplugins@sitersgen.nim.o \
c_code/2_3/@mplugins@sactive.nim.o \
c_code/2_3/@mvm@svmtypegen.nim.o \
c_code/2_3/@mvm@svmaux.nim.o \
c_code/2_3/@mvm@svmtypes.nim.o \
c_code/2_3/@mvm@svmmemory.nim.o \
c_code/2_3/@mvm@svmobjects.nim.o \
c_code/2_3/@mvm@svmcompilerserdes.nim.o \
c_code/2_3/@mmir@smirtrees.nim.o \
c_code/2_3/@mmir@sastgen.nim.o \
c_code/2_3/@mmir@smirgen.nim.o \
c_code/2_3/@mmir@sutils.nim.o \
c_code/2_3/@msem@saliasanalysis.nim.o \
c_code/2_3/@msem@smirexec.nim.o \
c_code/2_3/@mmir@sanalysis.nim.o \
c_code/2_3/@mmir@smirchangesets.nim.o \
c_code/2_3/@msem@sinjectdestructors.nim.o \
c_code/2_3/@mmir@smirbridge.nim.o \
c_code/2_3/@mvm@svmgen.nim.o \
c_code/2_3/@mvm@svmjit.nim.o \
c_code/2_3/@mvm@svmlegacy.nim.o \
c_code/2_3/@mvm@sgorgeimpl.nim.o \
c_code/2_3/@mvm@svmerrors.nim.o \
c_code/2_3/@mvm@svmdeps.nim.o \
c_code/2_3/@mvm@svmhooks.nim.o \
c_code/2_3/@mvm@svmops.nim.o \
c_code/2_3/@msem@smacrocacheimpl.nim.o \
c_code/2_3/@mvm@svmprofiler.nim.o \
c_code/2_3/@mvm@svmchecks.nim.o \
c_code/2_3/@mvm@svm.nim.o \
c_code/2_3/@mvm@scompilerbridge.nim.o \
c_code/2_3/@mtools@ssuggest.nim.o \
c_code/2_3/@msem@ssem.nim.o \
c_code/2_3/@msem@spassaux.nim.o \
c_code/2_3/@mmodules@sdepends.nim.o \
c_code/2_3/@mic@sreplayer.nim.o \
c_code/2_3/@mmodules@smodules.nim.o \
c_code/2_3/stdlib_dynlib.nim.o \
c_code/2_3/@msem@sdfa.nim.o \
c_code/2_3/@mbackend@scgen.nim.o \
c_code/2_3/@mvm@spacked_env.nim.o \
c_code/2_3/@mvm@svmbackend.nim.o \
c_code/2_3/@mic@sdce.nim.o \
c_code/2_3/@mic@scbackend.nim.o \
c_code/2_3/@mic@sintegrity.nim.o \
c_code/2_3/@mbackend@scbackend.nim.o \
c_code/2_3/@mfront@sscripting.nim.o \
c_code/2_3/@mbackend@sjsgen.nim.o \
c_code/2_3/@msem@ssourcemap.nim.o \
c_code/2_3/@mbackend@sjsbackend.nim.o \
c_code/2_3/stdlib_xmltree.nim.o \
c_code/2_3/@mast@srenderverbatim.nim.o \
c_code/2_3/stdlib_rstast.nim.o \
c_code/2_3/stdlib_highlite.nim.o \
c_code/2_3/stdlib_rst.nim.o \
c_code/2_3/stdlib_rstgen.nim.o \
c_code/2_3/stdlib_base64.nim.o \
c_code/2_3/stdlib_uri.nim.o \
c_code/2_3/@mtools@sdocgen.nim.o \
c_code/2_3/@mtools@sdocgen2.nim.o \
c_code/2_3/@mfront@smain.nim.o \
c_code/2_3/stdlib_browsers.nim.o \
c_code/2_3/@mnim.nim.o $LINK_FLAGS
    ;;
  arm64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_digitsutils.nim.c -o c_code/2_4/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_assertions.nim.c -o c_code/2_4/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dragonbox.nim.c -o c_code/2_4/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_schubfach.nim.c -o c_code/2_4/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_formatfloat.nim.c -o c_code/2_4/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dollars.nim.c -o c_code/2_4/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_io.nim.c -o c_code/2_4/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_system.nim.c -o c_code/2_4/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parseutils.nim.c -o c_code/2_4/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_math.nim.c -o c_code/2_4/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_enumutils.nim.c -o c_code/2_4/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_unicode.nim.c -o c_code/2_4/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strutils.nim.c -o c_code/2_4/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_pathnorm.nim.c -o c_code/2_4/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_options.nim.c -o c_code/2_4/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_times.nim.c -o c_code/2_4/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_os.nim.c -o c_code/2_4/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_hashes.nim.c -o c_code/2_4/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spathutils.nim.c -o c_code/2_4/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sropes.nim.c -o c_code/2_4/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sidioms.nim.c -o c_code/2_4/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreport_enums.nim.c -o c_code/2_4/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slineinfos.nim.c -o c_code/2_4/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@swordrecg.nim.c -o c_code/2_4/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sidents.nim.c -o c_code/2_4/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@splatform.nim.c -o c_code/2_4/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strtabs.nim.c -o c_code/2_4/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sin_options.nim.c -o c_code/2_4/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sint128.nim.c -o c_code/2_4/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_types.nim.c -o c_code/2_4/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_lexer.nim.c -o c_code/2_4/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_parser.nim.c -o c_code/2_4/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_base_sem.nim.c -o c_code/2_4/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@snilcheck_enums.nim.c -o c_code/2_4/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_sem.nim.c -o c_code/2_4/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_vm.nim.c -o c_code/2_4/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svm_enums.nim.c -o c_code/2_4/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_debug.nim.c -o c_code/2_4/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_backend.nim.c -o c_code/2_4/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_internal.nim.c -o c_code/2_4/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_external.nim.c -o c_code/2_4/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_cmd.nim.c -o c_code/2_4/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports.nim.c -o c_code/2_4/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sprefixmatches.nim.c -o c_code/2_4/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@snimpaths.nim.c -o c_code/2_4/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strformat.nim.c -o c_code/2_4/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_terminal.nim.c -o c_code/2_4/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_globs.nim.c -o c_code/2_4/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@soptions.nim.c -o c_code/2_4/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sllstream.nim.c -o c_code/2_4/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@snimlexbase.nim.c -o c_code/2_4/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slexer.nim.c -o c_code/2_4/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_parsed_types.nim.c -o c_code/2_4/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@smsgs.nim.c -o c_code/2_4/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sequtils.nim.c -o c_code/2_4/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sha1.nim.c -o c_code/2_4/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_streams.nim.c -o c_code/2_4/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_lexbase.nim.c -o c_code/2_4/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parsejson.nim.c -o c_code/2_4/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_json.nim.c -o c_code/2_4/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_idgen.nim.c -o c_code/2_4/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_query.nim.c -o c_code/2_4/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast.nim.c -o c_code/2_4/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_colortext.nim.c -o c_code/2_4/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sastrepr.nim.c -o c_code/2_4/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sparser.nim.c -o c_code/2_4/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@srenderer.nim.c -o c_code/2_4/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sfilters.nim.c -o c_code/2_4/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sfilter_tmpl.nim.c -o c_code/2_4/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@ssyntaxes.nim.c -o c_code/2_4/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scondsyms.nim.c -o c_code/2_4/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_intsets.nim.c -o c_code/2_4/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_md5.nim.c -o c_code/2_4/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sastalgo.nim.c -o c_code/2_4/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@srodfiles.nim.c -o c_code/2_4/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@spacked_ast.nim.c -o c_code/2_4/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sic.nim.c -o c_code/2_4/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smodulegraphs.nim.c -o c_code/2_4/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parseopt.nim.c -o c_code/2_4/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@snimblecmd.nim.c -o c_code/2_4/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_cpuinfo.nim.c -o c_code/2_4/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_osproc.nim.c -o c_code/2_4/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_jsonutils.nim.c -o c_code/2_4/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sextccomp.nim.c -o c_code/2_4/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@soptionsprocessor.nim.c -o c_code/2_4/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@snimconf.nim.c -o c_code/2_4/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scommands.nim.c -o c_code/2_4/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sastmsgs.nim.c -o c_code/2_4/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@strees.nim.c -o c_code/2_4/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@serrorhandling.nim.c -o c_code/2_4/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@stypes.nim.c -o c_code/2_4/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@stypesrenderer.nim.c -o c_code/2_4/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scli_reporter.nim.c -o c_code/2_4/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sexp.nim.c -o c_code/2_4/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_diff.nim.c -o c_code/2_4/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sexp_diff.nim.c -o c_code/2_4/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@ssexp_reporter.nim.c -o c_code/2_4/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scmdlinehelper.nim.c -o c_code/2_4/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sdepfiles.nim.c -o c_code/2_4/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spasses.nim.c -o c_code/2_4/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@scollectors.nim.c -o c_code/2_4/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@schecked_ast.nim.c -o c_code/2_4/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sbitsets.nim.c -o c_code/2_4/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@snimsets.nim.c -o c_code/2_4/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@serrorreporting.nim.c -o c_code/2_4/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smagicsys.nim.c -o c_code/2_4/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@senumtostr.nim.c -o c_code/2_4/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slinter.nim.c -o c_code/2_4/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smodulepaths.nim.c -o c_code/2_4/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmdef.nim.c -o c_code/2_4/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemdata.nim.c -o c_code/2_4/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_editdistance.nim.c -o c_code/2_4/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@slookups.nim.c -o c_code/2_4/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@simporter.nim.c -o c_code/2_4/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemfold.nim.c -o c_code/2_4/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@stypeallowed.nim.c -o c_code/2_4/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sisolation_check.nim.c -o c_code/2_4/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sprocfind.nim.c -o c_code/2_4/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spragmas.nim.c -o c_code/2_4/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemtypinst.nim.c -o c_code/2_4/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@slowerings.nim.c -o c_code/2_4/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sparampatterns.nim.c -o c_code/2_4/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssigmatch.nim.c -o c_code/2_4/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssighashes.nim.c -o c_code/2_4/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sndi.nim.c -o c_code/2_4/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scgendata.nim.c -o c_code/2_4/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sccgutils.nim.c -o c_code/2_4/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sliftdestructors.nim.c -o c_code/2_4/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@slambdalifting.nim.c -o c_code/2_4/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sclosureiters.nim.c -o c_code/2_4/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@svarpartitions.nim.c -o c_code/2_4/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@ssaturate.nim.c -o c_code/2_4/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sguards.nim.c -o c_code/2_4/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@streetab.nim.c -o c_code/2_4/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@snilcheck.nim.c -o c_code/2_4/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssempass2.nim.c -o c_code/2_4/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scgmeth.nim.c -o c_code/2_4/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@stransf.nim.c -o c_code/2_4/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliases.nim.c -o c_code/2_4/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spatterns.nim.c -o c_code/2_4/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sevaltempl.nim.c -o c_code/2_4/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spluginsupport.nim.c -o c_code/2_4/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@slocals.nim.c -o c_code/2_4/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@sitersgen.nim.c -o c_code/2_4/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@sactive.nim.c -o c_code/2_4/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmtypegen.nim.c -o c_code/2_4/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmaux.nim.c -o c_code/2_4/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmtypes.nim.c -o c_code/2_4/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmmemory.nim.c -o c_code/2_4/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmobjects.nim.c -o c_code/2_4/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmcompilerserdes.nim.c -o c_code/2_4/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirtrees.nim.c -o c_code/2_4/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sastgen.nim.c -o c_code/2_4/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirgen.nim.c -o c_code/2_4/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sutils.nim.c -o c_code/2_4/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliasanalysis.nim.c -o c_code/2_4/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@smirexec.nim.c -o c_code/2_4/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sanalysis.nim.c -o c_code/2_4/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirchangesets.nim.c -o c_code/2_4/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sinjectdestructors.nim.c -o c_code/2_4/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirbridge.nim.c -o c_code/2_4/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmgen.nim.c -o c_code/2_4/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmjit.nim.c -o c_code/2_4/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmlegacy.nim.c -o c_code/2_4/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@sgorgeimpl.nim.c -o c_code/2_4/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmerrors.nim.c -o c_code/2_4/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmdeps.nim.c -o c_code/2_4/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmhooks.nim.c -o c_code/2_4/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmops.nim.c -o c_code/2_4/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@smacrocacheimpl.nim.c -o c_code/2_4/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmprofiler.nim.c -o c_code/2_4/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmchecks.nim.c -o c_code/2_4/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svm.nim.c -o c_code/2_4/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@scompilerbridge.nim.c -o c_code/2_4/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mtools@ssuggest.nim.c -o c_code/2_4/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssem.nim.c -o c_code/2_4/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spassaux.nim.c -o c_code/2_4/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@sdepends.nim.c -o c_code/2_4/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sreplayer.nim.c -o c_code/2_4/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smodules.nim.c -o c_code/2_4/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dynlib.nim.c -o c_code/2_4/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sdfa.nim.c -o c_code/2_4/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scgen.nim.c -o c_code/2_4/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@spacked_env.nim.c -o c_code/2_4/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmbackend.nim.c -o c_code/2_4/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sdce.nim.c -o c_code/2_4/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@scbackend.nim.c -o c_code/2_4/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sintegrity.nim.c -o c_code/2_4/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scbackend.nim.c -o c_code/2_4/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sscripting.nim.c -o c_code/2_4/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sjsgen.nim.c -o c_code/2_4/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssourcemap.nim.c -o c_code/2_4/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sjsbackend.nim.c -o c_code/2_4/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_xmltree.nim.c -o c_code/2_4/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@srenderverbatim.nim.c -o c_code/2_4/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_rstast.nim.c -o c_code/2_4/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_highlite.nim.c -o c_code/2_4/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_rst.nim.c -o c_code/2_4/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_rstgen.nim.c -o c_code/2_4/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_base64.nim.c -o c_code/2_4/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_uri.nim.c -o c_code/2_4/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mtools@sdocgen.nim.c -o c_code/2_4/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mtools@sdocgen2.nim.c -o c_code/2_4/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@smain.nim.c -o c_code/2_4/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_browsers.nim.c -o c_code/2_4/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mnim.nim.c -o c_code/2_4/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/2_4/stdlib_digitsutils.nim.o \
c_code/2_4/stdlib_assertions.nim.o \
c_code/2_4/stdlib_dragonbox.nim.o \
c_code/2_4/stdlib_schubfach.nim.o \
c_code/2_4/stdlib_formatfloat.nim.o \
c_code/2_4/stdlib_dollars.nim.o \
c_code/2_4/stdlib_io.nim.o \
c_code/2_4/stdlib_system.nim.o \
c_code/2_4/stdlib_parseutils.nim.o \
c_code/2_4/stdlib_math.nim.o \
c_code/2_4/stdlib_enumutils.nim.o \
c_code/2_4/stdlib_unicode.nim.o \
c_code/2_4/stdlib_strutils.nim.o \
c_code/2_4/stdlib_pathnorm.nim.o \
c_code/2_4/stdlib_options.nim.o \
c_code/2_4/stdlib_times.nim.o \
c_code/2_4/stdlib_os.nim.o \
c_code/2_4/stdlib_hashes.nim.o \
c_code/2_4/@mutils@spathutils.nim.o \
c_code/2_4/@mutils@sropes.nim.o \
c_code/2_4/@mutils@sidioms.nim.o \
c_code/2_4/@mast@sreport_enums.nim.o \
c_code/2_4/@mast@slineinfos.nim.o \
c_code/2_4/@mast@swordrecg.nim.o \
c_code/2_4/@mast@sidents.nim.o \
c_code/2_4/@mutils@splatform.nim.o \
c_code/2_4/stdlib_strtabs.nim.o \
c_code/2_4/@mfront@sin_options.nim.o \
c_code/2_4/@mutils@sint128.nim.o \
c_code/2_4/@mast@sast_types.nim.o \
c_code/2_4/@mast@sreports_lexer.nim.o \
c_code/2_4/@mast@sreports_parser.nim.o \
c_code/2_4/@mast@sreports_base_sem.nim.o \
c_code/2_4/@msem@snilcheck_enums.nim.o \
c_code/2_4/@mast@sreports_sem.nim.o \
c_code/2_4/@mast@sreports_vm.nim.o \
c_code/2_4/@mvm@svm_enums.nim.o \
c_code/2_4/@mast@sreports_debug.nim.o \
c_code/2_4/@mast@sreports_backend.nim.o \
c_code/2_4/@mast@sreports_internal.nim.o \
c_code/2_4/@mast@sreports_external.nim.o \
c_code/2_4/@mast@sreports_cmd.nim.o \
c_code/2_4/@mast@sreports.nim.o \
c_code/2_4/@mutils@sprefixmatches.nim.o \
c_code/2_4/@mmodules@snimpaths.nim.o \
c_code/2_4/stdlib_strformat.nim.o \
c_code/2_4/stdlib_terminal.nim.o \
c_code/2_4/stdlib_globs.nim.o \
c_code/2_4/@mfront@soptions.nim.o \
c_code/2_4/@mast@sllstream.nim.o \
c_code/2_4/@mast@snimlexbase.nim.o \
c_code/2_4/@mast@slexer.nim.o \
c_code/2_4/@mast@sast_parsed_types.nim.o \
c_code/2_4/@mfront@smsgs.nim.o \
c_code/2_4/stdlib_sequtils.nim.o \
c_code/2_4/stdlib_sha1.nim.o \
c_code/2_4/stdlib_streams.nim.o \
c_code/2_4/stdlib_lexbase.nim.o \
c_code/2_4/stdlib_parsejson.nim.o \
c_code/2_4/stdlib_json.nim.o \
c_code/2_4/@mast@sast_idgen.nim.o \
c_code/2_4/@mast@sast_query.nim.o \
c_code/2_4/@mast@sast.nim.o \
c_code/2_4/stdlib_colortext.nim.o \
c_code/2_4/@mutils@sastrepr.nim.o \
c_code/2_4/@mast@sparser.nim.o \
c_code/2_4/@mast@srenderer.nim.o \
c_code/2_4/@mast@sfilters.nim.o \
c_code/2_4/@mast@sfilter_tmpl.nim.o \
c_code/2_4/@mast@ssyntaxes.nim.o \
c_code/2_4/@mfront@scondsyms.nim.o \
c_code/2_4/stdlib_intsets.nim.o \
c_code/2_4/stdlib_md5.nim.o \
c_code/2_4/@mast@sastalgo.nim.o \
c_code/2_4/@mic@srodfiles.nim.o \
c_code/2_4/@mic@spacked_ast.nim.o \
c_code/2_4/@mic@sic.nim.o \
c_code/2_4/@mmodules@smodulegraphs.nim.o \
c_code/2_4/stdlib_parseopt.nim.o \
c_code/2_4/@mmodules@snimblecmd.nim.o \
c_code/2_4/stdlib_cpuinfo.nim.o \
c_code/2_4/stdlib_osproc.nim.o \
c_code/2_4/stdlib_jsonutils.nim.o \
c_code/2_4/@mbackend@sextccomp.nim.o \
c_code/2_4/@mfront@soptionsprocessor.nim.o \
c_code/2_4/@mfront@snimconf.nim.o \
c_code/2_4/@mfront@scommands.nim.o \
c_code/2_4/@mast@sastmsgs.nim.o \
c_code/2_4/@mast@strees.nim.o \
c_code/2_4/@mast@serrorhandling.nim.o \
c_code/2_4/@mast@stypes.nim.o \
c_code/2_4/@mast@stypesrenderer.nim.o \
c_code/2_4/@mfront@scli_reporter.nim.o \
c_code/2_4/stdlib_sexp.nim.o \
c_code/2_4/stdlib_diff.nim.o \
c_code/2_4/stdlib_sexp_diff.nim.o \
c_code/2_4/@mfront@ssexp_reporter.nim.o \
c_code/2_4/@mfront@scmdlinehelper.nim.o \
c_code/2_4/@mfront@sdepfiles.nim.o \
c_code/2_4/@msem@spasses.nim.o \
c_code/2_4/@msem@scollectors.nim.o \
c_code/2_4/@mast@schecked_ast.nim.o \
c_code/2_4/@mutils@sbitsets.nim.o \
c_code/2_4/@mast@snimsets.nim.o \
c_code/2_4/@mast@serrorreporting.nim.o \
c_code/2_4/@mmodules@smagicsys.nim.o \
c_code/2_4/@mast@senumtostr.nim.o \
c_code/2_4/@mast@slinter.nim.o \
c_code/2_4/@mmodules@smodulepaths.nim.o \
c_code/2_4/@mvm@svmdef.nim.o \
c_code/2_4/@msem@ssemdata.nim.o \
c_code/2_4/stdlib_editdistance.nim.o \
c_code/2_4/@msem@slookups.nim.o \
c_code/2_4/@mmodules@simporter.nim.o \
c_code/2_4/@msem@ssemfold.nim.o \
c_code/2_4/@msem@stypeallowed.nim.o \
c_code/2_4/@msem@sisolation_check.nim.o \
c_code/2_4/@msem@sprocfind.nim.o \
c_code/2_4/@msem@spragmas.nim.o \
c_code/2_4/@msem@ssemtypinst.nim.o \
c_code/2_4/@msem@slowerings.nim.o \
c_code/2_4/@msem@sparampatterns.nim.o \
c_code/2_4/@msem@ssigmatch.nim.o \
c_code/2_4/@msem@ssighashes.nim.o \
c_code/2_4/@mast@sndi.nim.o \
c_code/2_4/@mbackend@scgendata.nim.o \
c_code/2_4/@mbackend@sccgutils.nim.o \
c_code/2_4/@msem@sliftdestructors.nim.o \
c_code/2_4/@msem@slambdalifting.nim.o \
c_code/2_4/@msem@sclosureiters.nim.o \
c_code/2_4/@msem@svarpartitions.nim.o \
c_code/2_4/@mutils@ssaturate.nim.o \
c_code/2_4/@msem@sguards.nim.o \
c_code/2_4/@mast@streetab.nim.o \
c_code/2_4/@msem@snilcheck.nim.o \
c_code/2_4/@msem@ssempass2.nim.o \
c_code/2_4/@mbackend@scgmeth.nim.o \
c_code/2_4/@msem@stransf.nim.o \
c_code/2_4/@msem@saliases.nim.o \
c_code/2_4/@msem@spatterns.nim.o \
c_code/2_4/@msem@sevaltempl.nim.o \
c_code/2_4/@mutils@spluginsupport.nim.o \
c_code/2_4/@mplugins@slocals.nim.o \
c_code/2_4/@mplugins@sitersgen.nim.o \
c_code/2_4/@mplugins@sactive.nim.o \
c_code/2_4/@mvm@svmtypegen.nim.o \
c_code/2_4/@mvm@svmaux.nim.o \
c_code/2_4/@mvm@svmtypes.nim.o \
c_code/2_4/@mvm@svmmemory.nim.o \
c_code/2_4/@mvm@svmobjects.nim.o \
c_code/2_4/@mvm@svmcompilerserdes.nim.o \
c_code/2_4/@mmir@smirtrees.nim.o \
c_code/2_4/@mmir@sastgen.nim.o \
c_code/2_4/@mmir@smirgen.nim.o \
c_code/2_4/@mmir@sutils.nim.o \
c_code/2_4/@msem@saliasanalysis.nim.o \
c_code/2_4/@msem@smirexec.nim.o \
c_code/2_4/@mmir@sanalysis.nim.o \
c_code/2_4/@mmir@smirchangesets.nim.o \
c_code/2_4/@msem@sinjectdestructors.nim.o \
c_code/2_4/@mmir@smirbridge.nim.o \
c_code/2_4/@mvm@svmgen.nim.o \
c_code/2_4/@mvm@svmjit.nim.o \
c_code/2_4/@mvm@svmlegacy.nim.o \
c_code/2_4/@mvm@sgorgeimpl.nim.o \
c_code/2_4/@mvm@svmerrors.nim.o \
c_code/2_4/@mvm@svmdeps.nim.o \
c_code/2_4/@mvm@svmhooks.nim.o \
c_code/2_4/@mvm@svmops.nim.o \
c_code/2_4/@msem@smacrocacheimpl.nim.o \
c_code/2_4/@mvm@svmprofiler.nim.o \
c_code/2_4/@mvm@svmchecks.nim.o \
c_code/2_4/@mvm@svm.nim.o \
c_code/2_4/@mvm@scompilerbridge.nim.o \
c_code/2_4/@mtools@ssuggest.nim.o \
c_code/2_4/@msem@ssem.nim.o \
c_code/2_4/@msem@spassaux.nim.o \
c_code/2_4/@mmodules@sdepends.nim.o \
c_code/2_4/@mic@sreplayer.nim.o \
c_code/2_4/@mmodules@smodules.nim.o \
c_code/2_4/stdlib_dynlib.nim.o \
c_code/2_4/@msem@sdfa.nim.o \
c_code/2_4/@mbackend@scgen.nim.o \
c_code/2_4/@mvm@spacked_env.nim.o \
c_code/2_4/@mvm@svmbackend.nim.o \
c_code/2_4/@mic@sdce.nim.o \
c_code/2_4/@mic@scbackend.nim.o \
c_code/2_4/@mic@sintegrity.nim.o \
c_code/2_4/@mbackend@scbackend.nim.o \
c_code/2_4/@mfront@sscripting.nim.o \
c_code/2_4/@mbackend@sjsgen.nim.o \
c_code/2_4/@msem@ssourcemap.nim.o \
c_code/2_4/@mbackend@sjsbackend.nim.o \
c_code/2_4/stdlib_xmltree.nim.o \
c_code/2_4/@mast@srenderverbatim.nim.o \
c_code/2_4/stdlib_rstast.nim.o \
c_code/2_4/stdlib_highlite.nim.o \
c_code/2_4/stdlib_rst.nim.o \
c_code/2_4/stdlib_rstgen.nim.o \
c_code/2_4/stdlib_base64.nim.o \
c_code/2_4/stdlib_uri.nim.o \
c_code/2_4/@mtools@sdocgen.nim.o \
c_code/2_4/@mtools@sdocgen2.nim.o \
c_code/2_4/@mfront@smain.nim.o \
c_code/2_4/stdlib_browsers.nim.o \
c_code/2_4/@mnim.nim.o $LINK_FLAGS
    ;;
  *)
    echo 2>&1 "Error: no C code generated for: [$myos: $mycpu]"
    exit 1
    ;;
  esac
  ;;
macosx)
  case $mycpu in
  i386)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  amd64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_digitsutils.nim.c -o c_code/1_2/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_assertions.nim.c -o c_code/2_2/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dragonbox.nim.c -o c_code/1_2/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_schubfach.nim.c -o c_code/1_2/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_formatfloat.nim.c -o c_code/1_2/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_dollars.nim.c -o c_code/1_2/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_io.nim.c -o c_code/3_2/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_system.nim.c -o c_code/3_2/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_parseutils.nim.c -o c_code/2_2/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_math.nim.c -o c_code/2_2/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_enumutils.nim.c -o c_code/1_2/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_unicode.nim.c -o c_code/2_2/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_strutils.nim.c -o c_code/3_2/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_pathnorm.nim.c -o c_code/2_2/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_posix.nim.c -o c_code/3_2/stdlib_posix.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_options.nim.c -o c_code/3_2/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_times.nim.c -o c_code/3_2/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_os.nim.c -o c_code/3_2/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_hashes.nim.c -o c_code/1_2/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@spathutils.nim.c -o c_code/2_2/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mutils@sropes.nim.c -o c_code/3_2/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sidioms.nim.c -o c_code/2_2/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreport_enums.nim.c -o c_code/1_2/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@slineinfos.nim.c -o c_code/2_2/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@swordrecg.nim.c -o c_code/1_2/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sidents.nim.c -o c_code/2_2/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mutils@splatform.nim.c -o c_code/3_2/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_strtabs.nim.c -o c_code/2_2/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mfront@sin_options.nim.c -o c_code/1_2/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@sint128.nim.c -o c_code/2_2/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_types.nim.c -o c_code/2_2/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_lexer.nim.c -o c_code/1_2/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_parser.nim.c -o c_code/1_2/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_base_sem.nim.c -o c_code/1_2/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@snilcheck_enums.nim.c -o c_code/1_2/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sreports_sem.nim.c -o c_code/2_2/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_vm.nim.c -o c_code/1_2/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svm_enums.nim.c -o c_code/1_2/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_debug.nim.c -o c_code/1_2/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_backend.nim.c -o c_code/1_2/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_internal.nim.c -o c_code/1_2/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_external.nim.c -o c_code/1_2/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sreports_cmd.nim.c -o c_code/1_2/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sreports.nim.c -o c_code/2_2/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sprefixmatches.nim.c -o c_code/1_2/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@snimpaths.nim.c -o c_code/3_2/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@sstrutils2.nim.c -o c_code/1_2/@mutils@sstrutils2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_strformat.nim.c -o c_code/2_2/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_terminal.nim.c -o c_code/3_2/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_globs.nim.c -o c_code/2_2/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@soptions.nim.c -o c_code/3_2/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@sllstream.nim.c -o c_code/3_2/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@snimlexbase.nim.c -o c_code/2_2/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@slexer.nim.c -o c_code/3_2/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_parsed_types.nim.c -o c_code/2_2/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@smsgs.nim.c -o c_code/3_2/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_sequtils.nim.c -o c_code/1_2/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_sha1.nim.c -o c_code/3_2/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_streams.nim.c -o c_code/3_2/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_lexbase.nim.c -o c_code/2_2/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_parsejson.nim.c -o c_code/2_2/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_json.nim.c -o c_code/3_2/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sast_idgen.nim.c -o c_code/1_2/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast_query.nim.c -o c_code/2_2/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sast.nim.c -o c_code/2_2/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_colortext.nim.c -o c_code/2_2/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mutils@sastrepr.nim.c -o c_code/3_2/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@sparser.nim.c -o c_code/3_2/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@srenderer.nim.c -o c_code/3_2/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@sfilters.nim.c -o c_code/2_2/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@sfilter_tmpl.nim.c -o c_code/3_2/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@ssyntaxes.nim.c -o c_code/3_2/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mfront@scondsyms.nim.c -o c_code/2_2/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_intsets.nim.c -o c_code/1_2/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_md5.nim.c -o c_code/1_2/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@sastalgo.nim.c -o c_code/1_2/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mic@srodfiles.nim.c -o c_code/3_2/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mic@spacked_ast.nim.c -o c_code/1_2/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mic@sic.nim.c -o c_code/3_2/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@smodulegraphs.nim.c -o c_code/3_2/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_parseopt.nim.c -o c_code/3_2/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@snimblecmd.nim.c -o c_code/3_2/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_cpuinfo.nim.c -o c_code/3_2/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_osproc.nim.c -o c_code/3_2/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_jsonutils.nim.c -o c_code/2_2/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@sextccomp.nim.c -o c_code/3_2/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@soptionsprocessor.nim.c -o c_code/3_2/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@snimconf.nim.c -o c_code/3_2/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@scommands.nim.c -o c_code/3_2/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@sastmsgs.nim.c -o c_code/3_2/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@strees.nim.c -o c_code/2_2/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@serrorhandling.nim.c -o c_code/3_2/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@stypes.nim.c -o c_code/3_2/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@stypesrenderer.nim.c -o c_code/2_2/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@scli_reporter.nim.c -o c_code/3_2/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_sexp.nim.c -o c_code/2_2/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_diff.nim.c -o c_code/2_2/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_sexp_diff.nim.c -o c_code/3_2/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@ssexp_reporter.nim.c -o c_code/3_2/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@scmdlinehelper.nim.c -o c_code/3_2/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@sdepfiles.nim.c -o c_code/3_2/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@spasses.nim.c -o c_code/3_2/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@scollectors.nim.c -o c_code/2_2/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@schecked_ast.nim.c -o c_code/1_2/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mutils@sbitsets.nim.c -o c_code/3_2/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@snimsets.nim.c -o c_code/3_2/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@serrorreporting.nim.c -o c_code/1_2/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@smagicsys.nim.c -o c_code/3_2/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mast@senumtostr.nim.c -o c_code/2_2/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@slinter.nim.c -o c_code/3_2/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@smodulepaths.nim.c -o c_code/3_2/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmdef.nim.c -o c_code/3_2/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssemdata.nim.c -o c_code/3_2/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_editdistance.nim.c -o c_code/2_2/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@slookups.nim.c -o c_code/3_2/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@simporter.nim.c -o c_code/3_2/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssemfold.nim.c -o c_code/3_2/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@stypeallowed.nim.c -o c_code/1_2/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sisolation_check.nim.c -o c_code/1_2/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sprocfind.nim.c -o c_code/1_2/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@spragmas.nim.c -o c_code/3_2/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@ssemtypinst.nim.c -o c_code/2_2/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@slowerings.nim.c -o c_code/3_2/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@sparampatterns.nim.c -o c_code/2_2/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssigmatch.nim.c -o c_code/3_2/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssighashes.nim.c -o c_code/3_2/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@sndi.nim.c -o c_code/3_2/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@scgendata.nim.c -o c_code/3_2/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@sccgutils.nim.c -o c_code/3_2/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@sliftdestructors.nim.c -o c_code/3_2/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@slambdalifting.nim.c -o c_code/3_2/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@sclosureiters.nim.c -o c_code/3_2/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@svarpartitions.nim.c -o c_code/2_2/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mutils@ssaturate.nim.c -o c_code/2_2/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sguards.nim.c -o c_code/1_2/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mast@streetab.nim.c -o c_code/1_2/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@snilcheck.nim.c -o c_code/3_2/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssempass2.nim.c -o c_code/3_2/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@scgmeth.nim.c -o c_code/3_2/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@stransf.nim.c -o c_code/3_2/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliases.nim.c -o c_code/1_2/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@msem@spatterns.nim.c -o c_code/2_2/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@sevaltempl.nim.c -o c_code/3_2/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mutils@spluginsupport.nim.c -o c_code/1_2/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@slocals.nim.c -o c_code/1_2/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@sitersgen.nim.c -o c_code/1_2/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mplugins@sactive.nim.c -o c_code/1_2/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmtypegen.nim.c -o c_code/3_2/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmaux.nim.c -o c_code/3_2/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmtypes.nim.c -o c_code/2_2/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmmemory.nim.c -o c_code/3_2/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmobjects.nim.c -o c_code/2_2/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmcompilerserdes.nim.c -o c_code/3_2/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@smirtrees.nim.c -o c_code/2_2/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sastgen.nim.c -o c_code/2_2/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@smirgen.nim.c -o c_code/2_2/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sutils.nim.c -o c_code/2_2/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@saliasanalysis.nim.c -o c_code/1_2/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@smirexec.nim.c -o c_code/3_2/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mmir@sanalysis.nim.c -o c_code/2_2/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mmir@smirchangesets.nim.c -o c_code/1_2/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@sinjectdestructors.nim.c -o c_code/3_2/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmir@smirbridge.nim.c -o c_code/3_2/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmgen.nim.c -o c_code/3_2/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmjit.nim.c -o c_code/3_2/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@mvm@svmlegacy.nim.c -o c_code/1_2/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@sgorgeimpl.nim.c -o c_code/3_2/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmerrors.nim.c -o c_code/2_2/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmdeps.nim.c -o c_code/3_2/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmhooks.nim.c -o c_code/2_2/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmops.nim.c -o c_code/3_2/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@smacrocacheimpl.nim.c -o c_code/1_2/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmprofiler.nim.c -o c_code/3_2/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@svmchecks.nim.c -o c_code/2_2/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svm.nim.c -o c_code/3_2/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@scompilerbridge.nim.c -o c_code/3_2/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mtools@ssuggest.nim.c -o c_code/3_2/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssem.nim.c -o c_code/3_2/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@spassaux.nim.c -o c_code/1_2/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@sdepends.nim.c -o c_code/3_2/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mic@sreplayer.nim.c -o c_code/3_2/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mmodules@smodules.nim.c -o c_code/3_2/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_dynlib.nim.c -o c_code/2_2/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/@msem@sdfa.nim.c -o c_code/1_2/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@scgen.nim.c -o c_code/3_2/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mvm@spacked_env.nim.c -o c_code/2_2/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mvm@svmbackend.nim.c -o c_code/3_2/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mic@sdce.nim.c -o c_code/3_2/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mic@scbackend.nim.c -o c_code/3_2/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/@mic@sintegrity.nim.c -o c_code/2_2/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@scbackend.nim.c -o c_code/3_2/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@sscripting.nim.c -o c_code/3_2/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@sjsgen.nim.c -o c_code/3_2/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@msem@ssourcemap.nim.c -o c_code/3_2/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mbackend@sjsbackend.nim.c -o c_code/3_2/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_xmltree.nim.c -o c_code/1_2/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mast@srenderverbatim.nim.c -o c_code/3_2/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_rstast.nim.c -o c_code/2_2/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_highlite.nim.c -o c_code/2_2/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_rst.nim.c -o c_code/3_2/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_rstgen.nim.c -o c_code/3_2/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/1_2/stdlib_base64.nim.c -o c_code/1_2/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_2/stdlib_uri.nim.c -o c_code/2_2/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mtools@sdocgen.nim.c -o c_code/3_2/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mtools@sdocgen2.nim.c -o c_code/3_2/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mfront@smain.nim.c -o c_code/3_2/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/stdlib_browsers.nim.c -o c_code/3_2/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_2/@mnim.nim.c -o c_code/3_2/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/1_2/stdlib_digitsutils.nim.o \
c_code/2_2/stdlib_assertions.nim.o \
c_code/1_2/stdlib_dragonbox.nim.o \
c_code/1_2/stdlib_schubfach.nim.o \
c_code/1_2/stdlib_formatfloat.nim.o \
c_code/1_2/stdlib_dollars.nim.o \
c_code/3_2/stdlib_io.nim.o \
c_code/3_2/stdlib_system.nim.o \
c_code/2_2/stdlib_parseutils.nim.o \
c_code/2_2/stdlib_math.nim.o \
c_code/1_2/stdlib_enumutils.nim.o \
c_code/2_2/stdlib_unicode.nim.o \
c_code/3_2/stdlib_strutils.nim.o \
c_code/2_2/stdlib_pathnorm.nim.o \
c_code/3_2/stdlib_posix.nim.o \
c_code/3_2/stdlib_options.nim.o \
c_code/3_2/stdlib_times.nim.o \
c_code/3_2/stdlib_os.nim.o \
c_code/1_2/stdlib_hashes.nim.o \
c_code/2_2/@mutils@spathutils.nim.o \
c_code/3_2/@mutils@sropes.nim.o \
c_code/2_2/@mutils@sidioms.nim.o \
c_code/1_2/@mast@sreport_enums.nim.o \
c_code/2_2/@mast@slineinfos.nim.o \
c_code/1_2/@mast@swordrecg.nim.o \
c_code/2_2/@mast@sidents.nim.o \
c_code/3_2/@mutils@splatform.nim.o \
c_code/2_2/stdlib_strtabs.nim.o \
c_code/1_2/@mfront@sin_options.nim.o \
c_code/2_2/@mutils@sint128.nim.o \
c_code/2_2/@mast@sast_types.nim.o \
c_code/1_2/@mast@sreports_lexer.nim.o \
c_code/1_2/@mast@sreports_parser.nim.o \
c_code/1_2/@mast@sreports_base_sem.nim.o \
c_code/1_2/@msem@snilcheck_enums.nim.o \
c_code/2_2/@mast@sreports_sem.nim.o \
c_code/1_2/@mast@sreports_vm.nim.o \
c_code/1_2/@mvm@svm_enums.nim.o \
c_code/1_2/@mast@sreports_debug.nim.o \
c_code/1_2/@mast@sreports_backend.nim.o \
c_code/1_2/@mast@sreports_internal.nim.o \
c_code/1_2/@mast@sreports_external.nim.o \
c_code/1_2/@mast@sreports_cmd.nim.o \
c_code/2_2/@mast@sreports.nim.o \
c_code/1_2/@mutils@sprefixmatches.nim.o \
c_code/3_2/@mmodules@snimpaths.nim.o \
c_code/1_2/@mutils@sstrutils2.nim.o \
c_code/2_2/stdlib_strformat.nim.o \
c_code/3_2/stdlib_terminal.nim.o \
c_code/2_2/stdlib_globs.nim.o \
c_code/3_2/@mfront@soptions.nim.o \
c_code/3_2/@mast@sllstream.nim.o \
c_code/2_2/@mast@snimlexbase.nim.o \
c_code/3_2/@mast@slexer.nim.o \
c_code/2_2/@mast@sast_parsed_types.nim.o \
c_code/3_2/@mfront@smsgs.nim.o \
c_code/1_2/stdlib_sequtils.nim.o \
c_code/3_2/stdlib_sha1.nim.o \
c_code/3_2/stdlib_streams.nim.o \
c_code/2_2/stdlib_lexbase.nim.o \
c_code/2_2/stdlib_parsejson.nim.o \
c_code/3_2/stdlib_json.nim.o \
c_code/1_2/@mast@sast_idgen.nim.o \
c_code/2_2/@mast@sast_query.nim.o \
c_code/2_2/@mast@sast.nim.o \
c_code/2_2/stdlib_colortext.nim.o \
c_code/3_2/@mutils@sastrepr.nim.o \
c_code/3_2/@mast@sparser.nim.o \
c_code/3_2/@mast@srenderer.nim.o \
c_code/2_2/@mast@sfilters.nim.o \
c_code/3_2/@mast@sfilter_tmpl.nim.o \
c_code/3_2/@mast@ssyntaxes.nim.o \
c_code/2_2/@mfront@scondsyms.nim.o \
c_code/1_2/stdlib_intsets.nim.o \
c_code/1_2/stdlib_md5.nim.o \
c_code/1_2/@mast@sastalgo.nim.o \
c_code/3_2/@mic@srodfiles.nim.o \
c_code/1_2/@mic@spacked_ast.nim.o \
c_code/3_2/@mic@sic.nim.o \
c_code/3_2/@mmodules@smodulegraphs.nim.o \
c_code/3_2/stdlib_parseopt.nim.o \
c_code/3_2/@mmodules@snimblecmd.nim.o \
c_code/3_2/stdlib_cpuinfo.nim.o \
c_code/3_2/stdlib_osproc.nim.o \
c_code/2_2/stdlib_jsonutils.nim.o \
c_code/3_2/@mbackend@sextccomp.nim.o \
c_code/3_2/@mfront@soptionsprocessor.nim.o \
c_code/3_2/@mfront@snimconf.nim.o \
c_code/3_2/@mfront@scommands.nim.o \
c_code/3_2/@mast@sastmsgs.nim.o \
c_code/2_2/@mast@strees.nim.o \
c_code/3_2/@mast@serrorhandling.nim.o \
c_code/3_2/@mast@stypes.nim.o \
c_code/2_2/@mast@stypesrenderer.nim.o \
c_code/3_2/@mfront@scli_reporter.nim.o \
c_code/2_2/stdlib_sexp.nim.o \
c_code/2_2/stdlib_diff.nim.o \
c_code/3_2/stdlib_sexp_diff.nim.o \
c_code/3_2/@mfront@ssexp_reporter.nim.o \
c_code/3_2/@mfront@scmdlinehelper.nim.o \
c_code/3_2/@mfront@sdepfiles.nim.o \
c_code/3_2/@msem@spasses.nim.o \
c_code/2_2/@msem@scollectors.nim.o \
c_code/1_2/@mast@schecked_ast.nim.o \
c_code/3_2/@mutils@sbitsets.nim.o \
c_code/3_2/@mast@snimsets.nim.o \
c_code/1_2/@mast@serrorreporting.nim.o \
c_code/3_2/@mmodules@smagicsys.nim.o \
c_code/2_2/@mast@senumtostr.nim.o \
c_code/3_2/@mast@slinter.nim.o \
c_code/3_2/@mmodules@smodulepaths.nim.o \
c_code/3_2/@mvm@svmdef.nim.o \
c_code/3_2/@msem@ssemdata.nim.o \
c_code/2_2/stdlib_editdistance.nim.o \
c_code/3_2/@msem@slookups.nim.o \
c_code/3_2/@mmodules@simporter.nim.o \
c_code/3_2/@msem@ssemfold.nim.o \
c_code/1_2/@msem@stypeallowed.nim.o \
c_code/1_2/@msem@sisolation_check.nim.o \
c_code/1_2/@msem@sprocfind.nim.o \
c_code/3_2/@msem@spragmas.nim.o \
c_code/2_2/@msem@ssemtypinst.nim.o \
c_code/3_2/@msem@slowerings.nim.o \
c_code/2_2/@msem@sparampatterns.nim.o \
c_code/3_2/@msem@ssigmatch.nim.o \
c_code/3_2/@msem@ssighashes.nim.o \
c_code/3_2/@mast@sndi.nim.o \
c_code/3_2/@mbackend@scgendata.nim.o \
c_code/3_2/@mbackend@sccgutils.nim.o \
c_code/3_2/@msem@sliftdestructors.nim.o \
c_code/3_2/@msem@slambdalifting.nim.o \
c_code/3_2/@msem@sclosureiters.nim.o \
c_code/2_2/@msem@svarpartitions.nim.o \
c_code/2_2/@mutils@ssaturate.nim.o \
c_code/1_2/@msem@sguards.nim.o \
c_code/1_2/@mast@streetab.nim.o \
c_code/3_2/@msem@snilcheck.nim.o \
c_code/3_2/@msem@ssempass2.nim.o \
c_code/3_2/@mbackend@scgmeth.nim.o \
c_code/3_2/@msem@stransf.nim.o \
c_code/1_2/@msem@saliases.nim.o \
c_code/2_2/@msem@spatterns.nim.o \
c_code/3_2/@msem@sevaltempl.nim.o \
c_code/1_2/@mutils@spluginsupport.nim.o \
c_code/1_2/@mplugins@slocals.nim.o \
c_code/1_2/@mplugins@sitersgen.nim.o \
c_code/1_2/@mplugins@sactive.nim.o \
c_code/3_2/@mvm@svmtypegen.nim.o \
c_code/3_2/@mvm@svmaux.nim.o \
c_code/2_2/@mvm@svmtypes.nim.o \
c_code/3_2/@mvm@svmmemory.nim.o \
c_code/2_2/@mvm@svmobjects.nim.o \
c_code/3_2/@mvm@svmcompilerserdes.nim.o \
c_code/2_2/@mmir@smirtrees.nim.o \
c_code/2_2/@mmir@sastgen.nim.o \
c_code/2_2/@mmir@smirgen.nim.o \
c_code/2_2/@mmir@sutils.nim.o \
c_code/1_2/@msem@saliasanalysis.nim.o \
c_code/3_2/@msem@smirexec.nim.o \
c_code/2_2/@mmir@sanalysis.nim.o \
c_code/1_2/@mmir@smirchangesets.nim.o \
c_code/3_2/@msem@sinjectdestructors.nim.o \
c_code/3_2/@mmir@smirbridge.nim.o \
c_code/3_2/@mvm@svmgen.nim.o \
c_code/3_2/@mvm@svmjit.nim.o \
c_code/1_2/@mvm@svmlegacy.nim.o \
c_code/3_2/@mvm@sgorgeimpl.nim.o \
c_code/2_2/@mvm@svmerrors.nim.o \
c_code/3_2/@mvm@svmdeps.nim.o \
c_code/2_2/@mvm@svmhooks.nim.o \
c_code/3_2/@mvm@svmops.nim.o \
c_code/1_2/@msem@smacrocacheimpl.nim.o \
c_code/3_2/@mvm@svmprofiler.nim.o \
c_code/2_2/@mvm@svmchecks.nim.o \
c_code/3_2/@mvm@svm.nim.o \
c_code/3_2/@mvm@scompilerbridge.nim.o \
c_code/3_2/@mtools@ssuggest.nim.o \
c_code/3_2/@msem@ssem.nim.o \
c_code/1_2/@msem@spassaux.nim.o \
c_code/3_2/@mmodules@sdepends.nim.o \
c_code/3_2/@mic@sreplayer.nim.o \
c_code/3_2/@mmodules@smodules.nim.o \
c_code/2_2/stdlib_dynlib.nim.o \
c_code/1_2/@msem@sdfa.nim.o \
c_code/3_2/@mbackend@scgen.nim.o \
c_code/2_2/@mvm@spacked_env.nim.o \
c_code/3_2/@mvm@svmbackend.nim.o \
c_code/3_2/@mic@sdce.nim.o \
c_code/3_2/@mic@scbackend.nim.o \
c_code/2_2/@mic@sintegrity.nim.o \
c_code/3_2/@mbackend@scbackend.nim.o \
c_code/3_2/@mfront@sscripting.nim.o \
c_code/3_2/@mbackend@sjsgen.nim.o \
c_code/3_2/@msem@ssourcemap.nim.o \
c_code/3_2/@mbackend@sjsbackend.nim.o \
c_code/1_2/stdlib_xmltree.nim.o \
c_code/3_2/@mast@srenderverbatim.nim.o \
c_code/2_2/stdlib_rstast.nim.o \
c_code/2_2/stdlib_highlite.nim.o \
c_code/3_2/stdlib_rst.nim.o \
c_code/3_2/stdlib_rstgen.nim.o \
c_code/1_2/stdlib_base64.nim.o \
c_code/2_2/stdlib_uri.nim.o \
c_code/3_2/@mtools@sdocgen.nim.o \
c_code/3_2/@mtools@sdocgen2.nim.o \
c_code/3_2/@mfront@smain.nim.o \
c_code/3_2/stdlib_browsers.nim.o \
c_code/3_2/@mnim.nim.o $LINK_FLAGS
    ;;
  arm)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  arm64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_digitsutils.nim.c -o c_code/2_4/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_assertions.nim.c -o c_code/2_4/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dragonbox.nim.c -o c_code/2_4/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_schubfach.nim.c -o c_code/2_4/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_formatfloat.nim.c -o c_code/2_4/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dollars.nim.c -o c_code/2_4/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_io.nim.c -o c_code/3_4/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_system.nim.c -o c_code/3_4/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parseutils.nim.c -o c_code/2_4/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_math.nim.c -o c_code/2_4/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_enumutils.nim.c -o c_code/2_4/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_unicode.nim.c -o c_code/2_4/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_strutils.nim.c -o c_code/3_4/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_pathnorm.nim.c -o c_code/2_4/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_posix.nim.c -o c_code/3_4/stdlib_posix.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_options.nim.c -o c_code/3_4/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_times.nim.c -o c_code/3_4/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_os.nim.c -o c_code/3_4/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_hashes.nim.c -o c_code/2_4/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spathutils.nim.c -o c_code/2_4/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mutils@sropes.nim.c -o c_code/3_4/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sidioms.nim.c -o c_code/2_4/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreport_enums.nim.c -o c_code/2_4/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slineinfos.nim.c -o c_code/2_4/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@swordrecg.nim.c -o c_code/2_4/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sidents.nim.c -o c_code/2_4/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mutils@splatform.nim.c -o c_code/3_4/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strtabs.nim.c -o c_code/2_4/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sin_options.nim.c -o c_code/2_4/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sint128.nim.c -o c_code/2_4/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_types.nim.c -o c_code/2_4/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_lexer.nim.c -o c_code/2_4/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_parser.nim.c -o c_code/2_4/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_base_sem.nim.c -o c_code/2_4/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@snilcheck_enums.nim.c -o c_code/2_4/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_sem.nim.c -o c_code/2_4/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_vm.nim.c -o c_code/2_4/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svm_enums.nim.c -o c_code/2_4/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_debug.nim.c -o c_code/2_4/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_backend.nim.c -o c_code/2_4/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_internal.nim.c -o c_code/2_4/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_external.nim.c -o c_code/2_4/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_cmd.nim.c -o c_code/2_4/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports.nim.c -o c_code/2_4/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sprefixmatches.nim.c -o c_code/2_4/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@snimpaths.nim.c -o c_code/3_4/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mutils@sstrutils2.nim.c -o c_code/3_4/@mutils@sstrutils2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strformat.nim.c -o c_code/2_4/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_terminal.nim.c -o c_code/3_4/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_globs.nim.c -o c_code/2_4/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@soptions.nim.c -o c_code/3_4/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sllstream.nim.c -o c_code/3_4/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@snimlexbase.nim.c -o c_code/2_4/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@slexer.nim.c -o c_code/3_4/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_parsed_types.nim.c -o c_code/2_4/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@smsgs.nim.c -o c_code/3_4/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sequtils.nim.c -o c_code/2_4/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_sha1.nim.c -o c_code/3_4/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_streams.nim.c -o c_code/3_4/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_lexbase.nim.c -o c_code/2_4/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parsejson.nim.c -o c_code/2_4/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_json.nim.c -o c_code/3_4/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_idgen.nim.c -o c_code/2_4/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_query.nim.c -o c_code/2_4/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast.nim.c -o c_code/2_4/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_colortext.nim.c -o c_code/2_4/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mutils@sastrepr.nim.c -o c_code/3_4/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sparser.nim.c -o c_code/3_4/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@srenderer.nim.c -o c_code/3_4/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sfilters.nim.c -o c_code/2_4/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sfilter_tmpl.nim.c -o c_code/3_4/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@ssyntaxes.nim.c -o c_code/3_4/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scondsyms.nim.c -o c_code/2_4/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_intsets.nim.c -o c_code/3_4/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_md5.nim.c -o c_code/2_4/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sastalgo.nim.c -o c_code/3_4/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mic@srodfiles.nim.c -o c_code/3_4/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@spacked_ast.nim.c -o c_code/2_4/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mic@sic.nim.c -o c_code/3_4/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@smodulegraphs.nim.c -o c_code/3_4/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_parseopt.nim.c -o c_code/3_4/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@snimblecmd.nim.c -o c_code/3_4/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_cpuinfo.nim.c -o c_code/3_4/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_osproc.nim.c -o c_code/3_4/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_jsonutils.nim.c -o c_code/2_4/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@sextccomp.nim.c -o c_code/3_4/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@soptionsprocessor.nim.c -o c_code/3_4/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@snimconf.nim.c -o c_code/3_4/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@scommands.nim.c -o c_code/3_4/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sastmsgs.nim.c -o c_code/3_4/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@strees.nim.c -o c_code/2_4/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@serrorhandling.nim.c -o c_code/3_4/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@stypes.nim.c -o c_code/3_4/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@stypesrenderer.nim.c -o c_code/2_4/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@scli_reporter.nim.c -o c_code/3_4/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sexp.nim.c -o c_code/2_4/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_diff.nim.c -o c_code/2_4/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_sexp_diff.nim.c -o c_code/3_4/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@ssexp_reporter.nim.c -o c_code/3_4/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@scmdlinehelper.nim.c -o c_code/3_4/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@sdepfiles.nim.c -o c_code/3_4/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@spasses.nim.c -o c_code/3_4/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@scollectors.nim.c -o c_code/2_4/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@schecked_ast.nim.c -o c_code/2_4/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mutils@sbitsets.nim.c -o c_code/3_4/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@snimsets.nim.c -o c_code/3_4/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@serrorreporting.nim.c -o c_code/2_4/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@smagicsys.nim.c -o c_code/3_4/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@senumtostr.nim.c -o c_code/2_4/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@slinter.nim.c -o c_code/3_4/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@smodulepaths.nim.c -o c_code/3_4/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmdef.nim.c -o c_code/3_4/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssemdata.nim.c -o c_code/3_4/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_editdistance.nim.c -o c_code/2_4/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@slookups.nim.c -o c_code/3_4/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@simporter.nim.c -o c_code/3_4/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssemfold.nim.c -o c_code/3_4/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@stypeallowed.nim.c -o c_code/2_4/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sisolation_check.nim.c -o c_code/2_4/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sprocfind.nim.c -o c_code/2_4/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@spragmas.nim.c -o c_code/3_4/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemtypinst.nim.c -o c_code/2_4/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@slowerings.nim.c -o c_code/3_4/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sparampatterns.nim.c -o c_code/2_4/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssigmatch.nim.c -o c_code/3_4/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssighashes.nim.c -o c_code/3_4/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@sndi.nim.c -o c_code/3_4/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@scgendata.nim.c -o c_code/3_4/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@sccgutils.nim.c -o c_code/3_4/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@sliftdestructors.nim.c -o c_code/3_4/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@slambdalifting.nim.c -o c_code/3_4/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@sclosureiters.nim.c -o c_code/3_4/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@svarpartitions.nim.c -o c_code/2_4/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@ssaturate.nim.c -o c_code/2_4/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sguards.nim.c -o c_code/2_4/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@streetab.nim.c -o c_code/2_4/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@snilcheck.nim.c -o c_code/3_4/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssempass2.nim.c -o c_code/3_4/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@scgmeth.nim.c -o c_code/3_4/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@stransf.nim.c -o c_code/3_4/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliases.nim.c -o c_code/2_4/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spatterns.nim.c -o c_code/2_4/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@sevaltempl.nim.c -o c_code/3_4/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spluginsupport.nim.c -o c_code/2_4/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@slocals.nim.c -o c_code/2_4/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mplugins@sitersgen.nim.c -o c_code/3_4/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@sactive.nim.c -o c_code/2_4/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmtypegen.nim.c -o c_code/3_4/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmaux.nim.c -o c_code/3_4/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmtypes.nim.c -o c_code/2_4/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmmemory.nim.c -o c_code/3_4/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmobjects.nim.c -o c_code/2_4/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmcompilerserdes.nim.c -o c_code/3_4/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirtrees.nim.c -o c_code/2_4/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sastgen.nim.c -o c_code/2_4/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirgen.nim.c -o c_code/2_4/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sutils.nim.c -o c_code/2_4/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliasanalysis.nim.c -o c_code/2_4/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@smirexec.nim.c -o c_code/3_4/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sanalysis.nim.c -o c_code/2_4/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirchangesets.nim.c -o c_code/2_4/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@sinjectdestructors.nim.c -o c_code/3_4/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmir@smirbridge.nim.c -o c_code/3_4/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmgen.nim.c -o c_code/3_4/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmjit.nim.c -o c_code/3_4/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmlegacy.nim.c -o c_code/2_4/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@sgorgeimpl.nim.c -o c_code/3_4/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmerrors.nim.c -o c_code/2_4/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmdeps.nim.c -o c_code/3_4/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmhooks.nim.c -o c_code/2_4/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmops.nim.c -o c_code/3_4/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@smacrocacheimpl.nim.c -o c_code/2_4/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmprofiler.nim.c -o c_code/3_4/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmchecks.nim.c -o c_code/2_4/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svm.nim.c -o c_code/3_4/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@scompilerbridge.nim.c -o c_code/3_4/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mtools@ssuggest.nim.c -o c_code/3_4/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssem.nim.c -o c_code/3_4/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@spassaux.nim.c -o c_code/3_4/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@sdepends.nim.c -o c_code/3_4/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mic@sreplayer.nim.c -o c_code/3_4/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mmodules@smodules.nim.c -o c_code/3_4/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dynlib.nim.c -o c_code/2_4/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sdfa.nim.c -o c_code/2_4/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@scgen.nim.c -o c_code/3_4/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@spacked_env.nim.c -o c_code/2_4/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mvm@svmbackend.nim.c -o c_code/3_4/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mic@sdce.nim.c -o c_code/3_4/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mic@scbackend.nim.c -o c_code/3_4/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sintegrity.nim.c -o c_code/2_4/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@scbackend.nim.c -o c_code/3_4/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@sscripting.nim.c -o c_code/3_4/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@sjsgen.nim.c -o c_code/3_4/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@msem@ssourcemap.nim.c -o c_code/3_4/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mbackend@sjsbackend.nim.c -o c_code/3_4/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_xmltree.nim.c -o c_code/2_4/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mast@srenderverbatim.nim.c -o c_code/3_4/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_rstast.nim.c -o c_code/2_4/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_highlite.nim.c -o c_code/2_4/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_rst.nim.c -o c_code/3_4/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_rstgen.nim.c -o c_code/3_4/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_base64.nim.c -o c_code/2_4/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_uri.nim.c -o c_code/2_4/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mtools@sdocgen.nim.c -o c_code/3_4/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mtools@sdocgen2.nim.c -o c_code/3_4/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mfront@smain.nim.c -o c_code/3_4/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/stdlib_browsers.nim.c -o c_code/3_4/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/3_4/@mnim.nim.c -o c_code/3_4/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/2_4/stdlib_digitsutils.nim.o \
c_code/2_4/stdlib_assertions.nim.o \
c_code/2_4/stdlib_dragonbox.nim.o \
c_code/2_4/stdlib_schubfach.nim.o \
c_code/2_4/stdlib_formatfloat.nim.o \
c_code/2_4/stdlib_dollars.nim.o \
c_code/3_4/stdlib_io.nim.o \
c_code/3_4/stdlib_system.nim.o \
c_code/2_4/stdlib_parseutils.nim.o \
c_code/2_4/stdlib_math.nim.o \
c_code/2_4/stdlib_enumutils.nim.o \
c_code/2_4/stdlib_unicode.nim.o \
c_code/3_4/stdlib_strutils.nim.o \
c_code/2_4/stdlib_pathnorm.nim.o \
c_code/3_4/stdlib_posix.nim.o \
c_code/3_4/stdlib_options.nim.o \
c_code/3_4/stdlib_times.nim.o \
c_code/3_4/stdlib_os.nim.o \
c_code/2_4/stdlib_hashes.nim.o \
c_code/2_4/@mutils@spathutils.nim.o \
c_code/3_4/@mutils@sropes.nim.o \
c_code/2_4/@mutils@sidioms.nim.o \
c_code/2_4/@mast@sreport_enums.nim.o \
c_code/2_4/@mast@slineinfos.nim.o \
c_code/2_4/@mast@swordrecg.nim.o \
c_code/2_4/@mast@sidents.nim.o \
c_code/3_4/@mutils@splatform.nim.o \
c_code/2_4/stdlib_strtabs.nim.o \
c_code/2_4/@mfront@sin_options.nim.o \
c_code/2_4/@mutils@sint128.nim.o \
c_code/2_4/@mast@sast_types.nim.o \
c_code/2_4/@mast@sreports_lexer.nim.o \
c_code/2_4/@mast@sreports_parser.nim.o \
c_code/2_4/@mast@sreports_base_sem.nim.o \
c_code/2_4/@msem@snilcheck_enums.nim.o \
c_code/2_4/@mast@sreports_sem.nim.o \
c_code/2_4/@mast@sreports_vm.nim.o \
c_code/2_4/@mvm@svm_enums.nim.o \
c_code/2_4/@mast@sreports_debug.nim.o \
c_code/2_4/@mast@sreports_backend.nim.o \
c_code/2_4/@mast@sreports_internal.nim.o \
c_code/2_4/@mast@sreports_external.nim.o \
c_code/2_4/@mast@sreports_cmd.nim.o \
c_code/2_4/@mast@sreports.nim.o \
c_code/2_4/@mutils@sprefixmatches.nim.o \
c_code/3_4/@mmodules@snimpaths.nim.o \
c_code/3_4/@mutils@sstrutils2.nim.o \
c_code/2_4/stdlib_strformat.nim.o \
c_code/3_4/stdlib_terminal.nim.o \
c_code/2_4/stdlib_globs.nim.o \
c_code/3_4/@mfront@soptions.nim.o \
c_code/3_4/@mast@sllstream.nim.o \
c_code/2_4/@mast@snimlexbase.nim.o \
c_code/3_4/@mast@slexer.nim.o \
c_code/2_4/@mast@sast_parsed_types.nim.o \
c_code/3_4/@mfront@smsgs.nim.o \
c_code/2_4/stdlib_sequtils.nim.o \
c_code/3_4/stdlib_sha1.nim.o \
c_code/3_4/stdlib_streams.nim.o \
c_code/2_4/stdlib_lexbase.nim.o \
c_code/2_4/stdlib_parsejson.nim.o \
c_code/3_4/stdlib_json.nim.o \
c_code/2_4/@mast@sast_idgen.nim.o \
c_code/2_4/@mast@sast_query.nim.o \
c_code/2_4/@mast@sast.nim.o \
c_code/2_4/stdlib_colortext.nim.o \
c_code/3_4/@mutils@sastrepr.nim.o \
c_code/3_4/@mast@sparser.nim.o \
c_code/3_4/@mast@srenderer.nim.o \
c_code/2_4/@mast@sfilters.nim.o \
c_code/3_4/@mast@sfilter_tmpl.nim.o \
c_code/3_4/@mast@ssyntaxes.nim.o \
c_code/2_4/@mfront@scondsyms.nim.o \
c_code/3_4/stdlib_intsets.nim.o \
c_code/2_4/stdlib_md5.nim.o \
c_code/3_4/@mast@sastalgo.nim.o \
c_code/3_4/@mic@srodfiles.nim.o \
c_code/2_4/@mic@spacked_ast.nim.o \
c_code/3_4/@mic@sic.nim.o \
c_code/3_4/@mmodules@smodulegraphs.nim.o \
c_code/3_4/stdlib_parseopt.nim.o \
c_code/3_4/@mmodules@snimblecmd.nim.o \
c_code/3_4/stdlib_cpuinfo.nim.o \
c_code/3_4/stdlib_osproc.nim.o \
c_code/2_4/stdlib_jsonutils.nim.o \
c_code/3_4/@mbackend@sextccomp.nim.o \
c_code/3_4/@mfront@soptionsprocessor.nim.o \
c_code/3_4/@mfront@snimconf.nim.o \
c_code/3_4/@mfront@scommands.nim.o \
c_code/3_4/@mast@sastmsgs.nim.o \
c_code/2_4/@mast@strees.nim.o \
c_code/3_4/@mast@serrorhandling.nim.o \
c_code/3_4/@mast@stypes.nim.o \
c_code/2_4/@mast@stypesrenderer.nim.o \
c_code/3_4/@mfront@scli_reporter.nim.o \
c_code/2_4/stdlib_sexp.nim.o \
c_code/2_4/stdlib_diff.nim.o \
c_code/3_4/stdlib_sexp_diff.nim.o \
c_code/3_4/@mfront@ssexp_reporter.nim.o \
c_code/3_4/@mfront@scmdlinehelper.nim.o \
c_code/3_4/@mfront@sdepfiles.nim.o \
c_code/3_4/@msem@spasses.nim.o \
c_code/2_4/@msem@scollectors.nim.o \
c_code/2_4/@mast@schecked_ast.nim.o \
c_code/3_4/@mutils@sbitsets.nim.o \
c_code/3_4/@mast@snimsets.nim.o \
c_code/2_4/@mast@serrorreporting.nim.o \
c_code/3_4/@mmodules@smagicsys.nim.o \
c_code/2_4/@mast@senumtostr.nim.o \
c_code/3_4/@mast@slinter.nim.o \
c_code/3_4/@mmodules@smodulepaths.nim.o \
c_code/3_4/@mvm@svmdef.nim.o \
c_code/3_4/@msem@ssemdata.nim.o \
c_code/2_4/stdlib_editdistance.nim.o \
c_code/3_4/@msem@slookups.nim.o \
c_code/3_4/@mmodules@simporter.nim.o \
c_code/3_4/@msem@ssemfold.nim.o \
c_code/2_4/@msem@stypeallowed.nim.o \
c_code/2_4/@msem@sisolation_check.nim.o \
c_code/2_4/@msem@sprocfind.nim.o \
c_code/3_4/@msem@spragmas.nim.o \
c_code/2_4/@msem@ssemtypinst.nim.o \
c_code/3_4/@msem@slowerings.nim.o \
c_code/2_4/@msem@sparampatterns.nim.o \
c_code/3_4/@msem@ssigmatch.nim.o \
c_code/3_4/@msem@ssighashes.nim.o \
c_code/3_4/@mast@sndi.nim.o \
c_code/3_4/@mbackend@scgendata.nim.o \
c_code/3_4/@mbackend@sccgutils.nim.o \
c_code/3_4/@msem@sliftdestructors.nim.o \
c_code/3_4/@msem@slambdalifting.nim.o \
c_code/3_4/@msem@sclosureiters.nim.o \
c_code/2_4/@msem@svarpartitions.nim.o \
c_code/2_4/@mutils@ssaturate.nim.o \
c_code/2_4/@msem@sguards.nim.o \
c_code/2_4/@mast@streetab.nim.o \
c_code/3_4/@msem@snilcheck.nim.o \
c_code/3_4/@msem@ssempass2.nim.o \
c_code/3_4/@mbackend@scgmeth.nim.o \
c_code/3_4/@msem@stransf.nim.o \
c_code/2_4/@msem@saliases.nim.o \
c_code/2_4/@msem@spatterns.nim.o \
c_code/3_4/@msem@sevaltempl.nim.o \
c_code/2_4/@mutils@spluginsupport.nim.o \
c_code/2_4/@mplugins@slocals.nim.o \
c_code/3_4/@mplugins@sitersgen.nim.o \
c_code/2_4/@mplugins@sactive.nim.o \
c_code/3_4/@mvm@svmtypegen.nim.o \
c_code/3_4/@mvm@svmaux.nim.o \
c_code/2_4/@mvm@svmtypes.nim.o \
c_code/3_4/@mvm@svmmemory.nim.o \
c_code/2_4/@mvm@svmobjects.nim.o \
c_code/3_4/@mvm@svmcompilerserdes.nim.o \
c_code/2_4/@mmir@smirtrees.nim.o \
c_code/2_4/@mmir@sastgen.nim.o \
c_code/2_4/@mmir@smirgen.nim.o \
c_code/2_4/@mmir@sutils.nim.o \
c_code/2_4/@msem@saliasanalysis.nim.o \
c_code/3_4/@msem@smirexec.nim.o \
c_code/2_4/@mmir@sanalysis.nim.o \
c_code/2_4/@mmir@smirchangesets.nim.o \
c_code/3_4/@msem@sinjectdestructors.nim.o \
c_code/3_4/@mmir@smirbridge.nim.o \
c_code/3_4/@mvm@svmgen.nim.o \
c_code/3_4/@mvm@svmjit.nim.o \
c_code/2_4/@mvm@svmlegacy.nim.o \
c_code/3_4/@mvm@sgorgeimpl.nim.o \
c_code/2_4/@mvm@svmerrors.nim.o \
c_code/3_4/@mvm@svmdeps.nim.o \
c_code/2_4/@mvm@svmhooks.nim.o \
c_code/3_4/@mvm@svmops.nim.o \
c_code/2_4/@msem@smacrocacheimpl.nim.o \
c_code/3_4/@mvm@svmprofiler.nim.o \
c_code/2_4/@mvm@svmchecks.nim.o \
c_code/3_4/@mvm@svm.nim.o \
c_code/3_4/@mvm@scompilerbridge.nim.o \
c_code/3_4/@mtools@ssuggest.nim.o \
c_code/3_4/@msem@ssem.nim.o \
c_code/3_4/@msem@spassaux.nim.o \
c_code/3_4/@mmodules@sdepends.nim.o \
c_code/3_4/@mic@sreplayer.nim.o \
c_code/3_4/@mmodules@smodules.nim.o \
c_code/2_4/stdlib_dynlib.nim.o \
c_code/2_4/@msem@sdfa.nim.o \
c_code/3_4/@mbackend@scgen.nim.o \
c_code/2_4/@mvm@spacked_env.nim.o \
c_code/3_4/@mvm@svmbackend.nim.o \
c_code/3_4/@mic@sdce.nim.o \
c_code/3_4/@mic@scbackend.nim.o \
c_code/2_4/@mic@sintegrity.nim.o \
c_code/3_4/@mbackend@scbackend.nim.o \
c_code/3_4/@mfront@sscripting.nim.o \
c_code/3_4/@mbackend@sjsgen.nim.o \
c_code/3_4/@msem@ssourcemap.nim.o \
c_code/3_4/@mbackend@sjsbackend.nim.o \
c_code/2_4/stdlib_xmltree.nim.o \
c_code/3_4/@mast@srenderverbatim.nim.o \
c_code/2_4/stdlib_rstast.nim.o \
c_code/2_4/stdlib_highlite.nim.o \
c_code/3_4/stdlib_rst.nim.o \
c_code/3_4/stdlib_rstgen.nim.o \
c_code/2_4/stdlib_base64.nim.o \
c_code/2_4/stdlib_uri.nim.o \
c_code/3_4/@mtools@sdocgen.nim.o \
c_code/3_4/@mtools@sdocgen2.nim.o \
c_code/3_4/@mfront@smain.nim.o \
c_code/3_4/stdlib_browsers.nim.o \
c_code/3_4/@mnim.nim.o $LINK_FLAGS
    ;;
  *)
    echo 2>&1 "Error: no C code generated for: [$myos: $mycpu]"
    exit 1
    ;;
  esac
  ;;
android)
  case $mycpu in
  i386)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  amd64)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  arm)
    set -x
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  $LINK_FLAGS
    ;;
  arm64)
    set -x
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_digitsutils.nim.c -o c_code/2_4/stdlib_digitsutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_assertions.nim.c -o c_code/2_4/stdlib_assertions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dragonbox.nim.c -o c_code/2_4/stdlib_dragonbox.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_schubfach.nim.c -o c_code/2_4/stdlib_schubfach.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_formatfloat.nim.c -o c_code/2_4/stdlib_formatfloat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dollars.nim.c -o c_code/2_4/stdlib_dollars.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_io.nim.c -o c_code/4_4/stdlib_io.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_system.nim.c -o c_code/2_4/stdlib_system.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parseutils.nim.c -o c_code/2_4/stdlib_parseutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_math.nim.c -o c_code/2_4/stdlib_math.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_enumutils.nim.c -o c_code/2_4/stdlib_enumutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_unicode.nim.c -o c_code/2_4/stdlib_unicode.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strutils.nim.c -o c_code/2_4/stdlib_strutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_pathnorm.nim.c -o c_code/2_4/stdlib_pathnorm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_posix.nim.c -o c_code/4_4/stdlib_posix.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_options.nim.c -o c_code/2_4/stdlib_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_times.nim.c -o c_code/2_4/stdlib_times.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_os.nim.c -o c_code/4_4/stdlib_os.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_hashes.nim.c -o c_code/2_4/stdlib_hashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spathutils.nim.c -o c_code/2_4/@mutils@spathutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sropes.nim.c -o c_code/2_4/@mutils@sropes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sidioms.nim.c -o c_code/2_4/@mutils@sidioms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreport_enums.nim.c -o c_code/2_4/@mast@sreport_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slineinfos.nim.c -o c_code/2_4/@mast@slineinfos.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@swordrecg.nim.c -o c_code/2_4/@mast@swordrecg.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sidents.nim.c -o c_code/2_4/@mast@sidents.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mutils@splatform.nim.c -o c_code/4_4/@mutils@splatform.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strtabs.nim.c -o c_code/2_4/stdlib_strtabs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sin_options.nim.c -o c_code/2_4/@mfront@sin_options.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sint128.nim.c -o c_code/2_4/@mutils@sint128.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_types.nim.c -o c_code/2_4/@mast@sast_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_lexer.nim.c -o c_code/2_4/@mast@sreports_lexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_parser.nim.c -o c_code/2_4/@mast@sreports_parser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_base_sem.nim.c -o c_code/2_4/@mast@sreports_base_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@snilcheck_enums.nim.c -o c_code/2_4/@msem@snilcheck_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_sem.nim.c -o c_code/2_4/@mast@sreports_sem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_vm.nim.c -o c_code/2_4/@mast@sreports_vm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svm_enums.nim.c -o c_code/2_4/@mvm@svm_enums.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_debug.nim.c -o c_code/2_4/@mast@sreports_debug.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_backend.nim.c -o c_code/2_4/@mast@sreports_backend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_internal.nim.c -o c_code/2_4/@mast@sreports_internal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_external.nim.c -o c_code/2_4/@mast@sreports_external.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports_cmd.nim.c -o c_code/2_4/@mast@sreports_cmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sreports.nim.c -o c_code/2_4/@mast@sreports.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sprefixmatches.nim.c -o c_code/2_4/@mutils@sprefixmatches.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mmodules@snimpaths.nim.c -o c_code/4_4/@mmodules@snimpaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_strformat.nim.c -o c_code/2_4/stdlib_strformat.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_terminal.nim.c -o c_code/2_4/stdlib_terminal.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_globs.nim.c -o c_code/2_4/stdlib_globs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@soptions.nim.c -o c_code/4_4/@mfront@soptions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sllstream.nim.c -o c_code/2_4/@mast@sllstream.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@snimlexbase.nim.c -o c_code/2_4/@mast@snimlexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@slexer.nim.c -o c_code/2_4/@mast@slexer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_parsed_types.nim.c -o c_code/2_4/@mast@sast_parsed_types.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@smsgs.nim.c -o c_code/2_4/@mfront@smsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sequtils.nim.c -o c_code/2_4/stdlib_sequtils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sha1.nim.c -o c_code/2_4/stdlib_sha1.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_streams.nim.c -o c_code/2_4/stdlib_streams.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_lexbase.nim.c -o c_code/2_4/stdlib_lexbase.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_parsejson.nim.c -o c_code/2_4/stdlib_parsejson.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_json.nim.c -o c_code/2_4/stdlib_json.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_idgen.nim.c -o c_code/2_4/@mast@sast_idgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast_query.nim.c -o c_code/2_4/@mast@sast_query.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sast.nim.c -o c_code/2_4/@mast@sast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_colortext.nim.c -o c_code/2_4/stdlib_colortext.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sastrepr.nim.c -o c_code/2_4/@mutils@sastrepr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sparser.nim.c -o c_code/2_4/@mast@sparser.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@srenderer.nim.c -o c_code/2_4/@mast@srenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sfilters.nim.c -o c_code/2_4/@mast@sfilters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sfilter_tmpl.nim.c -o c_code/2_4/@mast@sfilter_tmpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@ssyntaxes.nim.c -o c_code/2_4/@mast@ssyntaxes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scondsyms.nim.c -o c_code/2_4/@mfront@scondsyms.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_intsets.nim.c -o c_code/2_4/stdlib_intsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_md5.nim.c -o c_code/2_4/stdlib_md5.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sastalgo.nim.c -o c_code/2_4/@mast@sastalgo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@srodfiles.nim.c -o c_code/2_4/@mic@srodfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@spacked_ast.nim.c -o c_code/2_4/@mic@spacked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mic@sic.nim.c -o c_code/4_4/@mic@sic.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smodulegraphs.nim.c -o c_code/2_4/@mmodules@smodulegraphs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_parseopt.nim.c -o c_code/4_4/stdlib_parseopt.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mmodules@snimblecmd.nim.c -o c_code/4_4/@mmodules@snimblecmd.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_cpuinfo.nim.c -o c_code/2_4/stdlib_cpuinfo.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_osproc.nim.c -o c_code/4_4/stdlib_osproc.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_jsonutils.nim.c -o c_code/2_4/stdlib_jsonutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mbackend@sextccomp.nim.c -o c_code/4_4/@mbackend@sextccomp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@soptionsprocessor.nim.c -o c_code/4_4/@mfront@soptionsprocessor.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@snimconf.nim.c -o c_code/2_4/@mfront@snimconf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@scommands.nim.c -o c_code/4_4/@mfront@scommands.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sastmsgs.nim.c -o c_code/2_4/@mast@sastmsgs.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@strees.nim.c -o c_code/2_4/@mast@strees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@serrorhandling.nim.c -o c_code/2_4/@mast@serrorhandling.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@stypes.nim.c -o c_code/2_4/@mast@stypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@stypesrenderer.nim.c -o c_code/2_4/@mast@stypesrenderer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@scli_reporter.nim.c -o c_code/4_4/@mfront@scli_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sexp.nim.c -o c_code/2_4/stdlib_sexp.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_diff.nim.c -o c_code/2_4/stdlib_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_sexp_diff.nim.c -o c_code/2_4/stdlib_sexp_diff.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@ssexp_reporter.nim.c -o c_code/2_4/@mfront@ssexp_reporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@scmdlinehelper.nim.c -o c_code/2_4/@mfront@scmdlinehelper.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mfront@sdepfiles.nim.c -o c_code/2_4/@mfront@sdepfiles.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spasses.nim.c -o c_code/2_4/@msem@spasses.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@scollectors.nim.c -o c_code/2_4/@msem@scollectors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@schecked_ast.nim.c -o c_code/2_4/@mast@schecked_ast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@sbitsets.nim.c -o c_code/2_4/@mutils@sbitsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@snimsets.nim.c -o c_code/2_4/@mast@snimsets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@serrorreporting.nim.c -o c_code/2_4/@mast@serrorreporting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smagicsys.nim.c -o c_code/2_4/@mmodules@smagicsys.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@senumtostr.nim.c -o c_code/2_4/@mast@senumtostr.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mast@slinter.nim.c -o c_code/4_4/@mast@slinter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mmodules@smodulepaths.nim.c -o c_code/4_4/@mmodules@smodulepaths.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmdef.nim.c -o c_code/2_4/@mvm@svmdef.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemdata.nim.c -o c_code/2_4/@msem@ssemdata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_editdistance.nim.c -o c_code/2_4/stdlib_editdistance.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@msem@slookups.nim.c -o c_code/4_4/@msem@slookups.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@simporter.nim.c -o c_code/2_4/@mmodules@simporter.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemfold.nim.c -o c_code/2_4/@msem@ssemfold.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@stypeallowed.nim.c -o c_code/2_4/@msem@stypeallowed.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sisolation_check.nim.c -o c_code/2_4/@msem@sisolation_check.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sprocfind.nim.c -o c_code/2_4/@msem@sprocfind.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@msem@spragmas.nim.c -o c_code/4_4/@msem@spragmas.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssemtypinst.nim.c -o c_code/2_4/@msem@ssemtypinst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@slowerings.nim.c -o c_code/2_4/@msem@slowerings.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sparampatterns.nim.c -o c_code/2_4/@msem@sparampatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssigmatch.nim.c -o c_code/2_4/@msem@ssigmatch.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssighashes.nim.c -o c_code/2_4/@msem@ssighashes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@sndi.nim.c -o c_code/2_4/@mast@sndi.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mbackend@scgendata.nim.c -o c_code/4_4/@mbackend@scgendata.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sccgutils.nim.c -o c_code/2_4/@mbackend@sccgutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sliftdestructors.nim.c -o c_code/2_4/@msem@sliftdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@slambdalifting.nim.c -o c_code/2_4/@msem@slambdalifting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sclosureiters.nim.c -o c_code/2_4/@msem@sclosureiters.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@svarpartitions.nim.c -o c_code/2_4/@msem@svarpartitions.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@ssaturate.nim.c -o c_code/2_4/@mutils@ssaturate.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sguards.nim.c -o c_code/2_4/@msem@sguards.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@streetab.nim.c -o c_code/2_4/@mast@streetab.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@snilcheck.nim.c -o c_code/2_4/@msem@snilcheck.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssempass2.nim.c -o c_code/2_4/@msem@ssempass2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scgmeth.nim.c -o c_code/2_4/@mbackend@scgmeth.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@stransf.nim.c -o c_code/2_4/@msem@stransf.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliases.nim.c -o c_code/2_4/@msem@saliases.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spatterns.nim.c -o c_code/2_4/@msem@spatterns.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sevaltempl.nim.c -o c_code/2_4/@msem@sevaltempl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mutils@spluginsupport.nim.c -o c_code/2_4/@mutils@spluginsupport.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@slocals.nim.c -o c_code/2_4/@mplugins@slocals.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@sitersgen.nim.c -o c_code/2_4/@mplugins@sitersgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mplugins@sactive.nim.c -o c_code/2_4/@mplugins@sactive.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmtypegen.nim.c -o c_code/2_4/@mvm@svmtypegen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmaux.nim.c -o c_code/2_4/@mvm@svmaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmtypes.nim.c -o c_code/2_4/@mvm@svmtypes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmmemory.nim.c -o c_code/2_4/@mvm@svmmemory.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmobjects.nim.c -o c_code/2_4/@mvm@svmobjects.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmcompilerserdes.nim.c -o c_code/2_4/@mvm@svmcompilerserdes.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirtrees.nim.c -o c_code/2_4/@mmir@smirtrees.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sastgen.nim.c -o c_code/2_4/@mmir@sastgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirgen.nim.c -o c_code/2_4/@mmir@smirgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sutils.nim.c -o c_code/2_4/@mmir@sutils.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@saliasanalysis.nim.c -o c_code/2_4/@msem@saliasanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@smirexec.nim.c -o c_code/2_4/@msem@smirexec.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@sanalysis.nim.c -o c_code/2_4/@mmir@sanalysis.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirchangesets.nim.c -o c_code/2_4/@mmir@smirchangesets.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sinjectdestructors.nim.c -o c_code/2_4/@msem@sinjectdestructors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmir@smirbridge.nim.c -o c_code/2_4/@mmir@smirbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmgen.nim.c -o c_code/2_4/@mvm@svmgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmjit.nim.c -o c_code/2_4/@mvm@svmjit.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmlegacy.nim.c -o c_code/2_4/@mvm@svmlegacy.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mvm@sgorgeimpl.nim.c -o c_code/4_4/@mvm@sgorgeimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmerrors.nim.c -o c_code/2_4/@mvm@svmerrors.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mvm@svmdeps.nim.c -o c_code/4_4/@mvm@svmdeps.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmhooks.nim.c -o c_code/2_4/@mvm@svmhooks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mvm@svmops.nim.c -o c_code/4_4/@mvm@svmops.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@smacrocacheimpl.nim.c -o c_code/2_4/@msem@smacrocacheimpl.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmprofiler.nim.c -o c_code/2_4/@mvm@svmprofiler.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmchecks.nim.c -o c_code/2_4/@mvm@svmchecks.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mvm@svm.nim.c -o c_code/4_4/@mvm@svm.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@scompilerbridge.nim.c -o c_code/2_4/@mvm@scompilerbridge.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mtools@ssuggest.nim.c -o c_code/2_4/@mtools@ssuggest.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@ssem.nim.c -o c_code/2_4/@msem@ssem.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@spassaux.nim.c -o c_code/2_4/@msem@spassaux.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@sdepends.nim.c -o c_code/2_4/@mmodules@sdepends.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sreplayer.nim.c -o c_code/2_4/@mic@sreplayer.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mmodules@smodules.nim.c -o c_code/2_4/@mmodules@smodules.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_dynlib.nim.c -o c_code/2_4/stdlib_dynlib.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@msem@sdfa.nim.c -o c_code/2_4/@msem@sdfa.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mbackend@scgen.nim.c -o c_code/4_4/@mbackend@scgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@spacked_env.nim.c -o c_code/2_4/@mvm@spacked_env.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mvm@svmbackend.nim.c -o c_code/2_4/@mvm@svmbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sdce.nim.c -o c_code/2_4/@mic@sdce.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@scbackend.nim.c -o c_code/2_4/@mic@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mic@sintegrity.nim.c -o c_code/2_4/@mic@sintegrity.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@scbackend.nim.c -o c_code/2_4/@mbackend@scbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@sscripting.nim.c -o c_code/4_4/@mfront@sscripting.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mbackend@sjsgen.nim.c -o c_code/2_4/@mbackend@sjsgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@msem@ssourcemap.nim.c -o c_code/4_4/@msem@ssourcemap.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mbackend@sjsbackend.nim.c -o c_code/4_4/@mbackend@sjsbackend.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_xmltree.nim.c -o c_code/2_4/stdlib_xmltree.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mast@srenderverbatim.nim.c -o c_code/2_4/@mast@srenderverbatim.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_rstast.nim.c -o c_code/2_4/stdlib_rstast.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_highlite.nim.c -o c_code/2_4/stdlib_highlite.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_rst.nim.c -o c_code/4_4/stdlib_rst.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_rstgen.nim.c -o c_code/4_4/stdlib_rstgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_base64.nim.c -o c_code/2_4/stdlib_base64.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/stdlib_uri.nim.c -o c_code/2_4/stdlib_uri.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mtools@sdocgen.nim.c -o c_code/4_4/@mtools@sdocgen.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/2_4/@mtools@sdocgen2.nim.c -o c_code/2_4/@mtools@sdocgen2.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mfront@smain.nim.c -o c_code/4_4/@mfront@smain.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/stdlib_browsers.nim.c -o c_code/4_4/stdlib_browsers.nim.o
    $CC $COMP_FLAGS -Ic_code -c c_code/4_4/@mnim.nim.c -o c_code/4_4/@mnim.nim.o
    if [ "$parallel" -gt 0 ]; then
      sem --wait --id $$
    fi
    $CC -o $binDir/nim  \
c_code/2_4/stdlib_digitsutils.nim.o \
c_code/2_4/stdlib_assertions.nim.o \
c_code/2_4/stdlib_dragonbox.nim.o \
c_code/2_4/stdlib_schubfach.nim.o \
c_code/2_4/stdlib_formatfloat.nim.o \
c_code/2_4/stdlib_dollars.nim.o \
c_code/4_4/stdlib_io.nim.o \
c_code/2_4/stdlib_system.nim.o \
c_code/2_4/stdlib_parseutils.nim.o \
c_code/2_4/stdlib_math.nim.o \
c_code/2_4/stdlib_enumutils.nim.o \
c_code/2_4/stdlib_unicode.nim.o \
c_code/2_4/stdlib_strutils.nim.o \
c_code/2_4/stdlib_pathnorm.nim.o \
c_code/4_4/stdlib_posix.nim.o \
c_code/2_4/stdlib_options.nim.o \
c_code/2_4/stdlib_times.nim.o \
c_code/4_4/stdlib_os.nim.o \
c_code/2_4/stdlib_hashes.nim.o \
c_code/2_4/@mutils@spathutils.nim.o \
c_code/2_4/@mutils@sropes.nim.o \
c_code/2_4/@mutils@sidioms.nim.o \
c_code/2_4/@mast@sreport_enums.nim.o \
c_code/2_4/@mast@slineinfos.nim.o \
c_code/2_4/@mast@swordrecg.nim.o \
c_code/2_4/@mast@sidents.nim.o \
c_code/4_4/@mutils@splatform.nim.o \
c_code/2_4/stdlib_strtabs.nim.o \
c_code/2_4/@mfront@sin_options.nim.o \
c_code/2_4/@mutils@sint128.nim.o \
c_code/2_4/@mast@sast_types.nim.o \
c_code/2_4/@mast@sreports_lexer.nim.o \
c_code/2_4/@mast@sreports_parser.nim.o \
c_code/2_4/@mast@sreports_base_sem.nim.o \
c_code/2_4/@msem@snilcheck_enums.nim.o \
c_code/2_4/@mast@sreports_sem.nim.o \
c_code/2_4/@mast@sreports_vm.nim.o \
c_code/2_4/@mvm@svm_enums.nim.o \
c_code/2_4/@mast@sreports_debug.nim.o \
c_code/2_4/@mast@sreports_backend.nim.o \
c_code/2_4/@mast@sreports_internal.nim.o \
c_code/2_4/@mast@sreports_external.nim.o \
c_code/2_4/@mast@sreports_cmd.nim.o \
c_code/2_4/@mast@sreports.nim.o \
c_code/2_4/@mutils@sprefixmatches.nim.o \
c_code/4_4/@mmodules@snimpaths.nim.o \
c_code/2_4/stdlib_strformat.nim.o \
c_code/2_4/stdlib_terminal.nim.o \
c_code/2_4/stdlib_globs.nim.o \
c_code/4_4/@mfront@soptions.nim.o \
c_code/2_4/@mast@sllstream.nim.o \
c_code/2_4/@mast@snimlexbase.nim.o \
c_code/2_4/@mast@slexer.nim.o \
c_code/2_4/@mast@sast_parsed_types.nim.o \
c_code/2_4/@mfront@smsgs.nim.o \
c_code/2_4/stdlib_sequtils.nim.o \
c_code/2_4/stdlib_sha1.nim.o \
c_code/2_4/stdlib_streams.nim.o \
c_code/2_4/stdlib_lexbase.nim.o \
c_code/2_4/stdlib_parsejson.nim.o \
c_code/2_4/stdlib_json.nim.o \
c_code/2_4/@mast@sast_idgen.nim.o \
c_code/2_4/@mast@sast_query.nim.o \
c_code/2_4/@mast@sast.nim.o \
c_code/2_4/stdlib_colortext.nim.o \
c_code/2_4/@mutils@sastrepr.nim.o \
c_code/2_4/@mast@sparser.nim.o \
c_code/2_4/@mast@srenderer.nim.o \
c_code/2_4/@mast@sfilters.nim.o \
c_code/2_4/@mast@sfilter_tmpl.nim.o \
c_code/2_4/@mast@ssyntaxes.nim.o \
c_code/2_4/@mfront@scondsyms.nim.o \
c_code/2_4/stdlib_intsets.nim.o \
c_code/2_4/stdlib_md5.nim.o \
c_code/2_4/@mast@sastalgo.nim.o \
c_code/2_4/@mic@srodfiles.nim.o \
c_code/2_4/@mic@spacked_ast.nim.o \
c_code/4_4/@mic@sic.nim.o \
c_code/2_4/@mmodules@smodulegraphs.nim.o \
c_code/4_4/stdlib_parseopt.nim.o \
c_code/4_4/@mmodules@snimblecmd.nim.o \
c_code/2_4/stdlib_cpuinfo.nim.o \
c_code/4_4/stdlib_osproc.nim.o \
c_code/2_4/stdlib_jsonutils.nim.o \
c_code/4_4/@mbackend@sextccomp.nim.o \
c_code/4_4/@mfront@soptionsprocessor.nim.o \
c_code/2_4/@mfront@snimconf.nim.o \
c_code/4_4/@mfront@scommands.nim.o \
c_code/2_4/@mast@sastmsgs.nim.o \
c_code/2_4/@mast@strees.nim.o \
c_code/2_4/@mast@serrorhandling.nim.o \
c_code/2_4/@mast@stypes.nim.o \
c_code/2_4/@mast@stypesrenderer.nim.o \
c_code/4_4/@mfront@scli_reporter.nim.o \
c_code/2_4/stdlib_sexp.nim.o \
c_code/2_4/stdlib_diff.nim.o \
c_code/2_4/stdlib_sexp_diff.nim.o \
c_code/2_4/@mfront@ssexp_reporter.nim.o \
c_code/2_4/@mfront@scmdlinehelper.nim.o \
c_code/2_4/@mfront@sdepfiles.nim.o \
c_code/2_4/@msem@spasses.nim.o \
c_code/2_4/@msem@scollectors.nim.o \
c_code/2_4/@mast@schecked_ast.nim.o \
c_code/2_4/@mutils@sbitsets.nim.o \
c_code/2_4/@mast@snimsets.nim.o \
c_code/2_4/@mast@serrorreporting.nim.o \
c_code/2_4/@mmodules@smagicsys.nim.o \
c_code/2_4/@mast@senumtostr.nim.o \
c_code/4_4/@mast@slinter.nim.o \
c_code/4_4/@mmodules@smodulepaths.nim.o \
c_code/2_4/@mvm@svmdef.nim.o \
c_code/2_4/@msem@ssemdata.nim.o \
c_code/2_4/stdlib_editdistance.nim.o \
c_code/4_4/@msem@slookups.nim.o \
c_code/2_4/@mmodules@simporter.nim.o \
c_code/2_4/@msem@ssemfold.nim.o \
c_code/2_4/@msem@stypeallowed.nim.o \
c_code/2_4/@msem@sisolation_check.nim.o \
c_code/2_4/@msem@sprocfind.nim.o \
c_code/4_4/@msem@spragmas.nim.o \
c_code/2_4/@msem@ssemtypinst.nim.o \
c_code/2_4/@msem@slowerings.nim.o \
c_code/2_4/@msem@sparampatterns.nim.o \
c_code/2_4/@msem@ssigmatch.nim.o \
c_code/2_4/@msem@ssighashes.nim.o \
c_code/2_4/@mast@sndi.nim.o \
c_code/4_4/@mbackend@scgendata.nim.o \
c_code/2_4/@mbackend@sccgutils.nim.o \
c_code/2_4/@msem@sliftdestructors.nim.o \
c_code/2_4/@msem@slambdalifting.nim.o \
c_code/2_4/@msem@sclosureiters.nim.o \
c_code/2_4/@msem@svarpartitions.nim.o \
c_code/2_4/@mutils@ssaturate.nim.o \
c_code/2_4/@msem@sguards.nim.o \
c_code/2_4/@mast@streetab.nim.o \
c_code/2_4/@msem@snilcheck.nim.o \
c_code/2_4/@msem@ssempass2.nim.o \
c_code/2_4/@mbackend@scgmeth.nim.o \
c_code/2_4/@msem@stransf.nim.o \
c_code/2_4/@msem@saliases.nim.o \
c_code/2_4/@msem@spatterns.nim.o \
c_code/2_4/@msem@sevaltempl.nim.o \
c_code/2_4/@mutils@spluginsupport.nim.o \
c_code/2_4/@mplugins@slocals.nim.o \
c_code/2_4/@mplugins@sitersgen.nim.o \
c_code/2_4/@mplugins@sactive.nim.o \
c_code/2_4/@mvm@svmtypegen.nim.o \
c_code/2_4/@mvm@svmaux.nim.o \
c_code/2_4/@mvm@svmtypes.nim.o \
c_code/2_4/@mvm@svmmemory.nim.o \
c_code/2_4/@mvm@svmobjects.nim.o \
c_code/2_4/@mvm@svmcompilerserdes.nim.o \
c_code/2_4/@mmir@smirtrees.nim.o \
c_code/2_4/@mmir@sastgen.nim.o \
c_code/2_4/@mmir@smirgen.nim.o \
c_code/2_4/@mmir@sutils.nim.o \
c_code/2_4/@msem@saliasanalysis.nim.o \
c_code/2_4/@msem@smirexec.nim.o \
c_code/2_4/@mmir@sanalysis.nim.o \
c_code/2_4/@mmir@smirchangesets.nim.o \
c_code/2_4/@msem@sinjectdestructors.nim.o \
c_code/2_4/@mmir@smirbridge.nim.o \
c_code/2_4/@mvm@svmgen.nim.o \
c_code/2_4/@mvm@svmjit.nim.o \
c_code/2_4/@mvm@svmlegacy.nim.o \
c_code/4_4/@mvm@sgorgeimpl.nim.o \
c_code/2_4/@mvm@svmerrors.nim.o \
c_code/4_4/@mvm@svmdeps.nim.o \
c_code/2_4/@mvm@svmhooks.nim.o \
c_code/4_4/@mvm@svmops.nim.o \
c_code/2_4/@msem@smacrocacheimpl.nim.o \
c_code/2_4/@mvm@svmprofiler.nim.o \
c_code/2_4/@mvm@svmchecks.nim.o \
c_code/4_4/@mvm@svm.nim.o \
c_code/2_4/@mvm@scompilerbridge.nim.o \
c_code/2_4/@mtools@ssuggest.nim.o \
c_code/2_4/@msem@ssem.nim.o \
c_code/2_4/@msem@spassaux.nim.o \
c_code/2_4/@mmodules@sdepends.nim.o \
c_code/2_4/@mic@sreplayer.nim.o \
c_code/2_4/@mmodules@smodules.nim.o \
c_code/2_4/stdlib_dynlib.nim.o \
c_code/2_4/@msem@sdfa.nim.o \
c_code/4_4/@mbackend@scgen.nim.o \
c_code/2_4/@mvm@spacked_env.nim.o \
c_code/2_4/@mvm@svmbackend.nim.o \
c_code/2_4/@mic@sdce.nim.o \
c_code/2_4/@mic@scbackend.nim.o \
c_code/2_4/@mic@sintegrity.nim.o \
c_code/2_4/@mbackend@scbackend.nim.o \
c_code/4_4/@mfront@sscripting.nim.o \
c_code/2_4/@mbackend@sjsgen.nim.o \
c_code/4_4/@msem@ssourcemap.nim.o \
c_code/4_4/@mbackend@sjsbackend.nim.o \
c_code/2_4/stdlib_xmltree.nim.o \
c_code/2_4/@mast@srenderverbatim.nim.o \
c_code/2_4/stdlib_rstast.nim.o \
c_code/2_4/stdlib_highlite.nim.o \
c_code/4_4/stdlib_rst.nim.o \
c_code/4_4/stdlib_rstgen.nim.o \
c_code/2_4/stdlib_base64.nim.o \
c_code/2_4/stdlib_uri.nim.o \
c_code/4_4/@mtools@sdocgen.nim.o \
c_code/2_4/@mtools@sdocgen2.nim.o \
c_code/4_4/@mfront@smain.nim.o \
c_code/4_4/stdlib_browsers.nim.o \
c_code/4_4/@mnim.nim.o $LINK_FLAGS
    ;;
  *)
    echo 2>&1 "Error: no C code generated for: [$myos: $mycpu]"
    exit 1
    ;;
  esac
  ;;
*)
  echo 2>&1 "Error: no C code generated for: [$myos: $mycpu]"
  exit 1
  ;;
esac

: SUCCESS

