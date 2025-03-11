#!/bin/bash

# This script checks battery health on macOS, supporting both Intel and Apple Silicon Macs.
# It provides different diagnostics and evaluation based on the processor architecture.

# Function to detect processor architecture
# Returns 0 (success) if Apple Silicon, 1 (failure) if Intel
is_apple_silicon() {
    # Check if the CPU brand string contains "Apple M" which indicates Apple Silicon
    if sysctl -n machdep.cpu.brand_string | grep -q "Apple M"; then
        return 0 # Apple Silicon detected
    else
        return 1 # Intel processor detected
    fi
}

# Function to check battery information for Intel-based Macs
# Examines cycle count and battery condition status
check_battery_info_intel() {
    # Extract battery cycle count using system_profiler
    cycle_count=$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')
    
    # Extract battery condition status (Normal, Service Recommended, etc.)
    condition=$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2}')
    
    # Display battery diagnostics to user
    echo "Cycle Count: $cycle_count"
    echo "Battery Condition: $condition"
    
    # Check if battery requires service based on condition status
    if [ "$condition" != "Normal" ]; then
        echo "*Battery requires service.*"
        exit 1  # Exit with error code 1 to indicate service needed
    fi
    
    exit 0  # Exit with code 0 to indicate normal battery status
}

# Function to check battery information for Apple Silicon Macs
# Evaluates maximum capacity percentage and cycle count
check_battery_info_apple() {
    # Extract maximum capacity percentage and remove the % symbol
    capacity=$(system_profiler SPPowerDataType | grep "Maximum Capacity:" | sed 's/.*Maximum Capacity: //' | tr -d '%')
    
    # Display battery diagnostics to user
    echo "Maximum Capacity: $(system_profiler SPPowerDataType | grep "Maximum Capacity:" | sed 's/.*Maximum Capacity: //')"
    echo "Cycle Count: $(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')"
    
    # Check if battery requires service based on maximum capacity
    # Apple considers below 80% to need service
    if [ "$capacity" -lt 80 ]; then
        echo "Battery status: Maximum capacity is below 80% and requires service."
        exit 1  # Exit with error code 1 to indicate service needed
    else
        echo "Battery status: Normal"
        exit 0  # Exit with code 0 to indicate normal battery status
    fi
}

# Main function that orchestrates the script execution
main() {
    # Check processor type and call the appropriate battery check function
    if is_apple_silicon; then
        check_battery_info_apple
    else
        check_battery_info_intel
    fi
}

# Run the main function
main