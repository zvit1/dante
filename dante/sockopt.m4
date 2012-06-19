dnl look for available socket options

unset ALLSOCKOPTS
unset SOCKOPTS
L_CHECKSOCKOPT(SOL_SOCKET, SO_BINDANY) #test requires root
L_CHECKSOCKOPT(SOL_SOCKET, SO_BROADCAST)
L_CHECKSOCKOPT(SOL_SOCKET, SO_DEBUG)
L_CHECKSOCKOPT(SOL_SOCKET, SO_DONTROUTE)
L_CHECKSOCKOPT(SOL_SOCKET, SO_JUMBO)
L_CHECKSOCKOPT(SOL_SOCKET, SO_KEEPALIVE)
L_CHECKSOCKOPT(SOL_SOCKET, SO_LINGER)   #linger arg
L_CHECKSOCKOPT(SOL_SOCKET, SO_OOBINLINE)
L_CHECKSOCKOPT(SOL_SOCKET, SO_PRIORITY)
L_CHECKSOCKOPT(SOL_SOCKET, SO_RCVBUF)
L_CHECKSOCKOPT(SOL_SOCKET, SO_RCVBUFFORCE)
L_CHECKSOCKOPT(SOL_SOCKET, SO_RCVLOWAT)
L_CHECKSOCKOPT(SOL_SOCKET, SO_RCVTIMEO) #timeval arg
L_CHECKSOCKOPT(SOL_SOCKET, SO_SNDBUF)
L_CHECKSOCKOPT(SOL_SOCKET, SO_SNDBUFFORCE)
L_CHECKSOCKOPT(SOL_SOCKET, SO_SNDLOWAT)
L_CHECKSOCKOPT(SOL_SOCKET, SO_SNDTIMEO) #timeval arg
L_CHECKSOCKOPT(SOL_SOCKET, SO_TIMESTAMP) #XXX requires additional code
L_CHECKSOCKOPT(SOL_SOCKET, SO_USELOOPBACK)

L_CHECKSOCKOPT(IPPROTO_TCP, TCP_CORK)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_CWND)      #Google patch
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_INIT_CWND) #Solaris
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_KEEPCNT)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_KEEPIDLE)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_KEEPINTVL)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_LINGER2)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_MAXRT)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_MAXSEG)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_MD5SIG)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_NODELAY)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_NOOPT)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_NOPUSH)
#L_CHECKSOCKOPT(IPPROTO_TCP, TCP_QUICKACK) #only transient?
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_SACK_ENABLE)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_STDURG)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_SYNCNT)
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_WINDOW_CLAMP)

L_CHECKSOCKOPT(IPPROTO_UDP, UDP_CORK)

L_CHECKSOCKOPT(IPPROTO_IP, IP_AUTH_LEVEL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_DONTFRAG)
L_CHECKSOCKOPT(IPPROTO_IP, IP_ESP_NETWORK_LEVEL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_ESP_TRANS_LEVEL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_FREEBIND)
L_CHECKSOCKOPT(IPPROTO_IP, IP_IPCOMP_LEVEL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_MINTTL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_MTU_DISCOVER)
L_CHECKSOCKOPT(IPPROTO_IP, IP_PORTRANGE)
L_CHECKSOCKOPT(IPPROTO_IP, IP_RECVTOS)
L_CHECKSOCKOPT(IPPROTO_IP, IP_TOS)
L_CHECKSOCKOPT(IPPROTO_IP, IP_TTL)

OKSOCKOPTS="$SOCKOPTS" #user-settable socket options

ALLSOCKOPTS="$SOCKOPTS"

