Ganbarou Tools
======================================================================================================
My tools and files used to build a CM10.1 based Ganbarou ROM for Samsung Galaxy Tab 10.1 and Galaxy Note
------------------------------------------------------------------------------------------------------
In <https://github.com/beegee-tokyo/ganbarou-jb/blob/master/README.md> you can find a description of the batch files 
and how to build the Ganbarou ROM by yourself.    
     
create_links.sh copies/links all files in tools to the place they are needed.    

In tools:
---------    
All batch files that are used to make the ROMs. Need to be copied as link to the top build directory    
Copy of roomservice.xml and changelog.txt    

custom squisher (*** squisher is no longer used by the CM build tools ***)     
- out file name changed to cm-base_for_ganbarou.zip for easier post-processing in ganbarou.sh
- removed creation of md5 checksum because this will be done in the post-processing    
    
In patches
----------
bootanimation-p
- custom bootanimation for GT-N7000

bootanimation-t
- custom bootanimation for GT-P75xx

data
- custom apps files for GT-P75xx

datap
- custom apps files for GT-N7000

ganbarou/etc
- custom hosts and gps.conf files for Ganbarou ROMs

gapps
- gapps files

systemapp-p
- Softbank MMS for the phone ROM
