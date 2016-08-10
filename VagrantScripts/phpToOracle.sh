#!/bin/sh
# Let's install everything that lets PHP talk to Oracle 
# Basically, Oracle setup with ODBC front-end, then a PHP extension
# to talk to ODBC
set -e


# config files, ugh
# START SHAR TO THE RESCUE

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.7).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `#!/bin/sh' line above, then type `sh FILE'.
#
lock_dir=_sh09732
# Made on 2016-01-28 23:51 UTC by <vagrant@cbcworldwide.developer.cyberitas.com>.
# Source directory was `/home/vagrant'.
#
# Existing files will *not* be overwritten, unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   7011 -rw-r--r-- /etc/odbc.ini
#    774 -rw-r--r-- /etc/odbcinst.ini
#    441 -rw-r--r-- /etc/tnsnames.ora
#     35 -rw-r--r-- /etc/ld.so.conf.d/oracle.conf
#
MD5SUM=${MD5SUM-md5sum}
f=`${MD5SUM} --version | egrep '^md5sum .*(core|text)utils'`
test -n "${f}" && md5check=true || md5check=false
${md5check} || \
  echo 'Note: not verifying md5sums.  Consider installing GNU coreutils.'
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    case `$dir/gettext --version 2>&1 | sed 1q` in
      *GNU*) gettext_dir=$dir ;;
    esac
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
if (echo "testing\c"; echo 1,2,3) | grep c >/dev/null
then if (echo -n test; echo 1,2,3) | grep n >/dev/null
     then shar_n= shar_c='
'
     else shar_n=-n shar_c= ; fi
else shar_n= shar_c='\c' ; fi
f=shar-touch.$$
st1=200112312359.59
st2=123123592001.59
st2tr=123123592001.5 # old SysV 14-char limit
st3=1231235901

if touch -am -t ${st1} ${f} >/dev/null 2>&1 && \
   test ! -f ${st1} && test -f ${f}; then
  shar_touch='touch -am -t $1$2$3$4$5$6.$7 "$8"'

elif touch -am ${st2} ${f} >/dev/null 2>&1 && \
   test ! -f ${st2} && test ! -f ${st2tr} && test -f ${f}; then
  shar_touch='touch -am $3$4$5$6$1$2.$7 "$8"'

elif touch -am ${st3} ${f} >/dev/null 2>&1 && \
   test ! -f ${st3} && test -f ${f}; then
  shar_touch='touch -am $3$4$5$6$2 "$8"'

else
  shar_touch=:
  echo
  ${echo} 'WARNING: not restoring timestamps.  Consider getting and'
  ${echo} 'installing GNU `touch'\'', distributed in GNU coreutils...'
  echo
fi
rm -f ${st1} ${st2} ${st2tr} ${st3} ${f}
#
if test ! -d ${lock_dir}
then : ; else ${echo} 'lock directory '${lock_dir}' exists'
  exit 1
fi
if mkdir ${lock_dir}
then ${echo} 'x - created lock directory `'${lock_dir}\''.'
else ${echo} 'x - failed to create lock directory `'${lock_dir}\''.'
  exit 1
fi
# ============= /etc/odbc.ini ==============
if test ! -d '/etc'; then
  mkdir '/etc'
if test $? -eq 0
then ${echo} 'x - created directory `/etc'\''.'
else ${echo} 'x - failed to create directory `/etc'\''.'
  exit 1
fi
fi
if test -f '/etc/odbc.ini' && test "$first_param" != -c; then
  ${echo} 'x -SKIPPING /etc/odbc.ini (file already exists)'
else
${echo} 'x - extracting /etc/odbc.ini (text)'
  sed 's/^X//' << 'SHAR_EOF' > '/etc/odbc.ini' &&
