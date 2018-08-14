function [] = get_screenshot(num)

system("cd /Program Files/Genymobile/Genymotion/tools && adb.exe shell screencap -p /sdcard/autojump.png");
system("cd /Program Files/Genymobile/Genymotion/tools && adb.exe pull /sdcard/autojump.png /Users/jyk19/Desktop/Jump_no_stop/ssproject_jumper/my_work/screenshot" + int2str(num) + ".png");

end

