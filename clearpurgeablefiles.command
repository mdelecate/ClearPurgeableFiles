#!/bin/bash

clear && \
printf 'Hi there!\n\n' && sleep 1 && \
printf 'We will now force the OS to purge all purgeable files.\n' && sleep 3 && \
printf 'This could take a few minutes, depending on the speed of your disk. \n\n' && sleep 3 && \
printf 'To be safe, please save all open documents and quit all running applications now.\n\n' && sleep 3 && \
printf 'Once your disk is nearly full, you might see the following dialog box:\n\"Your Disk space is critically low.\"\n\n' && sleep 3 && \
printf 'This is normal.\n\n' && sleep 3 && \
startspace_str=$(df -H / | awk 'int($4){print $4}') && startspace_int=${startspace_str%?} && \
printf 'You currently have '$startspace_int'G of available space.\n\n' && sleep 1 && \
printf 'If you need to interrupt this process, press: control+c\n\n' && sleep 3 && \
printf 'Creating folder "ClearPurgeableSpace" on desktop... \t' && \
mkdir -p ~/Desktop/ClearPurgeableSpace && \
printf 'Done\n' && printf 'Creating temporary large files... \t' && \
mkfile 4G ~/Desktop/ClearPurgeableSpace/largefile4G && mkfile 500M ~/Desktop/ClearPurgeableSpace/largefile500M && mkfile 100M ~/Desktop/ClearPurgeableSpace/largefile100M && \
printf 'Done\n' && printf 'Duplicating large files to fill up available space... \n' && 
diskspace=$(df -m / | awk 'int($4){print $4}') && \
while [ 0 ]
do
diskspace=$(df -m / | awk 'int($4){print $4}') && df -m / | awk 'FNR == 2 {print $4"M remaining.\n"}'
if [ 8000 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile4G{,"$(date)"} && sleep 1
elif [ 2000 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile500M{,"$(date)"} && sleep 1
elif [ 1000 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile100M{,"$(date)"} && sleep 1
elif [ 500 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile100M{,"$(date)"} && printf 'Pausing for 20 seconds to give OS time to purge, please wait...\n\n' && sleep 20
else break
fi
done && \
printf 'All available space has now been filled.\n\nClearing temporary files to reclaim disk space...\n' && \
rm -R ~/Desktop/ClearPurgeableSpace && \
printf 'All done! Your disk space has been reclaimed.\n\n' && \
endspace_str=$(df -H / | awk 'int($4){print $4}') && endspace_int=${endspace_str%?} && \
printf 'You just recovered '$(($endspace_int - $startspace_int))'G!\n\n' && sleep 2 && \
printf 'You now have '$endspace_int'G of available space.\n\n' && sleep 2 && \
printf 'Goodbye!\n\n\n\n\n';
