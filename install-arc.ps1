# Add the service principal application ID and secret here
$servicePrincipalClientId="blank"
$servicePrincipalSecret="blank"

# Download the installation package
Invoke-WebRequest -Uri "https://aka.ms/azcmagent-windows" -TimeoutSec 30 -OutFile "$env:TEMP\install_windows_azcmagent.ps1"

# Install the hybrid agent
& "$env:TEMP\install_windows_azcmagent.ps1"
if($LASTEXITCODE -ne 0) {
    throw "Failed to install the hybrid agent"
}

# Run connect command
& "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "ConnectUC" --tenant-id "10f5a98e-e9ca-411d-af74-77776ef79b7f" --location "eastus" --subscription-id "f2ce46ab-5b12-4861-9131-58de056ba8f9" --cloud "AzureCloud" --correlation-id "8eaad23b-381a-4d50-8ce2-886dca707000"

if($LastExitCode -eq 0){Write-Host -ForegroundColor yellow "To view your onboarded server(s), navigate to https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.HybridCompute%2Fmachines"}
