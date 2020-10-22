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
