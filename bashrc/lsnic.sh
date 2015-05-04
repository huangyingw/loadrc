#! /bin/bash

#******************************************************************************
#  Copyright(c) 1999 - 2008 Intel Corporation.
#
#  This program is free software; you can redistribute it and/or modify it
#  under the terms and conditions of the GNU General Public License,
#  version 2, as published by the Free Software Foundation.
#
#  This program is distributed in the hope it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
#
#  Contact Information:
#  Linux NICS <linux.nics@intel.com>
#  Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
#******************************************************************************

#Determine how many Ethernet & Network controllers are installed in the system
TotalControllers=`lspci | grep -c -i 'Ethernet Controller\|Network Controller'`

temp=`lspci | grep -i 'Ethernet Controller\|Network Controller'|cut -f1 -d " "`

#Define two arrays for storing IPPorts
declare -a IOPorts1
declare -a IOPorts2

#Populate IOPorts1 with bus info from lspci.  Populate IoPorts2 with bus info
#from ethtool.

for (( counter=0 ; counter < $TotalControllers ; counter++ ))
do
  offset=$(($counter+1))
  IOPorts1[$counter]=`echo $temp|cut -f$offset -d" "`
  if (ethtool -i eth$counter) &> /dev/null; then
    IOPorts2[$counter]=`ethtool -i eth$counter|grep 'bus-info'|cut -f3- -d :`
  fi
done

#Loop through both arrays and determine if there's a match in IOPort1 & IOPort2.  If so
#then the driver is loaded, and write to screen all the related information.  If there
#is no match then there isn't a driver loaded for that device and write to screen only
#the information available from lspci

for ((counter=0 ; counter < $TotalControllers ; counter++))
do
  Match=0
  for ((counter1=0 ; counter1 < $TotalControllers; counter1++))
  do              
    if [ "${IOPorts1[$counter]}" = "${IOPorts2[$counter1]}" ]; then
      Match=1                                 
      DeviceID=`lspci -nn | grep ${IOPorts2[$counter1]} |cut -f3- -d"["| cut -c 1-9`
      EthernetController=`lspci -v |grep ${IOPorts2[$counter1]} | cut -f4- -d" "|cut -f1 -d"("`
      AdapterName=`lspci -v | grep ${IOPorts2[$counter1]} -A 1 | grep 'Subsystem'|cut -f2- -d" "`
      DriverName=`ethtool -i eth$counter1 | grep -i 'driver' | cut -f2 -d" "`
      DriverVersion=`ethtool -i eth$counter1 | grep -m 1 -i 'version'| cut -f2 -d" "`
      echo "eth$counter1 : ${IOPorts2[$counter1]}"
      echo "    Make/Model = $AdapterName"
      echo "    Ethernet controller = $EthernetController"
      echo "    VenID:DevID = $DeviceID"
      echo "    Driver name = $DriverName"
      echo "    Driver version = $DriverVersion"
    fi
  done
  if [ "$Match" = "0" ] ; then
    DeviceID=`lspci -nn | grep ${IOPorts1[$counter]} |cut -f3- -d"["| cut -c 1-9`
    EthernetController=`lspci -v |grep ${IOPorts1[$counter]} | cut -f4- -d" "|cut -f1 -d"("`
    AdapterName=`lspci -v | grep ${IOPorts1[$counter]} -A 1 | grep 'Subsystem'|cut -f2- -d" "`
    echo ": ${IOPorts1[$counter]}"
    echo "    Make/Model = $AdapterName"
    echo "    Ethernet controller = $EthernetController"
    echo "    VenID:DevID = $DeviceID"
    echo "    Driver name = No driver loaded"
    echo "    Driver version = No driver loaded"
  fi
done
exit 0