#hostid options (only first option found will be used, order by priority)
unset SOCKOPTS
L_CHECKSOCKOPT(IPPROTO_TCP, TCP_IPA) #option28 arg
#check if TCP_IPA is usable
if test x"$SOCKOPTS" = x"TCP_IPA"; then
    AC_MSG_CHECKING([for TCP_IPA_MAX define])
    AC_TRY_COMPILE([
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

#ifndef TCP_IPA_MAX
#error "no TCP_IPA_MAX value defined"
#endif /* TCP_IPA_MAX */
], [], [AC_DEFINE(HAVE_MAX_HOSTIDS, [TCP_IPA_MAX], [hostid size])
        AC_MSG_RESULT(yes)],
    [AC_MSG_RESULT(no)
    unset oksize failsize
    for size in 1 2 3 4 5 6 7 8 9 10; do
	L_CHECK_TCPIPASIZE($size, [oksize=$size], [failsize=t])
	test x"$failsize" != x && break
    done
    if test x"$oksize" != x; then
	AC_DEFINE_UNQUOTED(HAVE_MAX_HOSTIDS, [$oksize], [hostid size])
    else
	#XXX should not occur, ideally have option undefed
	AC_MSG_WARN([unable to determine TCP_IPA max size, setting to 0])
	AC_DEFINE(HAVE_MAX_HOSTIDS, 0, [hostid size])
	unset SOCKOPTS #NOTE: assumes TCP_IPA is first tested type
    fi])
fi

HOSTIDSOCKOPTS="$SOCKOPTS"

ALLSOCKOPTS="$ALLSOCKOPTS $SOCKOPTS"

#options that are not settable by users
unset SOCKOPTS
L_CHECKSOCKOPT(SOL_SOCKET, SO_REUSEADDR)
L_CHECKSOCKOPT(SOL_SOCKET, SO_REUSEPORT)

L_CHECKSOCKOPT(IPPROTO_IP, IP_HDRINCL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_MULTICAST_IF)
L_CHECKSOCKOPT(IPPROTO_IP, IP_MULTICAST_LOOP)
L_CHECKSOCKOPT(IPPROTO_IP, IP_MULTICAST_TTL)
L_CHECKSOCKOPT(IPPROTO_IP, IP_OPTIONS)
L_CHECKSOCKOPT(IPPROTO_IP, IP_RECVDSTADDR)
L_CHECKSOCKOPT(IPPROTO_IP, IP_RECVIF)

INVALIDSOCKOPTS="$SOCKOPTS" #not user-settable options

ALLSOCKOPTS="$ALLSOCKOPTS $SOCKOPTS"

#add symbolic values for options
unset SOCKOPTVALSYMS
for opt in $OKSOCKOPTS; do
    case $opt in
	IP_PORTRANGE)
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_DEFAULT)
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_HIGH)
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_LOW)
	    ;;
    esac
done

#define socket option behavior.
# the default is integer values that can only be set before bind()/connect(),
# exceptions are specified here.

#postonly: only settable after bind()/connect()
SOCKOPTS_POSTONLY="TCP_CWND"

#anytime: always settable
SOCKOPTS_ANYTIME="SO_DEBUG IP_TOS" #XXX verify/expand

#dup: options for which values should be duplicated across connections
SOCKOPTSDUP_IP="IP_HDRINCL IP_MULTICAST_IF IP_MULTICAST_LOOP IP_MULTICAST_TTL
                IP_OPTIONS IP_RECVDSTADDR IP_RECVIF IP_TOS IP_TTL"
SOCKOPTSDUP_SOL="SO_BROADCAST SO_DEBUG SO_DONTROUTE SO_KEEPALIVE SO_LINGER
                 SO_OOBINLINE SO_RCVBUF SO_RCVLOWAT SO_RCVTIMEO SO_REUSEADDR
                 SO_REUSEPORT SO_SNDBUF SO_SNDLOWAT SO_SNDTIMEO SO_TIMESTAMP
                 SO_USELOOPBACK"
SOCKOPTSDUP_TCP="TCP_KEEPALIVE TCP_MAXRT TCP_MAXSEG TCP_NODELAY TCP_STDURG"

IPTOS_DSCP="AF11 AF12 AF13 AF21 AF22 AF23 AF31 AF32 AF33 AF41 AF42 AF43
            CS0 CS1 CS2 CS3 CS4 CS5 CS6 CS7 EF"
IPTOS_PREC="NETCONTROL INTERNETCONTROL CRITIC_ECP FLASHOVERRIDE FLASH
            IMMEDIATE PRIORITY ROUTINE"
