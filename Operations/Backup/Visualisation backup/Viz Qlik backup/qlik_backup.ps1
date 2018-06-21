#########################################################################################
# 											                                            #
#	This script compresses and encrypts backups on qlik servers then		            #
#	sends them to the swift container DAC_BACKUP for long-life storage.		            #
#				AUTHOR = TIMOTHY HEYES					                                #
#18/05/2018										                                        #
#########################################################################################

$SEGMENTSIZE     = 5368709120 #size of each segment for uploading of files over 5gb.
$TODAY                 = Get-Date -UFormat "%Y%m%d"
$TIMESPAN              = New-TimeSpan -Hours 18 #determine which period of backups to copy. Copys any folders newer than the specificed hours.
$LOG_PATH              = "C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\$TODAY.log"
$EMAILADDRESS          = "Indu.Neelakandan@treasury.nsw.gov.au,dacsupport@treasury.nsw.gov.au" #email addresses to send error notification to.
$LOG_TIME              = Get-Date -Format "HH:mm:s"
$ZIP_PASS              = Get-Content C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\pass.txt #get enc pass from file
$PW_SWITCH             = "-p$ZIP_PASS" #used to pass the encryption password to 7z cli

function log_info()
{
    echo "$Args $LOG_TIME" >> $LOG_PATH
}

if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) 
    {
        throw "$env:ProgramFiles\7-Zip\7z.exe needed"
        log_info "$env:ProgramFiles\7-Zip\7z.exe needed"
    }
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"

function initiate_env()
{   
    echo "$Args $LOG_TIME" >> $LOG_PATH
    $env:OS_AUTH_URL                = "https://10.240.0.254:5000/v3"
    $env:OS_CACERT                  = "C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\swift_cert.pem"
    $env:OS_IDENTITY_API_VERSION    = "3"
    $env:OS_INTERFACE               = "public"
    $env:OS_PASSWORD                = Get-Content C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\OS_PASSWORD_INPUT.key
    $env:OS_PROJECT_ID              = "bea24bf2b3fc4d5cb9e2a894eb594e8e"
    $env:OS_PROJECT_NAME            = "DAC"
    $env:OS_USER_DOMAIN_NAME        = "Default"
    $env:OS_USERNAME                = "svc_DACBackup"

    cd C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\
}

initiate_env "Info: Initiating environment variables..."
if (-not($?)) #checks if last command failed.
{
    log_info "Error: initiating environment variables failed."
	exit 1
}
 
Get-ChildItem "D:\QlikShared\qlik_backup\" | Select-Object -ExpandProperty Name > C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\FoldersToBackup.txt

foreach($FOLDER in Get-Content C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\FoldersToBackup.txt)
{
    echo "line is $FOLDER"
    $LASTWRITE = (Get-Item D:\QlikShared\qlik_backup\$FOLDER).LastWriteTime
    
    if (((get-date) - $LASTWRITE) -lt $TIMESPAN)
    {
        ################################################ZIP & ENCRYPT FOLDER################################################
        echo "zipping $FOLDER into $FOLDER.7z and creating list file..."

        Get-ChildItem "D:\QlikShared\qlik_backup\$FOLDER" | Select-Object -ExpandProperty Name > C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\$FOLDER.list
        sz a C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\$FOLDER.7z D:\QlikShared\qlik_backup\$FOLDER\ -mhc=on -mhe=on $PW_SWITCH
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: zipping of $FOLDER.7z failed."
			exit 1
        }
        
        log_info  "Info: $FOLDER successfully zipped."

        ################################################SEND TO OPENSTACK################################################
        echo "Sending $FOLDER.7z to swift container..."

        swift upload DAC_BACKUP/Qlik/$FOLDER -S 5368709120 "$FOLDER.7z"
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: sending of $FOLDER.7z failed."
			exit 1
        }

        log_info  "Info: $FOLDER.7z successfully sent to DAC_BACKUP container. Removing $FOLDER.7z locally."
        #Remove-Item C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\$FOLDER.7z
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: removing of $FOLDER.7z locally failed."
			exit 1
        }

        echo "Sending $FOLDER.list to swift container..."

        swift upload DAC_BACKUP/Qlik/$FOLDER -S 5368709120 "$FOLDER.list"
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: sending of $FOLDER.list failed."
			exit 1
        }

        log_info  "Info: $FOLDER.list successfully sent to DAC_BACKUP container. Removing $FOLDER.list locally."
        #Remove-Item C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\$FOLDER.list
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: removing of $FOLDER.list locally failed."
			exit 1
        }

        log_info "Info: $FOLDER successfully backed up. Removing this backup locally."
        #Remove-Item D:\QlikShared\qlik_backup\$FOLDER\ -Recurse

    }
}
Remove-Item C:\Users\qlik_sense_admin\Desktop\qlikSwiftBackup\FoldersToBackup.txt