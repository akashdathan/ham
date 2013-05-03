TAG=msvc_11_arm
echo I/Setting up $TAG

case $HAM_OS in
    NT*)
        ;;
    *)
        echo "E/Toolset: Unsupported host OS"
        return 1
        ;;
esac

########################################################################
##  Find cl.exe to setup MSVCDIR
########################################################################
export MSVCDIR="`unxpath "$PROGRAMFILES\\Microsoft Visual Studio 11.0\\VC"`"
if [ ! -e "$MSVCDIR/bin/x86_arm/cl.exe" ]; then
	echo "E/Can't find cl.exe for $TAG"
	return 1
fi
echo "I/Found VC++ in '$MSVCDIR'"

########################################################################
##  Find devenv.exe to setup RUN_DEBUGGER
########################################################################
export MSVC_IDE_DIR="${MSVCDIR}/../Common7/IDE"
export RUN_DEBUGGER="${MSVC_IDE_DIR}/devenv.exe"
if [ ! -f "$RUN_DEBUGGER" ]; then
	echo "E/Can't find debugger 'devenv.exe' for $TAG"
else
    echo "I/Found VC++ debugger in '$RUN_DEBUGGER'"
fi
export RUN_DEBUGGER_PARAMS=-debugexe

########################################################################
##  Find gacutil.exe to setup WINSDKDIR
########################################################################
export WINSDKDIR="`unxpath "$PROGRAMFILES\\Windows Kits\\8.0"`"
if [ ! -e "$WINSDKDIR/bin/x86/fxc.exe" ]; then
	echo "E/Can't find fxc.exe for WinSDK"
	return 1
fi
echo "I/Found WindowsSDK in '$WINSDKDIR'"

########################################################################
##  Setup the C++ environment
########################################################################
export HAM_TOOLSET=VISUALC
export HAM_TOOLSET_VER=11
export HAM_TOOLSET_NAME=msvc_11_arm
export HAM_TOOLSET_DIR=${HAM_HOME}/toolsets/${HAM_TOOLSET_NAME}

export PATH="${WINSDKDIR}/bin/x86":"${MSVCDIR}/bin/x86_arm":"${MSVCDIR}/bin":"${MSVC_IDE_DIR}":${PATH}
export INCLUDE="`nativedir \"${WINSDKDIR}/include/um\"`;`nativedir \"${WINSDKDIR}/include/shared\"`;`nativedir \"${MSVCDIR}/include\"`;`nativedir \"${MSVCDIR}/atlmfc/include/\"`"
export LIB="`nativedir \"${WINSDKDIR}/lib/win8/um/arm\"`;`nativedir \"${MSVCDIR}/lib/arm\"`;`nativedir \"${MSVCDIR}/atlmfc/lib/arm\"`"

export HAM_CL="\"$MSVCDIR/bin/x86_arm/cl.exe\""
export HAM_LINK="\"$MSVCDIR/bin/x86_arm/link.exe\""
export HAM_CROSS=

VER="--- Microsoft Visual C++ 11 arm -----------------"
if [ "$HAM_NO_VER_CHECK" != "1" ]; then
    VER="$VER
`cl 2>&1 >/dev/null`"
    if [ $? != 0 ]; then
        echo "E/Can't get version."
        return 1
    fi
fi

export HAM_TOOLSET_VERSIONS="$HAM_TOOLSET_VERSIONS
$VER"