IPTOS_TOS="LOWDELAY THROUGHPUT RELIABILITY"

sockopt2argtype()
{
   _opt=$1

    case ${_opt} in
	SO_LINGER)
	    _argtype="linger_val"
	    ;;
	SO_SNDTIMEO | SO_RCVTIMEO)
	    _argtype="timeval_val"
	    ;;
	TCP_IPA)
	    _argtype="option28_val"
	    ;;
	*)
	    _argtype="int_val"
	    ;;
    esac

    echo ${_argtype}
}

optargmatch ()
{
   _list="$1"
   _opt="$2"

    for _val in ${_list}; do
	if test x"${_val}" = x"${_opt}"; then
	    return 0
	fi
    done

    return 1
}

#priv: options that require privileges to set
SOCKOPTS_PRIV="SO_BINDANY"

OPTSRCTMP0=_sockopttmp0.c #for options to be duplicated
OPTSRCTMP1=_sockopttmp1.c #for options definitions
OPTSRCTMP2=_sockopttmp2.c #for option argument symbols
cp /dev/null $OPTSRCTMP0
cp /dev/null $OPTSRCTMP1
cp /dev/null $OPTSRCTMP2

DUPSOCKOPTCNT=0
for opt in $ALLSOCKOPTS; do
    if optargmatch "${SOCKOPTSDUP_IP}" $opt; then
        echo "   { IPPROTO_IP, $opt, \"$opt\" }," >> $OPTSRCTMP0
        DUPSOCKOPTCNT=`expr $DUPSOCKOPTCNT + 1`
    fi
    if optargmatch "${SOCKOPTSDUP_SOL}" $opt; then
        echo "   { SOL_SOCKET, $opt, \"$opt\" }," >> $OPTSRCTMP0
        DUPSOCKOPTCNT=`expr $DUPSOCKOPTCNT + 1`
    fi
    if optargmatch "${SOCKOPTSDUP_TCP}" $opt; then
        echo "   { IPPROTO_TCP, $opt, \"$opt\" }," >> $OPTSRCTMP0
        DUPSOCKOPTCNT=`expr $DUPSOCKOPTCNT + 1`
    fi
done

