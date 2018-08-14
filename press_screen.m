function [] = press_screen(dis)
% Change 'platform-tools-windows' to 'platform-tools-macos' and 'adb.exe' to './adb' on macOS; you may need to use `chmod +X ../dependency/platform-tools-macos/adb` first
press_time = floor(dis * 1.392);
string = "cd /Program Files (x86)/MuMu/emulator/nemu/vmonitor/bin && adb_server shell input swipe 500 500 500 500 " + int2str(press_time);
system(string);
end