// =====================================================================
// main.bicep  -  SYNTHETIC DEMO IaC (Make-A-Wish America IT)
// Sample Azure deployment with DELIBERATE misconfigurations and gaps
// for the "audit this IaC" demo. DO NOT DEPLOY. All values fabricated.
//
// Planted issues (for the demo to find):
//   - Storage account allows public blob access
//   - Storage allows HTTP (no HTTPS-only) and TLS 1.0
//   - Key Vault has public network access enabled, no purge protection
//   - Hardcoded secret / connection string in a parameter default
//   - Resources missing tags (no owner/cost-center/environment)
//   - No diagnostic settings / logging on any resource
//   - SQL server admin password hardcoded
//   - NSG rule opens RDP (3389) to the internet
// =====================================================================

param location string = resourceGroup().location

// ISSUE: hardcoded secret in a parameter default
param sqlAdminPassword string = 'P@ssw0rd-DEMO-123!'

// ISSUE: hardcoded connection string / secret value
var storageConnectionString = 'DefaultEndpointsProtocol=http;AccountName=fakedemo;AccountKey=AAAAFAKEKEY1234567890==;'

// ---- Storage account (multiple misconfigs, no tags) ----
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'mawdemostorage001'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true          // ISSUE: public blob access enabled
    supportsHttpsTrafficOnly: false      // ISSUE: HTTP allowed
    minimumTlsVersion: 'TLS1_0'          // ISSUE: weak TLS
    networkAcls: {
      defaultAction: 'Allow'             // ISSUE: open to all networks
    }
  }
  // ISSUE: no tags
}

// ---- Key Vault (public, no protections, no tags) ----
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'maw-demo-kv-001'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: false       // ISSUE: legacy access policies
    enableSoftDelete: false              // ISSUE: soft delete off
    enablePurgeProtection: false         // ISSUE: purge protection off
    publicNetworkAccess: 'Enabled'       // ISSUE: public network access
    networkAcls: {
      defaultAction: 'Allow'             // ISSUE: open
      bypass: 'AzureServices'
    }
  }
  // ISSUE: no tags
}

// ---- SQL Server (hardcoded admin password, no auditing) ----
resource sql 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: 'maw-demo-sql-001'
  location: location
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: sqlAdminPassword   // ISSUE: hardcoded via default param
    publicNetworkAccess: 'Enabled'                 // ISSUE: public access
    minimalTlsVersion: '1.0'                        // ISSUE: weak TLS
  }
  // ISSUE: no auditing/diagnostic settings, no tags
}

// ---- NSG with an over-permissive rule ----
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'maw-demo-nsg-001'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP-Any'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'   // ISSUE: RDP open
          sourceAddressPrefix: '*'        // ISSUE: from any source (internet)
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
  // ISSUE: no tags
}

output storageConn string = storageConnectionString  // ISSUE: secret in output