SOCKOPTCNT=0
SOCKOPTSYMCNT=0
unset OKSOCKOPTVALSYMS
for opt in $OKSOCKOPTS; do
    argtype=`sockopt2argtype $opt`

    calltype="preonly" #default
    if optargmatch "${SOCKOPTS_POSTONLY}" $opt; then
       calltype="postonly"
    fi
    if optargmatch "${SOCKOPTS_ANYTIME}" $opt; then
       calltype="anytime"
    fi

    optshift=0
    optmask=0

    if optargmatch "${SOCKOPTS_DUP}" $opt; then
       dup=1
    else
       dup=0
    fi

    priv=0

    if optargmatch "${SOCKOPTS_PRIV}" $opt; then
       priv=1
    else
       priv=0
    fi

    optid=$SOCKOPTCNT

    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_${opt}_NAME }," >> $OPTSRCTMP1
    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`

    #add subfields
    case $opt in
	IP_PORTRANGE)
	    unset SOCKOPTVALSYMS
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_DEFAULT)
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_HIGH)
	    L_CHECKSOCKOPTVALSYM(IPPROTO_IP, IP_PORTRANGE, IP_PORTRANGE_LOW)
	    unset symlist
	    for sym in $SOCKOPTVALSYMS; do
		echo "   { $optid, { .int_val = $sym }, SOCKS_${sym}_SYMNAME }," >> $OPTSRCTMP2
		lcsym=`echo $sym | ucase`
		symlist="$symlist${symlist:+ }$lcsym"
		SOCKOPTSYMCNT=`expr $SOCKOPTSYMCNT + 1`
	    done
	    if test x"$symlist" != x; then
		OKSOCKOPTVALSYMS="$OKSOCKOPTVALSYMS${OKSOCKOPTVALSYMS:+ }$opt($symlist)"
	    fi
	    ;;

	IP_TOS)
	    #DSCP (rfc2474), 6 bits (2-7)
	    optshift=2
	    optmask=0x3F
	    optid=$SOCKOPTCNT
	    subfield="ip_tos.dscp"
	    AC_DEFINE_UNQUOTED(SOCKS_IP_TOS_DSCP_NAME, ["$subfield"], [IP_TOS subfield])
	    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_IP_TOS_DSCP_NAME }," >> $OPTSRCTMP1
	    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`

	    unset symlist
	    for sym in $IPTOS_DSCP; do
		echo "   { $optid, { .int_val = SOCKS_IP_TOS_DSCP_${sym} }, SOCKS_IP_TOS_DSCP_${sym}_SYMNAME }," >> $OPTSRCTMP2
		lcsym=`echo $sym | ucase`
		symlist="$symlist${symlist:+ }$lcsym"
		SOCKOPTSYMCNT=`expr $SOCKOPTSYMCNT + 1`
	    done
	    if test x"$symlist" != x; then
		OKSOCKOPTVALSYMS="$OKSOCKOPTVALSYMS${OKSOCKOPTVALSYMS:+ }$subfield($symlist)"
	    fi

	    #Precedence
	    optshift=5
	    optmask=0x7
	    optid=$SOCKOPTCNT
	    subfield="ip_tos.prec"
	    AC_DEFINE_UNQUOTED(SOCKS_IP_TOS_PREC_NAME, ["$subfield"], [IP_TOS subfield])
	    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_IP_TOS_PREC_NAME }," >> $OPTSRCTMP1
	    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`

	    unset symlist
	    for sym in $IPTOS_PREC; do
		echo "   { $optid, { .int_val = SOCKS_IP_TOS_PREC_${sym} }, SOCKS_IP_TOS_PREC_${sym}_SYMNAME }," >> $OPTSRCTMP2
		lcsym=`echo $sym | ucase`
		symlist="$symlist${symlist:+ }$lcsym"
		SOCKOPTSYMCNT=`expr $SOCKOPTSYMCNT + 1`
	    done
	    if test x"$symlist" != x; then
		OKSOCKOPTVALSYMS="$OKSOCKOPTVALSYMS${OKSOCKOPTVALSYMS:+ }$subfield($symlist)"
	    fi

	    #TOS (bits 1-4)
	    optshift=1
	    optmask=0xf
	    optid=$SOCKOPTCNT
	    subfield="ip_tos.tos"
	    AC_DEFINE_UNQUOTED(SOCKS_IP_TOS_TOS_NAME, ["$subfield"], [IP_TOS subfield])
	    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_IP_TOS_TOS_NAME }," >> $OPTSRCTMP1
	    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`

	    unset symlist
	    for sym in $IPTOS_TOS; do
		echo "   { $optid, { .int_val = SOCKS_IP_TOS_TOS_${sym} }, SOCKS_IP_TOS_TOS_${sym}_SYMNAME }," >> $OPTSRCTMP2
		lcsym=`echo $sym | ucase`
		symlist="$symlist${symlist:+ }$lcsym"
		SOCKOPTSYMCNT=`expr $SOCKOPTSYMCNT + 1`
	    done
	    if test x"$symlist" != x; then
		OKSOCKOPTVALSYMS="$OKSOCKOPTVALSYMS${OKSOCKOPTVALSYMS:+ }$subfield($symlist)"
	    fi
	    ;;
    esac
done

