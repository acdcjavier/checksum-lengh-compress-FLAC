# checksum-lengh-compress-FLAC
add checksum st5, total duration lengh and compress for flac files

This script is ideal for your album lossless FLAC files

Before running the script, you must first install shntool, flac, exiftool and lz4

sudo apt-get install shntool
sudo apt-get install flac
sudo apt-get install exiftool
sudo apt-get install lz4

The script file should be inside the folder where all your lossless audio folders are located.
To run the script you just have to run it like this in the terminal.

./menuv2.sh

And then a menu with 4 options will appear and you can choose one of them, pressing 1, 2, 3 or 4 in your keyboard and press enter:


1) st5 checksum
2) calulate lengh [Total Minutes.Total Seconds]
3) lz4 compression/decompression/Verify
4) All-in-one (Checksum + lengh + compression tar.lz4)


st5 checksum:

The script will navigate in each folder and look for all the FLAC files within them and through shntool, it will create a checksum.st5 file with the hashes of all your FLAC files. Later, you can check with TLH if it works.

calulate lengh [Total Minutes.Total Seconds]:

The script will navigate in each folder and look for all the FLAC files and calculate the total bootlegs duration in [total minutes.total seconds] format also using the shntool tool.
When the script has calculated the total duration, the script will rename the bootleg folder and append the total duration at the end of the name.
This is very useful for those who have different sources of the same concert and you can compare it with the almost exact duration of each one of them.

For example:

Before execute script:

Quote:
1985-01-19 - Rockdrome, Rio de Janeiro, Brazil [FLAC]

After execute script:

1985-01-19 - Rockdrome, Rio de Janeiro, Brazil [FLAC][75.35]
In this case, the bootlegs has duration 75 minutes and 35 seconds.


lz4 compression/decompression/Verify

This option is optional. The lz4 compression is a new algorithm that unlike others known as .rar or .zip, this is much faster both for compressing and decompressing files. Unfortunately, lz4 cannot compress folders, it can only compress files. To compress a folder in lz4, first, the folder must be compressed in a .tar format, which transforms the folder into a single file, then the .tar file is compressed in lz4 format.

For me, it is much easier to manage my bootlegs in files instead of folders, in addition the lz4 can reduce the size of the folder and is very useful for making backups to hard drives or limited storage.

The script will take each of the folders and transform them into .tar.lz4 format. Furthermore, the script can unzip and verify its integrity.

All-in-one (Checksum + lengh + compression tar.lz4)

In this case, the script will carry out all the previous steps, ideal for those who have a large list of audios and want to sort them automatically, and which also includes compressing in tar.lz4


POSSIBLES ISSUES:

During the creation of the script, I have noticed some errors that I have discovered, not only the script, but also the limitation of the programs that I use to analyze the files:

1.- The shntool program cannot create st5 checksum to FLAC files that are recorded in 24bits / 96k format, it only works in 16bit in FLAC formats. I programmed the script that if it finds FLAC files with 24bits format, the shntool will create an empty checksum.st5 and it will be deleted automatically.

2.- Also, shntool cannot determine the duration of the FLAC files in 24 bits, for this case, the script will execute another program called exiftool, which will determine the duration of the FLAC files and calculate the total duration of the bootleg.

3.- In the event that the total duration of the audio appears as [0.0] then, the metadata of the duration of the flac files may be corrupted, for this you must rebuild the flac files again to repair the metadata, on the web there is various information how to repair them.

Any modifications I make to this script, I will add it to my github repository, and later the update will be added here.

Of course, I accept all the modifications of people who know the subject and that we can improve this script for the help of the community.


Please if you want to test this script, make a backup of some bootlegs and check the script there, if you like the results, you can apply them to all other audios.
