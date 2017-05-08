#!/bin/bash

where_I_am="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

home='home/dashboard'
file_paths="$home/.config/lxsession/LXDE/autostart $home/.ssh/authorized_keys $home/bin/o3_dashboard $home/bin/reload_midori $home/.xinitrc root/autoinst/"

for file_path in $file_paths; do
    ln -s "$where_I_am/$file_path" "/$file_path"
done
