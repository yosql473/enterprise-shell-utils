# shiftBackup-1.0.0  快速备份工具

root@zsxcp:/home/zsx/shellWorkspace# tree shiftBackup-1.0.0/
shiftBackup-1.0.0/
├── shiftBackup.config - 用于一键备份的配置文件
└── shiftBackup.sh - shell工具

首先你需要使用shiftBackup.config中做如下配置:
#格式为: <别名>   <需要备份的目录>   (<备份成的文件绝对路径>)
root@zsxcp:/home/zsx/shellWorkspace# cat shiftBackup-1.0.0/shiftBackup.config 
project1   /home/zsx/shellWorkspace/project1
project2   /home/zsx/shellWorkspace/project2
project3  /home/zsx/shellWorkspace/project3	/home/zsx/shellWorkspace/project3.tar.gz
如上分别为三个例子.

如何去使用呢?
主要有--detect以及-z两个参数
1.--detect 可以检查当前路径是否在配置文件的<需要备份的目录>一列中,如果有就会进行备份
2.-z 是否使用压缩

例如:
1.在/home/zsx/shellWorkspace/project1 项目目录下使用 shiftBackup.sh --detect
root@zsxcp:/home/zsx/shellWorkspace/project1# ../shiftBackup-1.0.0/shiftBackup.sh --detect
-----------------------------------------------
 Enterprise Shell Utils 1.0.0
 Welcome to backup something using ShiftBackup.
 Author:yosql473  Version:shiftBackup-1.0.0
-----------------------------------------------
[INFO] tar -cf /home/zsx/shellWorkspace/project1-2018091413451536903936.tar /home/zsx/shellWorkspace/project1
[WARN] You'd better use absolute path:
tar: 从成员名中删除开头的“/”
[INFO] Done.
如果没有指定位置,默认会在项目目录的父目录中创建:
root@zsxcp:/home/zsx/shellWorkspace/project1# cd ..
root@zsxcp:/home/zsx/shellWorkspace# ls
ESU-1.0.0  project1-2018091413451536903936.tar  project3
project1   project2                             shiftBackup-1.0.0
