#! /bin/bash

RSYNCSOURCE=/pcc/cnbuild/build/output/vmo.isf2_1_pudong_drop2/
mainsource=/pcc/cnbuild/build/output/vmo.mainline/
localmain=/media/volgrp/software/work/platform/cnbuild/vmo.mainline/
BASEDIR=/media/volgrp/software/work/platform/cnbuild/vmo.isf2_1_pudong_drop2/
heilongjiangsource="/pcc/cnbuild/build/output/vmo.isf2_1_heilongjiang"
heilongjianglocal="/media/volgrp/software/work/platform/cnbuild/build/output/vmo.isf2_1_heilongjiang/"

# check to see if script is already running
PDIR=${0%`basename $0`}
LCK_FILE=`basename $0`.lck

if [ -f "${LCK_FILE}" ]; then
  MYPID=`head -n 1 "${LCK_FILE}"`

  TEST_RUNNING=`ps -p ${MYPID} | grep ${MYPID}`

  if [ -z "${TEST_RUNNING}" ]; then
    # The process is not running
    # Echo current PID into lock file
    echo $$ > "${LCK_FILE}"
    rsync -ahHv --log-file=/root/rlog --delete-after ${mainsource} ${localmain}
    rsync -ahHv --log-file=/root/rlog --delete-after ${RSYNCSOURCE} ${BASEDIR}
    rsync -ahHv --log-file=/root/rlog --delete-after ${heilongjiangsource} ${heilongjianglocal}
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/etc/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/etc/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/lib/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/lib/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/bin/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86/bin/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/bin/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/bin/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/etc/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/etc/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/lib/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/linux2.6-glibc2.3-x86_64/lib/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/etc/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/etc/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/bin/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/bin/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/lib/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x86/lib/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/etc/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/etc/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/bin/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/bin/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/lib/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/egoagent/2.0/win-x64/lib/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/3rdparty/jdk/1.5.0_08/linux-x86/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/3rdparty/jdk/1.5.0_08/linux-x86/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/app/Linux_jdk1.5.0_08_x86/ /media/volgrp/myproject/git/work/platform/pcc/app/Linux_jdk1.5.0_08_x86/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/perf_ext/shared/isf2_1_pudong_drop_2/  /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/perf_ext/shared/isf2_1_pudong_drop_2/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/app/apache-ant-1.6.0/  /media/volgrp/myproject/git/work/platform/pcc/app/apache-ant-1.6.0/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/perf_ext/shared/Excalibur/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/perf_ext/shared/Excalibur/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/cnbuild/build/output/RTM2.0_SS_POC/ /media/volgrp/software/work/platform/cnbuild/build/output/RTM2.0_SS_POC/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/vmo_monte_ext/shared/mainline/ /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/vmo_monte_ext/shared/mainline/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/lsfqa-trusted/Standard_Code/license/     /media/volgrp/myproject/git/work/platform/pcc/lsfqa-trusted/Standard_Code/license/
    rsync --log-file=/root/rlog -aH --delete-after \
      /pcc/cnbuild/build/output/vmo.ISF_2_2_SZSC/ /media/volgrp/software/work/platform/cnbuild/vmo.ISF_2_2_SZSC/
  else
    # the process IS running
    # handle it
    echo this process is running
    exit 0
  fi
else
  echo $$ > "${LCK_FILE}"
fi
