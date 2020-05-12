Add-WindowsFeature Web-Server 
Install-WindowsFeature -name "Web-Server" -IncludeManagementTool
Get-Disk | Where partitionstyle -eq "raw" | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel myDataDisk -Confirm:$false
$DriveLetterOfDataDisk = Get-Volume | where FileSystemLabel -eq "myDataDisk" | Select -ExpandProperty DriveLetter
$DriveLetterOfDataDisk=$DriveLetterOfDataDisk+":"
$WebDir="$DriveLetterOfDataDisk\VirtualDirectory\TestApp"
mkdir $WebDir
echo "<html><body><h1>Hello, Welcome to Azure Virtual Machine</h1></html>" >> $WebDir
PS F:\> New-WebApplication -name "TestApp" -ApplicationPool "DefaultAppPool" -Force -PhysicalPath $WebDir -Site "Default Web Site"
