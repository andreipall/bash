#!/bin/bash
xfconf-query --channel thunar -p /misc-show-delete-action -t 'bool' -s true --create
xfconf-query --channel xfce4-desktop -p /desktop-menu/show -t 'bool' -s false --create
xfconf-query --channel xfce4-desktop -p /windowlist-menu/show -t 'bool' -s false --create
xfconf-query --channel xfce4-notifyd -p /notify-location -t string -s bottom-right --create
xfconf-query --channel xfce4-panel -p /panels -a -t int -s 1 --create
xfconf-query --channel xfce4-panel -p /panels/panel-2 -r -R
xfconf-query --channel xfce4-panel -p /panels/dark-mode -s false
xfconf-query --channel xfce4-panel -p /panels/panel-1/plugin-ids -a -t int -s 1 -t int -s 4 -t int -s 5 -t int -s 7 -t int -s 14 -t int -s 2 -t int -s 3 -t int -s 6 -t int -s 8 -t int -s 9 -t int -s 10 -t int -s 11 -t int -s 12 -t int -s 13 --create
xfconf-query --channel xfce4-panel -p /panels/panel-1/position -t string -s 'p=8;x=960;y=1055'
xfconf-query --channel xfce4-panel -p /panels/panel-1/position-locked -s true
xfconf-query --channel xfce4-panel -p /panels/panel-1/size -t int -s 26
xfconf-query --channel xfce4-panel -p /plugins -r -R
xfconf-query --channel xfce4-panel -p /plugins/plugin-1 -t string -s 'applicationsmenu' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-9 -t string -s 'notification-plugin' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-10 -t string -s 'separator' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-10/style -t int -s 0 --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-11 -t string -s 'clock' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-11/digital-date-font -t string -s 'Noto Sans 8' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-11/digital-time-font -t string -s 'Noto Sans 8' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-12 -t string -s 'separator' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-12/style -t int -s 0 --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-13 -t string -s 'actions' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-14 -t string -s 'launcher' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-14/items -a -t string -s 'chromium.desktop' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-1/button-title -t string -s 'Start' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-2 -t string -s 'tasklist' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-2/grouping -t 'bool' -s false --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-2/sort-order -t int -s 4 --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-2/window-scrolling -t 'bool' -s false --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-3 -t string -s 'separator' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-3/expand -t 'bool' -s true --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-3/style -t int -s 0 --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-4 -t string -s 'showdesktop' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-5 -t string -s 'launcher' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-5/items -a -t string -s 'xfce4-file-manager.desktop' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-6 -t string -s 'systray' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-6/square-icons -t 'bool' -s true --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-7 -t string -s 'launcher' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-7/items -a -t string -s 'xfce4-terminal.desktop' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-8 -t string -s 'pulseaudio' --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-8/enable-keyboard-shortcuts -t 'bool' -s true --create
xfconf-query --channel xfce4-panel -p /plugins/plugin-8/show-notifications -t 'bool' -s true --create
xfconf-query --channel xfce4-session -p /general/SaveOnExit -t 'bool' -s false --create
xfconf-query --channel xfce4-terminal -p /background-darkness -t double -s 1.000000 --create
xfconf-query --channel xfce4-terminal -p /background-mode -t string -s TERMINAL_BACKGROUND_TRANSPARENT --create
xfconf-query --channel xfce4-terminal -p /font-use-system -t 'bool' -s true --create
xfconf-query --channel xfwm4 -p /general/workspace_count -t int -s 1
xfconf-query --channel xfwm4 -p /general/title_font -t string -s 'Noto Sans Bold 9'
xfconf-query --channel xfwm4 -p /general/theme -t string -s 'Qogir'
xfconf-query --channel xsettings -p /Gtk/FontName -t string -s 'Noto Sans 9'
xfconf-query --channel xsettings -p /Gtk/MonospaceFontName -t string -s 'Noto Sans Mono 9'
xfconf-query --channel xsettings -p /Net/IconThemeName -t string -s 'Qogir'
xfconf-query --channel xsettings -p /Net/ThemeName -t string -s 'Qogir'
xfconf-query --channel xsettings -p /Xft/Antialias -t int -s 1
xfconf-query --channel xsettings -p /Xft/DPI -t int -s -1 --create
xfconf-query --channel xsettings -p /Xft/Hinting -t int -s -1
xfconf-query --channel xsettings -p /Xft/HintStyle -t string -s 'hintfull'
xfconf-query --channel xsettings -p /Xft/RGBA -t string -s 'rgb'
xfconf-query --channel parole -p /audio/volume -t int -s 100 --create
xfconf-query --channel parole -p /playlist/play-opened-files -t 'bool' -s false --create
xfconf-query --channel parole -p /subtitles/enabled -t 'bool' -s false --create
xfconf-query --channel parole -p /subtitles/font -t string -s 'Noto Sans Bold 12' --create
xfce4-panel -r
