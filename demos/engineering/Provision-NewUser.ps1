<#
.SYNOPSIS
    Provision-NewUser.ps1 - Onboards a new Entra ID (Azure AD) user for Make-A-Wish America IT.

.DESCRIPTION
    SYNTHETIC DEMO SCRIPT - contains intentional bugs for a Claude Code debug demo.
    Creates an Entra ID user, sets a temporary password, and adds the user to the
    appropriate department security group using the Microsoft.Graph PowerShell SDK.

.NOTES
    Author : IT Onboarding (DEMO / FAKE)
    Date   : 2026-06-15
    WARNING: Do NOT run against a real tenant. All values are fabricated.
#>

param(
    [Parameter(Mandatory = $true)] [string]$FirstName,
    [Parameter(Mandatory = $true)] [string]$LastName,
    [Parameter(Mandatory = $true)] [string]$Department,
    [string]$TenantDomain = "makeawishdemo.onmicrosoft.com"
)

Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All" | Out-Null

# Build the user principal name and display name
$displayName = "$FirstName $LastName"
$mailNickname = ("{0}.{1}" -f $FirstName, $LastName).ToLower()
$userPrincipalName = "$mailNickname@$TenantDomain"

# Generate a temporary password
$tempPassword = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 12 | ForEach-Object { [char]$_ })

$passwordProfile = @{
    Password                      = $tempPassword
    ForceChangePasswordNextSignIn = $true
}

# BUG 1: parameter name is wrong. New-MgUser expects -DisplayName, not -DisplayNam
$newUser = New-MgUser -DisplayNam $displayName `
    -UserPrincipalName $userPrincipalName `
    -MailNickname $mailNickname `
    -AccountEnabled `
    -PasswordProfile $passwordProfile

# BUG 2: casing/typo mismatch - variable was $newUser but here it is referenced as $NewUsr
Write-Host "Created user: $($NewUsr.UserPrincipalName)"

# Look up the department security group
$group = Get-MgGroup -Filter "displayName eq 'Dept-$Department'"

# BUG 3: missing null check - if the group does not exist, $group.Id is null and the
# Add-MgGroupMember call below fails with an unhelpful error.
Add-MgGroupMember -GroupId $group.Id -DirectoryObjectId $newUser.Id

# BUG 4 (logic): wrong comparison operator - this should be -gt 0 to confirm at least
# one license is available before assigning. As written it blocks assignment when seats exist.
$availableLicenses = (Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "ENTERPRISEPACK" }).PrepaidUnits.Enabled
if ($availableLicenses -lt 0) {
    Set-MgUserLicense -UserId $newUser.Id -AddLicenses @{SkuId = "tenant-sku-guid-demo" } -RemoveLicenses @()
    Write-Host "Assigned E3 license."
}
else {
    Write-Host "No licenses available - skipping license assignment."
}

Write-Host "Onboarding complete for $displayName ($userPrincipalName)."
Write-Host "Temporary password: $tempPassword"