[10G_OLD]
Driver = Oracle10gODBC
Password = cbc4736
# ServerName = (defined in /etc/tnsnames.ora)
# Located on ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
# ready on Friday 08/16/2013 - tom e.
ServerName = 10G_OLD
UserId = cbc
DSN = cbc
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
#csql "cbc;uid=cbc;pwd=cbc4736"
X
[cbc]
Driver = Oracle10gODBC
Password = cbc4736
# ServerName = (defined in /etc/tnsnames.ora)
# Located on ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
ServerName = cbcomm
UserId = cbc
DSN = cbc
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
#csql "cbc;uid=cbc;pwd=cbc4736"
X
[cbcc2ms]
Driver = Oracle10gODBC
Password = cbcc2ms4736
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = cbcomm
UserId = cbcc2ms
DSN = cbcc2ms
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
X
[blueprintc2ms]
Driver = Oracle10gODBC
Password = blueprint4736
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = cbcomm
UserId = blueprint
DSN = blueprintc2ms
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
[blueprint]
Driver = Oracle10gODBC
Password = blueprint4736
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = cbcomm
UserId = blueprint
DSN = blueprint
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
#csql "blueprint;uid=blueprint;pwd=blueprint4736"
X
[ibf]
Driver = Oracle10gODBC
Password = ibf4736
# ServerName = (defined in /etc/tnsnames.ora)
# Located on ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
ServerName = cbcomm
UserId = ibf
DSN = ibf
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
[rfgws]
Driver = Oracle10gODBC
Password = rfgws4736
# ServerName = (defined in /etc/tnsnames.ora)
# Located on ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
ServerName = cbcomm
UserId = rfgws
DSN = rfgws
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
X
[sysman]
Driver = Oracle10gODBC
Password = cybora841
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = cbcomm
UserId = sysman
DSN = sysman
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
X
[secenh]
Driver = Oracle10gODBC
Password = cbc4736
# Located on sec-enh-ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = secenh
UserId = cbc
DSN = secenh
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
[secenhibf]
Driver = Oracle10gODBC
Password = ibf4736
# Located on sec-enh-ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = secenh
UserId = ibf
DSN = secenhibf
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
[secenhblueprintc2ms]
Driver = Oracle10gODBC
Password = blueprint4736
# Located on sec-enh-ora.cbc.alpha.cyber.lan, a VM on vmpool2.cyber.lan
# ServerName = (defined in /etc/tnsnames.ora)
ServerName = secenh
UserId = blueprint
DSN = secenhblueprintc2ms
Application Attributes = T
Attributes = W
BatchAutocommitMode = IfAllSuccessful
BindAsFLOAT = F
CloseCursor = F
DisableDPM = F
DisableMTS = T
EXECSchemaOpt =
EXECSyntax = T
Failover = T
FailoverDelay = 10
FailoverRetryCount = 10
FetchBufferSize = 64000
ForceWCHAR = F
Lobs = T
Longs = T
MetadataIdDefault = F
QueryTimeout = T
ResultSets = T
SQLGetData extensions = F
Translation DLL =
Translation Option = 0
DisableRULEHint = T
X
SHAR_EOF
  (set 20 16 01 28 21 12 03 '/etc/odbc.ini'; eval "$shar_touch") &&
  chmod 0644 '/etc/odbc.ini'
if test $? -ne 0
then ${echo} 'restore of /etc/odbc.ini failed'
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} '/etc/odbc.ini: MD5 check failed'
       ) << \SHAR_EOF
115e115bc184a5792a7f00769fac79e0  /etc/odbc.ini
SHAR_EOF
  else
test `LC_ALL=C wc -c < '/etc/odbc.ini'` -ne 7011 && \
  ${echo} 'restoration warning:  size of /etc/odbc.ini is not 7011'
  fi
fi
# ============= /etc/odbcinst.ini ==============
if test ! -d '/etc'; then
  mkdir '/etc'
if test $? -eq 0
then ${echo} 'x - created directory `/etc'\''.'
else ${echo} 'x - failed to create directory `/etc'\''.'
  exit 1
