$cloner = Read-Host "Would you like to create a [F]ull clone or a [L]inked clone?"

Write-Host "Interactive Mode - Made by Benjamin Gates"
$hostname = Read-Host "Enter vCenter hostname or ip address"

Connect-VIServer -Server $hostname

if ($cloner -eq "F"){
    
    $folder1 = Read-Host "What folder contains your base vms"
    Get-VM -Location $folder1 | Select Name
    
    $basevm = Read-Host "Choose a VM"

    Get-VMHost | Select Name
    $vmhost1 = Read-Host "Which host would you like to use?"
    $vmhost = Get-VMHost -Name $vmhost1

    Get-Datastore | Select Name
    $dstore1 = Read-Host "Which datastore would you like to use?"
    $dstore = Get-Datastore -Name $dstore1

    $folder = Get-Folder -Name $folder1

    $vmname = Read-Host "What would you like to call the VM?"

    $newvm = New-VM -Name $vmname -VM $basevm -VMHost $vmhost -Datastore $dstore -Location $folder
    $newvm
    exit
}    
if ($cloner -eq "L"){

    $folder1 = Read-Host "What folder contains your base vms"
    Get-VM -Location $folder1 | Select Name
    $basevm = Read-Host "Choose a VM"

    $snapshot = Get-Snapshot -VM $baseVM -Name "Base"

    Get-VMHost | Select Name
    $vmhost1 = Read-Host "Which host would you like to use?"
    $vmhost = Get-VMHost -Name $vmhost1

    Get-Datastore | Select Name
    $dstore1 = Read-Host "Which datastore would you like to use?"
    $dstore = Get-Datastore -Name $dstore1

    $folder = Get-Folder -Name $folder1

    $vmname = Read-Host "What would you like to call the VM?"

    $newvm = New-VM -Name $vmname -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VmHost $vmhost -Datastore $dstore -Location $folder 
    $newvm
    Write-Host "Your linked VM clone has been created"
    exit
}