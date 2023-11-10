# ------------------------------------------------------------------------------
# OraDBA - Oracle Database Infrastructur and Security, 5630 Muri, Switzerland
# ------------------------------------------------------------------------------
# Name.......: create_krb5_spn.ps1
# Author.....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
# Editor.....: Stefan Oehrli
# Date.......: 2023.11.08
# Version....: --
# Purpose....: Script to create a service account for Oracle Database Kerberos
#              Authentication
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------
# - Customization --------------------------------------------------------------
param (
    $ServiceName    ='db23',    # Service / Host Name as script parameter
    $CLIPassword    =''         # Password of Service Name
    )         

$UserDN             = "cn=Users"        # Container for Service Name 
# - End of Customization -------------------------------------------------------

# - Functions ------------------------------------------------------------------
Function GeneratePassword {
    param ([int]$PasswordLength = 15 )
    $AllowedPasswordCharacters = [char[]]'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_+-.'
    $Regex = "(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)"

    do {
            $Password = ([string]($AllowedPasswordCharacters |
            Get-Random -Count $PasswordLength) -replace ' ')
       }    until ($Password -cmatch $Regex)
    $Password
}
# - End of Functions -----------------------------------------------------------

# - Default Values -------------------------------------------------------------
# generate random password if variable is empty
if (!$CLIPassword) { 
    $PlainPassword = GeneratePassword
} else {
    $PlainPassword = $CLIPassword
}

$UserBaseDN = "$UserDN," + (Get-ADDomain).DistinguishedName # define User base DN 
$DNSRoot    = (Get-ADDomain).DNSRoot                        # define DNS root

# Create secure Password string
$SecurePassword = ConvertTo-SecureString -AsPlainText $PlainPassword -Force
# - EOF Default Values ---------------------------------------------------------

# - Main -----------------------------------------------------------------------
Write-Host '= Setup KRB Service Name ==========================================='
Write-Host "INFO : Service Name        : $ServiceName"
Write-Host "INFO : CLI Password        : $CLIPassword"
Write-Host "INFO : DNS Root            : $DNSRoot"
Write-Host "INFO : User base DN        : $UserBaseDN"

# check if service name already exists
if (!(Get-ADUser -Filter "sAMAccountName -eq '$ServiceName'")) {
    Write-Host "INFO : Service Account ($ServiceName) does not exist."
} else  {
    Write-Host "INFO : Remove existing Service Account ($ServiceName)."
    Remove-ADUser -Identity $ServiceName -Confirm:$False
} 

Write-Host "INFO : Create service account for DB server $ServiceName."
New-ADUser -SamAccountName $Hostname -Name $ServiceName `
    -UserPrincipalName "oracle/$ServiceName.$DNSRoot" `
    -DisplayName $ServiceName `
    -Description "Kerberos Service User for $ServiceName" `
    -Path $UserBaseDN -AccountPassword $SecurePassword `
    -Enabled $true `
    -KerberosEncryptionType "AES128, AES256"

Write-Host "INFO : Create Service Principal Name (SPN) DB server $ServiceName."
setspn $ServiceName -s oracle/$ServiceName.$DNSRoot

Write-Host '= Finished Setup KRB Service Name =================================='
# - EOF ------------------------------------------------------------------------