fi
fi
if test -f '/etc/odbcinst.ini' && test "$first_param" != -c; then
  ${echo} 'x -SKIPPING /etc/odbcinst.ini (file already exists)'
else
${echo} 'x - extracting /etc/odbcinst.ini (text)'
  sed 's/^X//' << 'SHAR_EOF' > '/etc/odbcinst.ini' &&
# Example driver definitions
X
# Driver from the postgresql-odbc package
# Setup from the unixODBC package
[PostgreSQL]
Description	= ODBC for PostgreSQL
Driver		= /usr/lib/psqlodbc.so
Setup		= /usr/lib/libodbcpsqlS.so
Driver64	= /usr/lib64/psqlodbc.so
Setup64		= /usr/lib64/libodbcpsqlS.so
FileUsage	= 1
X
X
# Driver from the mysql-connector-odbc package
# Setup from the unixODBC package
[MySQL]
Description	= ODBC for MySQL
Driver		= /usr/lib/libmyodbc5.so
Setup		= /usr/lib/libodbcmyS.so
Driver64	= /usr/lib64/libmyodbc5.so
Setup64		= /usr/lib64/libodbcmyS.so
FileUsage	= 1
X
[Oracle10gODBC]
Description     = ODBC for Oracle 10g native
Driver      = /usr/lib/oracle/11.2/client64/lib/libsqora.so.11.1
Setup           =
FileUsage       =
CPTimeout       =
CPReuse         =
SHAR_EOF
  (set 20 16 01 28 21 32 57 '/etc/odbcinst.ini'; eval "$shar_touch") &&
  chmod 0644 '/etc/odbcinst.ini'
if test $? -ne 0
then ${echo} 'restore of /etc/odbcinst.ini failed'
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} '/etc/odbcinst.ini: MD5 check failed'
       ) << \SHAR_EOF
7a5e7c98907c21e1a85a4c10e2832816  /etc/odbcinst.ini
SHAR_EOF
  else
test `LC_ALL=C wc -c < '/etc/odbcinst.ini'` -ne 774 && \
  ${echo} 'restoration warning:  size of /etc/odbcinst.ini is not 774'
  fi
fi
# ============= /etc/tnsnames.ora ==============
if test -f '/etc/tnsnames.ora' && test "$first_param" != -c; then
  ${echo} 'x -SKIPPING /etc/tnsnames.ora (file already exists)'
else
${echo} 'x - extracting /etc/tnsnames.ora (text)'
  sed 's/^X//' << 'SHAR_EOF' > '/etc/tnsnames.ora' &&
cbcomm =
X  (DESCRIPTION =
X    (ADDRESS = (PROTOCOL = tcp)(HOST = ora.cbc.alpha.cyber.lan)(PORT = 1521))
X    (CONNECT_DATA =
X      (SID=cbcomm)
X      (SERVER = DEDICATED)
X      (SERVICE_NAME = cbcomm.alpha)
X    )
X  )
X
secenh =
X  (DESCRIPTION =
X    (ADDRESS = (PROTOCOL = tcp)(HOST = ora-sec-enh.cbc.alpha.cyber.lan)(PORT = 1521))
X    (CONNECT_DATA =
X      (SID=cbcomm)
X      (SERVER = DEDICATED)
X      (SERVICE_NAME = cbcomm.alpha)
X    )
X  )
SHAR_EOF
  (set 20 16 01 28 21 12 41 '/etc/tnsnames.ora'; eval "$shar_touch") &&
  chmod 0644 '/etc/tnsnames.ora'
if test $? -ne 0
then ${echo} 'restore of /etc/tnsnames.ora failed'
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} '/etc/tnsnames.ora: MD5 check failed'
       ) << \SHAR_EOF
109b40c00beed0cda48cdc8ea4fba0f6  /etc/tnsnames.ora
SHAR_EOF
  else
