#!/bin/bash

TARGET_LOCALE="vzw"

# define envvars
KBUILD_BUILD_VERSION="SAMURAI.DAITO"
LOCALVERSION=".SAMURAI.DAITO"
CODENAME="DAITO"

# define vars
DATE=$(date +%m.%d.%H.%M)
COMPDATE=$(date +%a.%b.%d.%Y.%I:%M:%S.%p)
THREADS=$(expr 1 + $(grep processor /proc/cpuinfo | wc -l))
UPDATE_SCRIPT="META-INF/com/google/android"
STARTIME=

TOOLCHAIN=$PWD/arm-eabi-4.4.3/bin 
TOOLCHAIN_PREFIX=arm-eabi-

ANDROID_OUT_DIR=`pwd`/Android/out/target/product/SPH-D700

export PRJROOT=$PWD
export PROJECT_NAME
export HW_BOARD_REV

export LD_LIBRARY_PATH=.:${TOOLCHAIN}/../lib

source $PWD/functions

##############################################################
#                   MAIN FUNCTION                            #
##############################################################
  TITLE
  echo $bld$cyn" ______________________________________________________________________________ "
  echo $bld$cyn"| Please Choose Platform To Compile For...                                     |"
  echo $bld$cyn"|------------------------------------------------------------------------------|"
if [ -e Kernel/bml_mtd ] ; then
  echo $bld$grn"|  [1] Compile Kernel for Touch Wiz BML ie22                                   |"
fi
if [ -e Kernel/bml_mtd ] ; then
  echo $bld$grn"|  [2] Compile Kernel for Touch Wiz BML el30                                   |"
fi
if [ -e Kernel/bml_mtd ] ; then
  echo $bld$grn"|  [3] Compile Kernel for Touch Wiz MTD                                        |"
fi
if [ -e Kernel/cm7_miui ] ; then
  echo $bld$grn"|  [4] Compile Kernel for MIUI MTD                                             |"
fi
if [ -e Kernel/cm7_miui ] ; then
  echo $bld$grn"|  [7] Compile Kernel for CM7 MTD                                              |"
fi
if [ -e Kernel/cm9 ] ; then
  echo $bld$grn"|  [9] Compile Kernel for CM9 MTD                                              |"
fi
if [ -e Kernel/cm9 ] ; then
  echo $bld$grn"|  [m4] Compile Kernel for MIUIv4 MTD                                          |"
fi
  echo $bld$cyn"|------------------------------------------------------------------------------|"
  echo $bld$grn"|  [G] Git Helper Menu                                                         |"
  echo $bld$grn"|  [X] Exit Build Helper                                                       |"
  echo $bld$cyn"|------------------------------------------------------------------------------|"
  echo $bld$grn"| WORKING DIR    : $PWD" 
    REPO=$(basename $PWD)
    echo $bld$grn"| CURRENT REPO   : $REPO"
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo $bld$grn"| CURRENT BRANCH : $CURRENT_BRANCH" 
    echo $bld$cyn"|______________________________________________________________________________|"$bld$grn
  read -p "  ENTER MENU OPTION : " compile
  case "$compile" in
  #Compile Kernel for Touch Wiz BML ei22
    "1" )
if [ -e Kernel/bml_mtd ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_bml_ei22_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      KERNEL_INITRD="$PWD/initramfs/initramfs_ei22"
      BUILD_OUT="$PWD/out/bml_ei22_out"
      BUILD_PLATFORM="BML.EI22"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
      #BUILD Layout
      VARIABLES
      MAKE_CLEAN
    #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      UPDATE_CWMSCRIPT
      PACKAGE_BML_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for Touch Wiz BML el30
    "2" )
if [ -e Kernel/bml_mtd ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_bml_el30_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      KERNEL_INITRD="$PWD/initramfs/initramfs_el30"
      BUILD_OUT="$PWD/out/bml_el30_out"
      BUILD_PLATFORM="BML.EL30"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      UPDATE_CWMSCRIPT
      PACKAGE_BML_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for Touch Wiz MTD
    "3" )
