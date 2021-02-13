# ClearPurgeableFiles
Delete / clear purgeable files to recover disk space on Mac. 

Running out of disk space on your Mac and need extra space? If you check your available storage in Disk Utility, you'll see that there will be some GBs of "purgeable" data. 
There doesn't seem to be any other way to reclaim purgeable disk space on a Mac apart from letting the system automatically purge when it sees fit. 

Therefore, this script will automatically fill your disk with temporary large files, stored in a folder on your desktop (for easy deletion in case you interrupt the script). 

To be safe, save any open documents and quit running applications before use. Once your disk is nearly full, you might see the following dialog box: "Your Disk space is critically low."
This is normal. 

As the disk fills up, the script will slow down in order to give the system time to purge. Note that the runtime can take up to an hour or even longer, especially if you have a slow disk, or a lot of free space. 
