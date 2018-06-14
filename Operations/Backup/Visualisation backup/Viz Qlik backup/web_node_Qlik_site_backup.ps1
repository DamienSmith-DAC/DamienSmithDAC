﻿# Set local variables and paths
$Today                 = Get-Date -UFormat "%Y%m%d"
$StartTime             = Get-Date -UFormat "%Y%m%d_%H%M"
 
$BackupTargetLocation  = "D:\qlik_backup"
$LogFileLocation       =  Join-Path -ChildPath $StartTime -Path $BackupTargetLocation
$LogFileName           =  Join-Path -ChildPath "$StartTime.log" -Path $LogFileLocation 

 
# Program Data Folder
$SenseProgramData = "C:\ProgramData"

# Create today's backup directory

md $BackupTargetLocation\$StartTime

$TodaysTargetLocation  =  Join-Path -ChildPath $StartTime -Path $BackupTargetLocation

"#########################################################################################" | Out-File -FilePath $LogFileName -Append
"Backup Day is $Today" | Out-File -FilePath $LogFileName -Append
"Backup Start time is $StartTime" |  Out-File -FilePath $LogFileName -Append
"BackupTargetLocation is $BackupTargetLocation" | Out-File -FilePath $LogFileName -Append
"TodaysTargetLocation is $TodaysTargetLocation" | Out-File -FilePath $LogFileName -Append
"#########################################################################################" | Out-File -FilePath $LogFileName -Append


"Stopping Qlik Services ...." | Out-File -FilePath $LogFileName -Append

stop-service QlikSenseProxyService -force *>> $LogFileName
stop-service QlikSenseEngineService -force *>> $LogFileName
stop-service QlikSenseSchedulerService -force *>> $LogFileName
stop-service QlikSensePrintingService -force *>> $LogFileName
stop-service QlikSenseServiceDispatcher -force *>> $LogFileName
stop-service QlikLoggingService -force *>> $LogFileName
stop-service QlikSenseRepositoryService -force *>> $LogFileName
 

"Backing up Program Data from $SenseProgramData ...." | Out-File -FilePath $LogFileName -Append

Copy-Item  $SenseProgramData\Qlik -Destination $TodaysTargetLocation\ProgramData\Qlik -Recurse

"Backing up Program Data is Completed" | Out-File -FilePath $LogFileName -Append

"File Backup Completed." | Out-File -FilePath $LogFileName -Append

 
"Restarting Qlik Services ...." | Out-File -FilePath $LogFileName -Append

start-service QlikSenseRepositoryService -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikSenseEngineService -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikSenseSchedulerService -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikSensePrintingService -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikSenseServiceDispatcher -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikSenseProxyService -WarningAction SilentlyContinue 2>> $LogFileName
start-service QlikLoggingService -WarningAction SilentlyContinue 2>> $LogFileName


"Qlik Services restarted...." | Out-File -FilePath $LogFileName -Append


$EndTime = Get-Date -UFormat "%Y%m%d_%H%M%S"
 
"This backup process started on $env:computername at  $StartTime  and ended at $EndTime. " | Out-File -FilePath $LogFileName -Append