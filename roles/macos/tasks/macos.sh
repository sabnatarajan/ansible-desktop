#!/bin/bash

function change() {
  name=$1[@]
  domain=$2
  settings=("${!name}")

  for setting in "${settings[@]}"; do
    defaults write $domain $setting
  done
}

# Keyboard
keyboard_settings=(
  "KeyRepeat                -float 1.0"   # Fast key repeat
  "InitialKeyRepeat         -int   15"    # Key repeat delay
  "ApplePressAndHoldEnabled -bool  false" # Disable press-and-hold
  "AppleKeyboardUIMode      -int   3"     # Enable full keyboard access for all controls
)


# Dock
dock_settings=(
  "autohide                  -bool true"      # Auto-hide Dock
  "autohide-delay            -float 0"        # Remove the auto-hiding Dock delay
  "autohide-time-modifier    -float 0"        # Remove the animation when hiding/showing the Dock
  "dashboard-in-overlay      -bool true"      # Don't show Dashboard as a Space
  "expose-animation-duration -float 0.1"      # Faster Mission Control animations
  "expose-group-by-app       -bool false"     # Don't group windows by app in Mission Control
  "launchanim                -bool false"     # Don’t animate opening applications from the Dock
  "mineffect                 -string 'scale'" # Change minimize/maximize window effect
  "minimize-to-application   -bool true"      # Minimize windows into their application’s icon
  "mru-spaces                -bool false"     # Don’t automatically rearrange Spaces based on most recent use
  "orientation               left"            # Dock position
  "show-process-indicators   -bool true"      # Show process indicators for open apps
  "show-recents              -bool false"     # Don't show recent apps
  "showhidden                -bool true"      # Translucent icons for hidden applications
  "tilesize                  -int 36"         # Set icon size to 36
)

# Misc
misc_settings=(
  "nvram SystemAudioVolume=' '" # Disable sound at start-up
  "com.apple.universalaccess reduceTransparency -bool true" # Disable transparency in menu bar
  "NSGlobalDomain AppleShowScrollBars -string 'Always'" # Always show scrollbar
  "NSGlobalDomain            NSNavPanelExpandedStateForSaveMode  -bool true"         # Always expand save dialog
  "NSGlobalDomain            NSNavPanelExpandedStateForSaveMode2 -bool true"         # Always expand save dialog
  "NSGlobalDomain PMPrintingExpandedStateForPrint -bool true" # Always expand print dialog
  "NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true" # Always expand print dialog

  "NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false" # Disable smart dashes as they’re annoying when typing code
  "NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false" # Disable automatic period substitution as it’s annoying when typing code
  "NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false" # Disable smart quotes as they’re annoying when typing code
  "NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false" # Disable auto-correct

  "com.apple.dashboard       mcx-disabled                        -bool true"         # Disable Dashboard

  "com.apple.ActivityMonitor OpenMainWindow                      -bool true"         # Show main window in Activity Monitor
  "com.apple.ActivityMonitor IconType                            -int 5"             # Visualize CPU usage in Dock icon
  "com.apple.ActivityMonitor ShowCategory                        -int 0"             # Show all processed
  "com.apple.ActivityMonitor SortColumn                          -string 'CPUUsage'" # Sort by CPU Usage
  "com.apple.ActivityMonitor SortDirection                       -int 0"             # Sort descending

  "com.apple.appstore        WebKitDeveloperExtras               -bool true"         # Enable the WebKit Developer Tools in the Mac App Store
  "com.apple.SoftwareUpdate  AutomaticCheckEnabled               -bool true"         # Enable the automatic update check
  "com.apple.SoftwareUpdate  ScheduleFrequency                   -int 1"
  "com.apple.SoftwareUpdate  AutomaticDownload                   -int 1"             # Download newly available updates in background
  "com.apple.SoftwareUpdate  CriticalUpdateInstall               -int 1"             # Install System data files & security updates
  "com.apple.SoftwareUpdate  ConfigDataInstall                   -int 1"             # Automatically download apps purchased on other Macs
  "com.apple.commerce        AutoUpdate                          -bool true"         # Turn on app auto-update
  "com.apple.commerce        AutoUpdateRestartRequired           -bool true"         # Allow the App Store to reboot machine on macOS updates

  "NSGlobalDomain            com.apple.sound.beepvolume          -int 0"             # Disable alert sounds
  "NSGlobalDomain            com.apple.sound.uiaudio.enabled     -bool false"             # Disable alert sounds
)


change keyboard_settings "NSGlobalDomain"
change dock_settings     "com.apple.dock"
change misc_settings

cat <<MESSAGE

You might also want to clear all icons from the Dock by running
defaults write com.apple.dock persistent-apps -array
MESSAGE

# Kill affected applications so the changes take effect
apps=(
  "Activity Monitor"
  "Dock"
  "Finder"
)
for app in "${apps[@]}"; do killall $app &> /dev/null; done
