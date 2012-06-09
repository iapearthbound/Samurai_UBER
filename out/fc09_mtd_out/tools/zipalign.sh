#!/sbin/busybox sh
# Automatic ZipAlign by Wes Garner
# Modified by zman0900 for /system
# ZipAlign files in /system that have not been previously ZipAligned (using -c 4)

LOG_FILE=/sdcard/zipalign_system.log
    if [ -e $LOG_FILE ]; then
    	rm $LOG_FILE;
    fi;
    	
echo "Starting Automatic ZipAlign $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;
    for apk in /system/app/*.apk ; do
	/system/xbin/zipalign -c 4 $apk;
	ZIPCHECK=$?;
	if [ $ZIPCHECK -eq 1 ]; then
		echo ZipAligning $(basename $apk)  | tee -a $LOG_FILE;
		/system/xbin/zipalign -f 4 $apk /cache/$(basename $apk);
			if [ -e /cache/$(basename $apk) ]; then
				mv -f /cache/$(basename $apk) $apk  | tee -a $LOG_FILE;
				chown root:root $apk  | tee -a $LOG_FILE;
				chmod 644 $apk  | tee -a $LOG_FILE;
			else
				echo ZipAligning $(basename $apk) Failed  | tee -a $LOG_FILE;
			fi;
	else
		echo ZipAlign already completed on $apk  | tee -a $LOG_FILE;
	fi;
       done;
echo "Automatic ZipAlign finished at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;

