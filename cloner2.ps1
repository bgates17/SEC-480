$conf =""
Write-Host "Using your saved configurations"
$conf = (Get-Content -Raw -Path "cloner.json" | ConvertFrom-Json)

Connect-VIServer -Server $conf.vcenter_server

Write-Host "Here are your BASE-VMS"
Get-VM -Location $conf.base_folder | Select Name
$basevm = Read-Host "Choose a VM"


$cloner = Read-Host "Would you like to create a [F]ull clone or a [L]inked clone?"
if ($cloner -eq "F"){
    
    $vmhost = Get-VMHost -Name $conf.esxi_server

    $dstore = Get-Datastore -Name $conf.preferred_datastore

    $folder = Get-Folder -Name $conf.base_folder

    $network = $conf.preferred_network

    $vmname = Read-Host "What would you like to call the VM?"

    $newvm = New-VM -Name $vmname -VM $basevm -VMHost $vmhost -Datastore $dstore -Location $folder -NetworkName $network
    $newvm
    Write-Host "Your full clone has been created"
    exit
}    
if ($cloner -eq "L"){

    $snapshot = Get-Snapshot -VM $basevm -Name "Base"

    $vmhost = Get-VMHost -Name $conf.esxi_server

    $dstore = Get-Datastore -Name $conf.preferred_datastore

    $folder = Get-Folder -Name $conf.base_folder

    $network = $conf.preferred_network

    $vmname = Read-Host "What would you like to call the VM?"

    $newvm = New-VM -Name $vmname -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VmHost $vmhost -Datastore $dstore -Location $folder | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $network
    $newvm
    Write-Host "Your linked VM clone has been created"
    exit
}