#hostid options (only set first)
unset HOSTIDTYPE
AC_MSG_CHECKING([for supported hostid type])
for opt in $HOSTIDSOCKOPTS; do
    argtype=`sockopt2argtype $opt`

    calltype="preonly" #default
    if optargmatch "${SOCKOPTS_POSTONLY}" $opt; then
       calltype="postonly"
    fi
    if optargmatch "${SOCKOPTS_ANYTIME}" $opt; then
       calltype="anytime"
    fi

    optshift=0
    optmask=0

    if optargmatch "${SOCKOPTS_DUP}" $opt; then
       dup=1
    else
       dup=0
    fi

    priv=0

    if optargmatch "${SOCKOPTS_PRIV}" $opt; then
       priv=1
    else
       priv=0
    fi

    optid=$SOCKOPTCNT

    AC_DEFINE_UNQUOTED(SOCKS_HOSTID_NAME, ["hostid"], [hostid option type])
    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_HOSTID_NAME }," >> $OPTSRCTMP1
    AC_DEFINE_UNQUOTED(SOCKS_HOSTID_TYPE, [SOCKS_HOSTID_TYPE_${opt}], [hostid option type])
    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`
    HOSTIDTYPE=$opt

    #add supported arguments
    unset symlist
    for sym in NONE PASS ADDCLIENT SETCLIENT; do
	echo "   { $optid, { .int_val = SOCKS_HOSTID_$sym }, SOCKS_HOSTID_${sym}_SYMNAME }," >> $OPTSRCTMP2
	SOCKOPTSYMCNT=`expr $SOCKOPTSYMCNT + 1`
    done
    OKSOCKOPTVALSYMS="$OKSOCKOPTVALSYMS${OKSOCKOPTVALSYMS:+ }hostid(none pass add-client set-client)"
    OKSOCKOPTS="$OKSOCKOPTS${OKSOCKOPTS:+ }hostid($opt)"

    break #end after first entry
done
if test x"$HOSTIDTYPE" = x; then
    AC_MSG_RESULT([no])
    AC_DEFINE(SOCKS_HOSTID_TYPE, [SOCKS_HOSTID_TYPE_NONE], [no hostid support])
else
    AC_MSG_RESULT([$HOSTIDTYPE])
fi

#options that are not settable by users
for opt in $INVALIDSOCKOPTS; do
    calltype="invalid"
    argtype=`sockopt2argtype $opt`
    optshift=0
    optmask=0
    priv=0
    optid=$SOCKOPTCNT

    echo "   { $optid, $argtype, ${opt}, SOCKS_${opt}_LVL, $calltype, $optshift, $optmask, $dup, $priv, SOCKS_${opt}_NAME }," >> $OPTSRCTMP1
    SOCKOPTCNT=`expr $SOCKOPTCNT + 1`
done

#generate source file
case $APP in
    dante)
	SOCKOPTSRC="lib/sockopt_gen.c"
	;;
    *)
	SOCKOPTSRC="src/sockopt_gen.c"
	;;
esac
cp ${SOCKOPTSRC%_gen.c}_tpl.c $SOCKOPTSRC
echo "" >> $SOCKOPTSRC

#quotes around argument added to avoid [] in text from disappearing
echo ['static const struct option option[] = {'] >> $SOCKOPTSRC
cat $OPTSRCTMP0 >> $SOCKOPTSRC
echo '};' >> $SOCKOPTSRC
echo '' >> $SOCKOPTSRC
AC_DEFINE_UNQUOTED(HAVE_DUPSOCKOPT_MAX, $DUPSOCKOPTCNT, [option count])dnl

#quotes around argument added to avoid [] in text from disappearing
echo ['static const sockopt_t sockopts[] = {'] >> $SOCKOPTSRC
#list of options that can be set also after connection has been established
cat $OPTSRCTMP1 >> $SOCKOPTSRC
echo '};' >> $SOCKOPTSRC
AC_DEFINE_UNQUOTED(HAVE_SOCKOPTVAL_MAX, $SOCKOPTCNT, [socket option count])dnl

#add symbolic values for options
echo '' >> $SOCKOPTSRC
#quotes around argument added to avoid [] in text from disappearing
echo ['static const sockoptvalsym_t sockoptvalsyms[] = {'] >> $SOCKOPTSRC
cat $OPTSRCTMP2 >> $SOCKOPTSRC
echo '};' >> $SOCKOPTSRC
AC_DEFINE_UNQUOTED(HAVE_SOCKOPTVALSYM_MAX, $SOCKOPTSYMCNT, [symbol count])dnl

rm -f $OPTSRCTMP1 $OPTSRCTMP2
