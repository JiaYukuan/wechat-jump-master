function [ im ] = read_image(num)
system("cd /Program Files (x86)/MuMu/emulator/nemu/vmonitor/bin && adb_server shell screencap -p /sdcard/autojump.png");
system("cd /Program Files (x86)/MuMu/emulator/nemu/vmonitor/bin && adb_server pull /sdcard/autojump.png /Users/jyk19/Desktop/Jump_no_stop/ssproject_jumper/my_work");
system("cd /Program Files (x86)/MuMu/emulator/nemu/vmonitor/bin && adb_server pull /sdcard/autojump.png /Users/jyk19/Desktop/Jump_no_stop/ssproject_jumper/my_work/jump"+int2str(num)+".png");

%system("cd /Program Files/Genymobile/Genymotion/tools && adb.exe shell screencap -p /sdcard/autojump.png");
%system("cd /Program Files/Genymobile/Genymotion/tools && adb.exe pull /sdcard/autojump.png /Users/jyk19/Desktop/Jump_no_stop/ssproject_jumper/my_work/");

%system("cd /Program Files/Genymobile/Genymotion/tools && adb.exe pull /sdcard/autojump.png /Users/jyk19/Desktop/Jump_no_stop/ssproject_jumper/my_work/jump"+int2str(num)+".png");

im = imread('autojump.png');
end