if [ -e Kernel/bml_mtd ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_mtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd_otg"
      RECOVERY_INITRD="$PWD/recovery/recovery_mtd"
      KERNEL_INITRD="$PWD/initramfs/firstStage"
      BUILD_OUT="$PWD/out/mtd_out"
      BUILD_PLATFORM="TW.MTD"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for MIUI MTD
    "4" )
if [ -e Kernel/cm7_miui ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_mtd_miui_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/cm7_miui"
      RECOVERY_INITRD="$PWD/recovery/recovery_miui"
      KERNEL_INITRD="$PWD/initramfs/initramfs_miui"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
      BUILD_OUT="$PWD/out/miui_out"
      BUILD_PLATFORM="MIUI.MTD"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for Touch Wiz BML el30
    "5" )
if [ -e Kernel/bml_mtd ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_bml_el30_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd"
      KERNEL_INITRD="$PWD/initramfs/initramfs_el30"
      BUILD_OUT="$PWD/out/bml_fc09_out"
      BUILD_PLATFORM="BML.FC09"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      UPDATE_CWMSCRIPT
      PACKAGE_BML_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for Touch Wiz MTD
    "6" )
if [ -e Kernel/bml_mtd ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=cleangb_mtd_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/bml_mtd_otg"
      RECOVERY_INITRD="$PWD/recovery/recovery_mtd"
      KERNEL_INITRD="$PWD/initramfs/firstStage"
      BUILD_OUT="$PWD/out/fc09_mtd_out"
      BUILD_PLATFORM="MTD.FC09"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for CM7 MTD
    "7" )
if [ -e Kernel/cm7_miui ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_mtd_cm7_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/cm7_miui"
      RECOVERY_INITRD="$PWD/recovery/recovery_cm7"
      KERNEL_INITRD="$PWD/initramfs/initramfs_cm7"
      BUILD_OUT="$PWD/out/cm7_out"
      BUILD_PLATFORM="CM7.MTD"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG "$KERNEL_PATH" "$KERNEL_INITRD" "$RECOVERY_INITRD"
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for CM9 MTD
    "9" )
if [ -e Kernel/cm9 ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_mtd_cm9_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/cm9"
      RECOVERY_INITRD="$PWD/recovery/recovery_cm9"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_cm9"
      BUILD_OUT="$PWD/out/cm9_out"
      BUILD_PLATFORM="CM9.OTG"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG_CM9
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
  #Compile Kernel for MIUIv4 MTD
    "m4" )
if [ -e Kernel/cm9 ] ; then
    #Platform Specific Variables
      DEFCONFIG_STRING=samurai_mtd_miuiv4_defconfig
      KERNEL_BUILD_DIR="$PWD/Kernel/cm9"
      RECOVERY_INITRD="$PWD/recovery/recovery_cm9"
      KERNEL_INITRD="$KERNEL_BUILD_DIR/usr/initramfs_cm9"
      BUILD_OUT="$PWD/out/miuiv4_out"
      BUILD_PLATFORM="MIUI.v4"
      ZIMAGE_ARG="$LOCALVERSION.$BUILD_PLATFORM.$DATE"
    #BUILD Layout
      VARIABLES
      MAKE_CLEAN
      #BUILD_MODULE
      CLEAN_ZIMAGE
      START_TIME=`date +%s`
      BUILD_KERNEL
      PACKAGE_BOOTIMG_CM9
      UPDATE_CWMSCRIPT
      PACKAGE_MTD_CWMFLASHABLE
      tput setaf 2
      read -p "Press [Enter] key to continue..."
      ./build_kernel.sh
else
      INVALID
fi
;;
    "G" | "g" )
    #Git Helper Menu
      GIT_HELPER
    ;;
    "X" | "x" )
      echo $rst
      exit	
    ;;
    * )
      INVALID
    ;;
  esac

