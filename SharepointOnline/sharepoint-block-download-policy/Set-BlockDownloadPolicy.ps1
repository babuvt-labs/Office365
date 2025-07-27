# --- Step 1: Install SharePoint Online Management Shell (if not already installed) ---
# If you haven't installed it, uncomment and run the following line:
# Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force

# --- Step 2: Define Your Tenant Name ---
# Replace <yourtenant> with your actual tenant prefix (e.g., contoso, fabrikam)
$tenantName = "<yourtenant>"

# --- Step 3: Connect to SharePoint Online ---
# Construct the admin center URL and connect. You will be prompted for admin credentials.
$adminUrl = "https://$tenantName-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl

# --- Step 4: Define the Site URL ---
# Replace 'my-site' with your actual site name
$siteUrl = "https://$tenantName.sharepoint.com/sites/my-site"
# Example:
# $siteUrl = "https://contoso.sharepoint.com/sites/INDIA25"

# --- Step 5: Apply the Block Download Policy ---
# This command will prevent all users from downloading content.
Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true

# --- OPTIONAL: Exclude site owners from block download policy ---
# Uncomment the below line to allow site owners to download content.
# Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true -ExcludeBlockDownloadPolicySiteOwners $true

# --- Step 6: (Optional) Verify that the policy is set correctly ---
Get-SPOSite -Identity $siteUrl | Select-Object Url, BlockDownloadPolicy

# --- Step 7: Disconnect from SharePoint Online ---
Disconnect-SPOService

# --- OPTIONAL Step 8: Remove the Block Download Policy (Revert) ---
# To remove the block and allow everyone to download again, run:
# Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $false
