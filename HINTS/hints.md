### HINTS

# System Commands:

> `systemctl list-units --type=service --state=running `---> Will list all active services

> `hyperctl clients `---> Will list all active windows (witch info)

> `systemctl --failed `---> Failed Systems

> `cht.sh  [INFO]`---> best TLDR and MAN in one

# Nvim:

> `s/SelectWhatToChange/ChangingSelectedInto?/g` ---> Will replace selected word

> `v + gc` ---> Comment multiple lines

> `ysiw` ---> Add quotes

> `SHIFT+K` ---> to see Documentation
> `C-w, w` ---> to open popup window in NVIM

# Boostable USB

> `sudo woeusb --target-filesystem NTFS --device ~/Downloads/Windows11.iso /dev/sda`

> `lsusb` ---> list usb devices
> `lsblk` ---> list storage devices

# Download audio from yt

ylt-dlp --extract-audio + {url of the videa}
kid3 ---> edit metadata of audiobook

# Compress video for YT

This one is CPU encoding

> ffmpeg -i "Video from davinci.mov" -c:v libx264 -preset slow -crf 20 -c:a aac -b:a 160k -movflags +faststart "Output_Name_YT.mp4"

This one is GPU encoding

> ffmpeg -i "Video from davinci.mov" -c:v h264_nvenc -preset p7 -cq 20 -c:a aac -b:a 160k -movflags +faststart "Output_Name_YT.mp4"
