#!/bin/bash
# Hold control and click this file, then select "Open"
# Or copy and paste the below into terminal 

clear && \
printf 'Hi there!\n\n' && sleep 1 && \
printf 'We will now force the OS to purge all purgeable files.\n' && sleep 3 && \
printf 'This could take a few minutes, depending on the speed of your disk. \n\n' && sleep 3 && \
printf 'To be safe, save any open documents and quit running applications now.\n\n' && sleep 3 && \
printf 'Once your disk is nearly full, you might see the following dialog box:\n\"Your Disk space is critically low.\"\n\n' && sleep 3 && \
printf 'This is normal.\n\n' && sleep 3 && \
startspace=$(($(df -m / | awk 'int($4){print $4}') * 1024 * 1024 / 1000000000)) && \
printf 'You currently have '$startspace' GB of available space.\n\n' && sleep 1 && \
printf 'If you need to interrupt this process, press: control+c\n\n' && sleep 3 && \
printf 'Creating folder "ClearPurgeableSpace" on desktop... \t' && \
mkdir -p ~/Desktop/ClearPurgeableSpace && \
printf 'Done\n' && printf 'Creating temporary large files... \t' && \
mkfile 4G ~/Desktop/ClearPurgeableSpace/largefile4G && mkfile 500M ~/Desktop/ClearPurgeableSpace/largefile500M && mkfile 100M ~/Desktop/ClearPurgeableSpace/largefile100M && \
printf 'Done\n\n' && printf 'Now filling up available space... \n\n' && 
diskspace=$(($(df -m / | awk 'int($4){print $4}') * 1024 * 1024 / 1000000)) && diskspace_new=0 && \
while [ 0 ]
do
if [ $diskspace_new -gt $diskspace ]
then printf '\nApprox '$(($diskspace_new - $diskspace))' MB of purgeable space was just cleared! Continuing...\n\n'
fi
diskspace=$(($(df -m / | awk 'int($4){print $4}') * 1024 * 1024 / 1000000)) && printf $diskspace' MB remaining, please wait...\n'
if [ 8000 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile4G{," $(date +%s%N)"} && sleep 1 && waiting=0
elif [ 2000 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile500M{," $(date +%s%N)"} && sleep 1 && waiting=0
elif [ 800 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile100M{," $(date +%s%N)"} && sleep 1 && waiting=0
elif [ 500 -lt $diskspace ]
then cp ~/Desktop/ClearPurgeableSpace/largefile100M{," $(date +%s%N)"} && sleep 1 && waiting=1
elif [ $waiting -eq 1 ]
then printf '\nPausing for 5 seconds to give OS time to purge, please wait...\n\n' && sleep 5 && waiting=2
elif [ $waiting -eq 2 ]
then printf '\nPausing for 10 seconds to give OS time to purge, please wait...\n\n' && sleep 10 && waiting=3
elif [ $waiting -eq 3 ]
then printf '\nPausing for 30 seconds to give OS time to purge, please wait...\n\n' && sleep 30 && waiting=4
else break
fi
diskspace_new=$(($(df -m / | awk 'int($4){print $4}') * 1024 * 1024 / 1000000))
done && \
printf '\nPurging complete.\n\nClearing temporary files...\n' && \
rm -R ~/Desktop/ClearPurgeableSpace && \
printf 'All done! Your disk space has been reclaimed.\n\n' && \
endspace=$(($(df -m / | awk 'int($4){print $4}') * 1024 * 1024 / 1000000000)) && \
printf 'You just recovered '$(($endspace - $startspace))' GB!\n\n' && sleep 2 && \
printf 'You now have '$endspace' GB of free space.\n\n' && sleep 2 && \
printf 'Goodbye!\n\n\n\n\n';
