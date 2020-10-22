function connect {
    $hostname = "vcenter.ben.local"
    Connect-VIServer -Server $hostname

}

function createSwitch {
    param ($switchName, $esxi_host)

    Get-VMHost -Name $esxi_host
    $vSwitch = New-VirtualSwitch -VMHost $esxi_host -Name $switchName -ErrorAction Ignore
    $vSwitch
    New-VirtualPortGroup -VirtualSwitch $vSwitch -Name $switchName
}

function setNetwork {
    param ([string] $vmname, [int] $numInterface, [string] $preferredNetwork)

    $vm = Get-VM -Name $vmname
    $interfaces = $vm | Get-NetworkAdapter

    $interfaces[$numInterface] | Set-NetworkAdapter -NetworkName $preferredNetwork
}

function getIP{
    param ([String] $vmName)

    $vm = Get-VM -Name $vmName
    Write-Host $vm.Guest.IPAddress[0] hostname=$vm.Name
}