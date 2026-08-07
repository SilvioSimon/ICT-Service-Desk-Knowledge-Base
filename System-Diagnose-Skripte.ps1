# ============================================================
# SYSTEM DIAGNOSTICS SCRIPT
# ============================================================
# Purpose:
# Collect basic Windows system information for troubleshooting.
#
# This script is intended for learning and diagnostic purposes.
# No system settings are modified.
# ============================================================


# ============================================================
# 1. SYSTEM INFORMATION
# ============================================================

Write-Host "`n===== SYSTEM INFORMATION =====" -ForegroundColor Cyan

$ComputerSystem = Get-CimInstance Win32_ComputerSystem
$OperatingSystem = Get-CimInstance Win32_OperatingSystem

Write-Host "Computer Name : $($ComputerSystem.Name)"
Write-Host "Manufacturer  : $($ComputerSystem.Manufacturer)"
Write-Host "Model         : $($ComputerSystem.Model)"
Write-Host "Operating Sys.: $($OperatingSystem.Caption)"
Write-Host "Version       : $($OperatingSystem.Version)"
Write-Host "Architecture  : $($OperatingSystem.OSArchitecture)"


# ============================================================
# 2. CPU INFORMATION
# ============================================================

Write-Host "`n===== CPU INFORMATION =====" -ForegroundColor Cyan

$CPU = Get-CimInstance Win32_Processor

Write-Host "CPU           : $($CPU.Name)"
Write-Host "Cores         : $($CPU.NumberOfCores)"
Write-Host "Logical CPUs  : $($CPU.NumberOfLogicalProcessors)"
Write-Host "Current Load  : $($CPU.LoadPercentage)%"


# ============================================================
# 3. MEMORY INFORMATION
# ============================================================

Write-Host "`n===== MEMORY INFORMATION =====" -ForegroundColor Cyan

$TotalMemoryGB = [math]::Round(
    $ComputerSystem.TotalPhysicalMemory / 1GB,
    2
)

$FreeMemoryGB = [math]::Round(
    $OperatingSystem.FreePhysicalMemory / 1MB,
    2
)

$UsedMemoryGB = [math]::Round(
    $TotalMemoryGB - $FreeMemoryGB,
    2
)

Write-Host "Total Memory  : $TotalMemoryGB GB"
Write-Host "Used Memory   : $UsedMemoryGB GB"
Write-Host "Free Memory   : $FreeMemoryGB GB"


# ============================================================
# 4. DISK INFORMATION
# ============================================================

Write-Host "`n===== DISK INFORMATION =====" -ForegroundColor Cyan

$Disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

foreach ($Disk in $Disks) {

    $TotalSpaceGB = [math]::Round(
        $Disk.Size / 1GB,
        2
    )

    $FreeSpaceGB = [math]::Round(
        $Disk.FreeSpace / 1GB,
        2
    )

    $UsedSpaceGB = [math]::Round(
        $TotalSpaceGB - $FreeSpaceGB,
        2
    )

    $FreePercentage = [math]::Round(
        ($FreeSpaceGB / $TotalSpaceGB) * 100,
        1
    )

    Write-Host "`nDrive: $($Disk.DeviceID)"
    Write-Host "Total Space   : $TotalSpaceGB GB"
    Write-Host "Used Space    : $UsedSpaceGB GB"
    Write-Host "Free Space    : $FreeSpaceGB GB"
    Write-Host "Free          : $FreePercentage%"
}


# ============================================================
# 5. NETWORK INFORMATION
# ============================================================

Write-Host "`n===== NETWORK INFORMATION =====" -ForegroundColor Cyan

$NetworkAdapters = Get-NetIPConfiguration |
    Where-Object {
        $_.NetAdapter.Status -eq "Up"
    }

foreach ($Adapter in $NetworkAdapters) {

    Write-Host "`nInterface     : $($Adapter.InterfaceAlias)"

    if ($Adapter.IPv4Address) {
        Write-Host "IPv4 Address  : $($Adapter.IPv4Address.IPAddress)"
    }

    if ($Adapter.IPv4DefaultGateway) {
        Write-Host "Gateway       : $($Adapter.IPv4DefaultGateway.NextHop)"
    }

    if ($Adapter.DNSServer.ServerAddresses) {
        Write-Host "DNS Server    : $($Adapter.DNSServer.ServerAddresses -join ', ')"
    }
}


# ============================================================
# 6. INTERNET CONNECTIVITY TEST
# ============================================================

Write-Host "`n===== CONNECTIVITY TEST =====" -ForegroundColor Cyan

$TestHost = "8.8.8.8"

if (Test-Connection -ComputerName $TestHost -Count 2 -Quiet) {
    Write-Host "Internet Test : SUCCESS - $TestHost is reachable" `
        -ForegroundColor Green
}
else {
    Write-Host "Internet Test : FAILED - $TestHost is not reachable" `
        -ForegroundColor Red
}


# ============================================================
# 7. WINDOWS SERVICES
# ============================================================

Write-Host "`n===== IMPORTANT SERVICES =====" -ForegroundColor Cyan

$ImportantServices = @(
    "wuauserv",
    "BITS",
    "Winmgmt",
    "EventLog"
)

foreach ($ServiceName in $ImportantServices) {

    $Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

    if ($Service) {

        Write-Host "$($Service.DisplayName): $($Service.Status)"
    }
}


# ============================================================
# 8. RECENT SYSTEM ERRORS
# ============================================================

Write-Host "`n===== RECENT SYSTEM ERRORS =====" -ForegroundColor Cyan

$RecentErrors = Get-WinEvent -FilterHashtable @{
    LogName   = "System"
    Level     = 2
    StartTime = (Get-Date).AddDays(-1)
} -MaxEvents 5 -ErrorAction SilentlyContinue

if ($RecentErrors) {

    foreach ($ErrorEvent in $RecentErrors) {

        Write-Host "`nTime    : $($ErrorEvent.TimeCreated)"
        Write-Host "Source  : $($ErrorEvent.ProviderName)"
        Write-Host "Event ID: $($ErrorEvent.Id)"
        Write-Host "Message : $($ErrorEvent.Message)"
    }
}
else {

    Write-Host "No system errors found in the last 24 hours."
}


# ============================================================
# 9. LAST BOOT TIME
# ============================================================

Write-Host "`n===== SYSTEM UPTIME =====" -ForegroundColor Cyan

$LastBoot = $OperatingSystem.LastBootUpTime
$Uptime = (Get-Date) - $LastBoot

Write-Host "Last Boot     : $LastBoot"
Write-Host "Uptime        : $($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"