#########################################################################################
# 											                                            #
#	This script compresses and encrypts backups on qlik servers then		            #
#	sends them to the swift container DAC_BACKUP for long-life storage.		            #
#				AUTHOR = TIMOTHY HEYES					                                #
#18/05/2018										                                        #
#########################################################################################

$SEGMENTSIZE           = 5368709120 #size of each segment for uploading of files over 5gb.
$TODAY                 = Get-Date -UFormat "%Y%m%d"
$TIMESPAN              = New-TimeSpan -Hours 12
$LOG_PATH              = "C:\Users\HAYEST2\Desktop\QlikSwiftBackup\$TODAY.log"
$EMAILADDRESS          = "Indu.Neelakandan@treasury.nsw.gov.au,dacsupport@treasury.nsw.gov.au" #email addresses to send error notification to.
$LOG_TIME              = Get-Date -UFormat "%Y%m%d%h%m"

function log_info()
{
    echo "$Args $LOG_TIME" >> $LOG_PATH
}

function initiate_env()
{
    if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) 
    {
        throw "$env:ProgramFiles\7-Zip\7z.exe needed"
        log_info "$env:ProgramFiles\7-Zip\7z.exe needed"
    }
    set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"
    
    echo "$Args $LOG_TIME" >> $LOG_PATH
    $env:OS_AUTH_URL                = "https://10.240.0.254:5000/v3"
    $env:OS_CACERT                  = "C:\Users\HAYEST2\Desktop\qlikSwiftBackup\swift_cert.pem"
    $env:OS_IDENTITY_API_VERSION    = "3"
    $env:OS_INTERFACE               = "public"
    $env:OS_PASSWORD                = Get-Content C:\Users\HAYEST2\Desktop\QlikSwiftBackup\OS_PASSWORD_INPUT.key
    $env:OS_PROJECT_ID              = "bea24bf2b3fc4d5cb9e2a894eb594e8e"
    $env:OS_PROJECT_NAME            = "DAC"
    $env:OS_USER_DOMAIN_NAME        = "Default"
    $env:OS_USERNAME                = "svc_DACBackup"

    cd C:\Users\HAYEST2\Desktop\QlikSwiftBackup\
}

initiate_env "Initiating environment variables..."
if (-not($?)) #checks if last command failed.
{
    log_info "Error: initiating environment variables failed."
	exit 1
}
 
Get-ChildItem "C:\Users\HAYEST2\Desktop\test\" | Select-Object -ExpandProperty Name > C:\Users\HAYEST2\Desktop\QlikSwiftBackup\FoldersToBackup.txt

foreach($FOLDER in Get-Content C:\Users\HAYEST2\Desktop\QlikSwiftBackup\FoldersToBackup.txt)
{
    echo "line is $FOLDER"
    $LASTWRITE = (Get-Item C:\Users\HAYEST2\Desktop\test\$FOLDER).LastWriteTime
    
    if (((get-date) - $LASTWRITE) -lt $TIMESPAN)
    {
        ################################################ZIP & ENCRYPT FOLDER################################################
        echo "zipping $FOLDER into $FOLDER.tar.gz and creating list file..."

        Get-ChildItem "C:\Users\HAYEST2\Desktop\test\$FOLDER" | Select-Object -ExpandProperty Name > C:\Users\HAYEST2\Desktop\QlikSwiftBackup\$FOLDER.list
        sz a C:\Users\HAYEST2\Desktop\QlikSwiftBackup\$FOLDER.7z C:\Users\HAYEST2\Desktop\test\$FOLDER\ -p1234
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: zipping of $FOLDER.7z failed."
			exit 1
        }

        log_info  "Info: $FOLDER successfully zipped."

        ################################################SEND TO OPENSTACK################################################
        echo "Sending $FOLDER.7z to swift container..."

        #swift upload DAC_BACKUP/Qlik/$FOLDER -S $SEGMENTSIZE "$FOLDER.7z"
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: sending of $FOLDER.7z failed."
			exit 1
        }

        log_info  "Info: $FOLDER.7z successfully sent to DAC_BACKUP container. Removing $FOLDER.7z locally."
        #Remove-Item C:\Users\HAYEST2\Desktop\QlikSwiftBackup\$FOLDER.7z
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: removing of $FOLDER.7z locally failed."
			exit 1
        }

        echo "Sending $FOLDER.list to swift container..."

        #swift upload DAC_BACKUP/Qlik/$FOLDER -S $SEGMENTSIZE "$FOLDER.list"
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: sending of $FOLDER.list failed."
			exit 1
        }

        log_info  "Info: $FOLDER.list successfully sent to DAC_BACKUP container. Removing $FOLDER.list locally."
        #Remove-Item C:\Users\HAYEST2\Desktop\QlikSwiftBackup\$FOLDER.list
        if (-not($?)) #checks if last command failed.
        {
            log_info "Error: removing of $FOLDER.list locally failed."
			exit 1
        }

        log_info "Info: $FOLDER successfully backed up. Removing this backup locally."
        #Remove-Item C:\Users\HAYEST2\Desktop\test\$FOLDER\ -Recurse

    }
}