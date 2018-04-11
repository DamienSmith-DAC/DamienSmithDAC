# Set local variables and paths
$Today                 = Get-Date -UFormat "%Y%m%d"
$StartTime             = Get-Date -UFormat "%Y%m%d_%H%M"
 
$PostGreSQLLocation    = "C:\Program Files\Qlik\Sense\Repository\PostgreSQL\9.6\bin"
$BackupTargetLocation  = "D:\QlikShared\qlik_backup"
$LogFileLocation       =  Join-Path -ChildPath $StartTime -Path $BackupTargetLocation
$LogFileName           =  Join-Path -ChildPath "$StartTime.log" -Path $LogFileLocation 

 
# Shared Persistance Folder
$SenseSharedData = "D:\QlikShared"

# Program Data Folder
$SenseProgramData = "C:\ProgramData"

# Create today's backup directory

md $BackupTargetLocation\$StartTime

$TodaysTargetLocation  =  Join-Path -ChildPath $StartTime -Path $BackupTargetLocation

"#########################################################################################" | Out-File -FilePath $LogFileName -Append
"Backup Day is $Today" | Out-File -FilePath $LogFileName -Append
"Backup Start time is $StartTime" |  Out-File -FilePath $LogFileName -Append
"PostGreSQLLocation is $PostGreSQLLocation" | Out-File -FilePath $LogFileName -Append
"BackupTargetLocation is $BackupTargetLocation" | Out-File -FilePath $LogFileName -Append
"TodaysTargetLocation is $TodaysTargetLocation" | Out-File -FilePath $LogFileName -Append
"#########################################################################################" | Out-File -FilePath $LogFileName -Append



"Stopping Qlik Services ...." | Out-File -FilePath $LogFileName -Append
 
stop-service QlikSenseProxyService -WarningAction SilentlyContinue
stop-service QlikSenseEngineService -WarningAction SilentlyContinue
stop-service QlikSenseSchedulerService -WarningAction SilentlyContinue
stop-service QlikSensePrintingService -WarningAction SilentlyContinue
stop-service QlikSenseServiceDispatcher -WarningAction SilentlyContinue
stop-service QlikLoggingService -WarningAction SilentlyContinue
stop-service QlikSenseRepositoryService -WarningAction SilentlyContinue

 
"Backing up PostgreSQL Repository Database ...." | Out-File -FilePath $LogFileName -Append
 
cd $PostGreSQLLocation

(Get-Item -Path ".\" -Verbose).FullName | Out-File -FilePath $LogFileName -Append

.\pg_dump.exe -h localhost -p 4432 -U postgres -w -F t -f "$TodaysTargetLocation\QSR_backup_$StartTime.tar" QSR


"PostgreSQL backup Completed." | Out-File -FilePath $LogFileName -Append
 
"Backing up Shared Persistance Data from $SenseSharedData ...." | Out-File -FilePath $LogFileName -Append

Copy-Item  $SenseSharedData\ArchivedLogs -Destination $TodaysTargetLocation\ArchivedLogs -Recurse
Copy-Item  $SenseSharedData\Apps -Destination $TodaysTargetLocation\Apps -Recurse
Copy-Item  $SenseSharedData\StaticContent -Destination $TodaysTargetLocation\StaticContent -Recurse
Copy-Item  $SenseSharedData\CustomData -Destination $TodaysTargetLocation\CustomData -Recurse
Copy-Item  $SenseSharedData\*.QVD -Destination $TodaysTargetLocation

"Backing up Shared Persistance Data Completed." | Out-File -FilePath $LogFileName -Append

"Backing up Program Data from $SenseProgramData ...." | Out-File -FilePath $LogFileName -Append

Copy-Item  $SenseProgramData\Qlik -Destination $TodaysTargetLocation\ProgramData\Qlik -Recurse

"Backing up Program Data is Completed" | Out-File -FilePath $LogFileName -Append

"File Backup Completed." | Out-File -FilePath $LogFileName -Append

 
"Restarting Qlik Services ...." | Out-File -FilePath $LogFileName -Append


start-service QlikSenseRepositoryService -WarningAction SilentlyContinue
start-service QlikSenseEngineService -WarningAction SilentlyContinue
start-service QlikSenseSchedulerService -WarningAction SilentlyContinue
start-service QlikSensePrintingService -WarningAction SilentlyContinue
start-service QlikSenseServiceDispatcher -WarningAction SilentlyContinue
start-service QlikSenseProxyService -WarningAction SilentlyContinue
start-service QlikLoggingService -WarningAction SilentlyContinue


"Qlik Services restarted...." | Out-File -FilePath $LogFileName -Append


$EndTime = Get-Date -UFormat "%Y%m%d_%H%M%S"
 
"This backup process started on $env:computername at  $StartTime  and ended at $EndTime. " | Out-File -FilePath $LogFileName -Append