{ lib, ... }:
let
  workspaceIndicies = [ 1 2 3 4 5 6 7 8 9 10 ];

  mappings = mod: ''
    set $mod ${mod}

    ${nixpkgs.lib.concatMapStrings
	(i : "set $ws${builtins.toString i}\nbindsym $mod+${builtins.toString i} workspace number $ws${builtins.toString i}\nbindsym $mod+Shift+${builtins.toString i} move container to workspace number $ws${builtins.toString i}\n")
	workspaceIndicies}

    # Change focus.
	bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # Move focused windows.
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right
    
    # split in horizontal orientation
    bindsym $mod+slash split h
    
    # split in vertical orientation
    bindsym $mod+backslash split v
    
    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle
    
    # change container layout (stacked, tabbed, toggle split)
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split
    
    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle
    
    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle
    
    # focus the parent container
    bindsym $mod+a focus parent
    
    # focus the child container
    #bindsym $mod+d focus child

	# reload the configuration file
    bindsym $mod+Shift+c reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart
    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

	bindsym $mod+r mode "resize"

	# Lock screen when $mode+l is pressed.
    bindsym $mod+Control+l exec --no-startup-id systemctl suspend, mode "default"
  '';

  resizing = ''
    # These bindings trigger as soon as you enter the resize mode
 
    # Pressing left will shrink the window’s width.
    # Pressing right will grow the window’s width.
    # Pressing up will shrink the window’s height.
    # Pressing down will grow the window’s height.
    bindsym j resize shrink width 10 px or 10 ppt
    bindsym k resize grow height 10 px or 10 ppt
    bindsym l resize shrink height 10 px or 10 ppt
    bindsym semicolon resize grow width 10 px or 10 ppt
 
    # same bindings, but for the arrow keys
    bindsym Left resize shrink width 10 px or 10 ppt
    bindsym Down resize grow height 10 px or 10 ppt
    bindsym Up resize shrink height 10 px or 10 ppt
    bindsym Right resize grow width 10 px or 10 ppt
 
    # back to normal: Enter or Escape or $mod+r
    bindsym Return mode "default"
    bindsym Escape mode "default"
    bindsym $mod+r mode "default"
  '';

  autostart = ''
    # Autostart xfce4-power-manager when i3 is loaded.
    exec_always --no-startup-id /usr/bin/xfce4-power-manager
    
    # Autostart light-locker when i3 is loaded.
    exec_always --no-startup-id /usr/bin/light-locker --lock-on-lid --lock-on-suspend
  '';
in
writeText "i3-config" ''
	${mappings "Mod4"}

	mode "resize" {
		${resizing}
	}
''
