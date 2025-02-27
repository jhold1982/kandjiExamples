# macOS Maintenance Script

A bash script for system maintenance, security checks, and new employee setup on macOS devices.

## Overview

This script performs several important maintenance and diagnostic tasks on macOS:

1. **Disk Cleanup**: Removes temporary and cache files to free up disk space
2. **System Updates**: Checks for available macOS updates
3. **Security Checks**: Verifies FileVault, Firewall, and SIP status
4. **Battery Diagnostics**: Retrieves battery health information
5. **Network Configuration**: Collects network service details
6. **Application Verification**: Checks if required applications are installed
7. **Performance Metrics**: Gathers system performance data
8. **Onboarding Setup**: Creates standard folder structure for new employees
9. **Browser Configuration**: Sets Google Chrome as the default browser

## Prerequisites

- macOS operating system
- Administrative privileges (for some operations)
- Required applications installed (Slack, Microsoft Word, Google Chrome, Zoom)

## Usage

1. Download the script to your Mac
2. Open Terminal
3. Navigate to the directory containing the script
4. Make the script executable:
   ```
   chmod +x script_name.sh
   ```
5. Run the script:
   ```
   ./script_name.sh
   ```
   or with sudo for full functionality:
   ```
   sudo ./script_name.sh
   ```

## Features

### Disk Cleanup
Removes temporary files and logs to free up disk space:
```bash
rm -rf ~/Library/Caches/*
rm -rf ~/Library/Logs/*
rm -rf /Library/Logs/DiagnosticReports/*
```

### System Updates
Checks for available macOS updates:
```bash
softwareupdate -l
```

### Security Verification
Checks status of key security features:
```bash
# FileVault encryption status
fdesetup status

# Firewall status
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# System Integrity Protection status
csrutil status
```

### Battery Health
Retrieves battery health information:
```bash
system_profiler SPPowerDataType
```

### Network Configuration
Collects network configuration details:
```bash
networksetup -listallnetworkservices
ipconfig getpacket en0
```

### Application Verification
Checks if required applications are installed:
```bash
required_apps=("Slack" "Microsoft Word" "Google Chrome" "Zoom.us")
```

### Performance Metrics
Gathers system performance data:
```bash
top -l 1 | head -n 10
vm_stat
df -h
```

### New Employee Setup
Creates standard folder structure for new employees:
```bash
mkdir -p ~/Documents/Company
mkdir -p ~/Documents/Company/Projects
mkdir -p ~/Documents/Company/Training
```

### Browser Configuration
Sets Google Chrome as the default browser:
```bash
open -a "Google Chrome" --args --make-default-browser
```

## Customization

You can customize this script by:
- Modifying the `required_apps` array to check for different applications
- Adding or removing directories in the folder creation section
- Adding additional diagnostic commands as needed

## Notes

- Some operations may require administrative privileges
- Use caution when running cleanup operations as they permanently delete files
- This script is designed for Kandji MDM environments

## Author

[Justin Hold]
