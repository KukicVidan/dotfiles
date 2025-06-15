### HINTS

# System Commands:

> `systemctl list-units --type=service --state=running `---> Will list all active services

> `hyperctl clients `---> Will list all active windows (witch info)

> `systemctl --failed `---> Failed Systems

> `cht.sh  [INFO]`---> best TLDR and MAN in one

> `fusermount -u ~/MyServer` --> unmount server files

> `sshfs username@server_ip:/path/of/the/servers/ ~/where/in/myLocalMachine`

> `df -h` --> shows disk info

# Nvim:

> `s/SelectWhatToChange/ChangingSelectedInto?/g` ---> Will replace selected word

> `v + gc` ---> Comment multiple lines

> `ysiw` ---> Add quotes

> `SHIFT+K` ---> to see Documentation
> `C-w, w` ---> to open popup window in NVIM

# Bootable USB

> `sudo woeusb --target-filesystem NTFS --device ~/Downloads/Windows11.iso /dev/sda`

> `lsusb` ---> list usb devices
> `lsblk` ---> list storage devices
> `sudo umount /dev/sd(?)` ---> unmount if auto mounted

# Download audio from yt

ylt-dlp --extract-audio + {url of the videa}
kid3 ---> edit metadata of audiobook

# Download video from ylt

> Single Video HQ
> yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "<video-url>"

> Playlist
> yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "<playlist-url>"

# Compress video for YT

This one is CPU encoding

> ffmpeg -i "Video from davinci.mov" -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -movflags +faststart "Output_Name_YT.mp4"

This one is GPU encoding

> ffmpeg -i "Video from davinci.mov" -c:v h264_nvenc -preset p7 -cq 20 -c:a aac -b:a 160k -movflags +faststart "Output_Name_YT.mp4"
