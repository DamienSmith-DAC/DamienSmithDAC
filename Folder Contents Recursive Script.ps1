# Script to output a folders contents into a csv file (Recursive)
# Output File Name, File Directory and File Size (MB)
# Author: Damien Smith
# Ver. 0.1
#
# VM.Output:
# 1. Full path of files - recursively through folders to files
# 2. Size of files
# 3. Compare the list and sizes between two VMs.
# 

# Set Source folder
$SourcePath = "C:\Users\smithd14\OneDrive\PowerShell\SourceTest"

# Define output csv file
$csvFileName = "C:\Users\smithd14\OneDrive\PowerShell\Test2.csv"

#Get recurse file names
$Source = (dir $SourcePath -Recurse).FullName

#Get File List for Source
$FileList1 = Get-ChildItem -Path $SourcePath -Recurse -File

# Create Files
$File1 = foreach ($FL_Item in $FileList1)
    {
    [PSCustomObject]@{
        Name = $FL_Item.Name
        Location = $FL_Item.Directory
        Size_MB = '{0,7:N2}' -f ($FL_Item.Length / 1MB)
        }
    }

$File1 | export-csv -Path $csvFileName -NoTypeInformation
