. (Join-Path $PSScriptRoot '.\_Settings.ps1')

$Containername = 'bccurrent'

$ContainerDockerImage = 'mcr.microsoft.com/businesscentral/sandbox:us'

$ContainerAlwaysPull = $true
$enableSymbolLoading = $false
$assignPremiumPlan = $true
$includeTestToolkit = $false
$includeTestLibrariesOnly = $false
$InstallDependentModules = $true

New-NavContainer `
    -containerName $ContainerName `
    -imageName $ContainerDockerImage `
    -accept_eula `
    -additionalParameters $ContainerAdditionalParameters `
    -licenseFile $SecretSettings.containerLicenseFile `
    -alwaysPull:$ContainerAlwaysPull `
    -Credential $ContainerCredential `
    -doNotExportObjectsToText `
    -updateHosts `
    -auth NavUserPassword `
    -includeCSide `
    -enableSymbolLoading:$enableSymbolLoading `
    -assignPremiumPlan:$assignPremiumPlan `
    -useBestContainerOS `
    -includeTestToolkit:$includeTestToolkit `
    -includeTestLibrariesOnly:$includeTestLibrariesOnly `
    -Verbose `
    -memoryLimit 4G

break

if ($InstallDependentModules) {
    Install-NCHDependentModules `
        -ContainerName $ContainerName `
        -ContainerModulesOnly
}

Sync-NCHNAVTenant -containerName $ContainerName