test `LC_ALL=C wc -c < '/etc/tnsnames.ora'` -ne 441 && \
  ${echo} 'restoration warning:  size of /etc/tnsnames.ora is not 441'
  fi
fi
# ============= /etc/ld.so.conf.d/oracle.conf ==============
if test ! -d '/etc/ld.so.conf.d'; then
  mkdir '/etc/ld.so.conf.d'
if test $? -eq 0
then ${echo} 'x - created directory `/etc/ld.so.conf.d'\''.'
else ${echo} 'x - failed to create directory `/etc/ld.so.conf.d'\''.'
  exit 1
fi
fi
if test -f '/etc/ld.so.conf.d/oracle.conf' && test "$first_param" != -c; then
  ${echo} 'x -SKIPPING /etc/ld.so.conf.d/oracle.conf (file already exists)'
else
${echo} 'x - extracting /etc/ld.so.conf.d/oracle.conf (text)'
  sed 's/^X//' << 'SHAR_EOF' > '/etc/ld.so.conf.d/oracle.conf' &&
/usr/lib/oracle/11.2/client64/lib/
SHAR_EOF
  (set 20 16 01 28 23 51 40 '/etc/ld.so.conf.d/oracle.conf'; eval "$shar_touch") &&
  chmod 0644 '/etc/ld.so.conf.d/oracle.conf'
if test $? -ne 0
then ${echo} 'restore of /etc/ld.so.conf.d/oracle.conf failed'
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} '/etc/ld.so.conf.d/oracle.conf: MD5 check failed'
       ) << \SHAR_EOF
02e819b584bd16e2c1bb0d34ada14ce2  /etc/ld.so.conf.d/oracle.conf
SHAR_EOF
  else
test `LC_ALL=C wc -c < '/etc/ld.so.conf.d/oracle.conf'` -ne 35 && \
  ${echo} 'restoration warning:  size of /etc/ld.so.conf.d/oracle.conf is not 35'
  fi
fi
if rm -fr ${lock_dir}
then ${echo} 'x - removed lock directory `'${lock_dir}\''.'
else ${echo} 'x - failed to remove lock directory `'${lock_dir}\''.'
  exit 1
fi
# END SHAR TO THE RESCUE

cat > /etc/profile.d/oracle.sh << EOF
NLS_DATE_FORMAT="YYYY-MM-DD"
NLS_TIMESTAMP_FORMAT="YYYY-MM-DD HH24:MI:SS.FF"
NLS_LANG="American_America.WE8ISO8859P1"
export NLS_DATE_FORMAT
export NLS_TIMESTAMP_FORMAT
export NLS_LANG
ORACLE_HOME=/usr/lib/oracle/11.2/client64
export ORACLE_HOME
PATH=\${PATH}:\${ORACLE_HOME}/bin
export PATH
EOF

# where to play
cd /tmp
mkdir -p oracle
cd oracle

# things we need
wget -q --no-clobber http://artifact.cyberitas.com/StaticProvisioning/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.x86_64.rpm
wget -q --no-clobber http://artifact.cyberitas.com/StaticProvisioning/oracle-instantclient11.2-odbc-11.2.0.3.0-1.x86_64.rpm
wget -q --no-clobber http://artifact.cyberitas.com/StaticProvisioning/oracle-instantclient11.2-jdbc-11.2.0.3.0-1.x86_64.rpm
wget -q --no-clobber http://artifact.cyberitas.com/StaticProvisioning/oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm

wget -q --no-clobber http://artifact.cyberitas.com/StaticProvisioning/php-cyberdatabase-5-20160203.el6.x86_64.rpm


# install 
rpm -i --force *.rpm

# as found on cbc alpha... sigh 
ln -s /usr/lib64/libodbcinst.so /usr/lib64/libodbcinst.so.1

ldconfig

# reload apache to take effect
apachectl restart

# cleanup
cd /tmp
rm -rf oracle
