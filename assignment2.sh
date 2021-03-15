sudo lshw -class cpu > cpu.txt
sudo lshw -class memory > memory.txt
sudo fdisk -l > disks.txt
sudo lshw -class network > network.txt 

tar -Jcv -f HW_info.tar.xz cpu.txt memory.txt disks.txt network.txt

chmod 666 HW_info.tar.xz
 
