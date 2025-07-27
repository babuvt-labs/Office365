# 🚫🔐 Secure Your SharePoint Online Sites Like a Pro! 🔐🚫

🔒 Have you ever needed to block downloads from a SharePoint site to protect sensitive data?  
Here are some common scenarios:

- 📁 During project phases where documents must remain read-only until sign-off  
- 🧾 To enforce audit controls and prevent unauthorized offline access  
- 🕵️‍♂️ For confidential deals, NDAs, or M&A document sharing  
- 🌐 For external user collaboration where download rights should be restricted  

I’ve just published a ready-to-use **PowerShell script** that helps **Microsoft 365 admins**:  
✅ Block file downloads for all users  
✅ Optionally exclude site owners from this restriction  
✅ Revert (remove) the policy when needed  
✅ Easily verify and control via **SharePoint Online Management Shell**

This script is ideal for:  
- Securing confidential project workspaces  
- Preventing unintentional data leaks  
- Meeting compliance or internal IT security needs  

---

# SharePoint Online Block Download Policy Script

This script automates the process of applying a **Block Download Policy** to a SharePoint Online site. This policy prevents users from downloading content from the specified site, with the option to exclude site owners if desired.

---

## **Prerequisites**
1. **PowerShell** installed on your machine.
2. **SharePoint Online Management Shell** module installed.
   - If not installed, run:
     ```powershell
     Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force
     ```
3. Administrator credentials for your SharePoint Online tenant.

---

## **Usage**

### **Step 1: Set Tenant Name**
Replace `<yourtenant>` with your tenant's prefix (e.g., `contoso`, `fabrikam`):
```powershell
$tenantName = "<yourtenant>"
```

---

### **Step 2: Connect to SharePoint Online**
The script will build the admin center URL and prompt for admin credentials:
```powershell
$adminUrl = "https://$tenantName-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl
```

---

### **Step 3: Define the Site URL**
Set the target site where the block download policy should be applied:
```powershell
$siteUrl = "https://$tenantName.sharepoint.com/sites/GEC25"
# Example:
# $siteUrl = "https://contoso.sharepoint.com/sites/INDIA25"
```

---

### **Step 4: Apply Block Download Policy**
Run the following command to block all users from downloading content:
```powershell
Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true
```

#### **Optional: Exclude Site Owners**
To allow site owners to download content:
```powershell
Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true -ExcludeBlockDownloadPolicySiteOwners $true
```

---

### **Step 5: Verify the Policy**
Check the current block download policy status:
```powershell
Get-SPOSite -Identity $siteUrl | Select-Object Url, BlockDownloadPolicy
```

---

### **Step 6: Disconnect**
Disconnect from SharePoint Online once done:
```powershell
Disconnect-SPOService
```

---

## **Reverting the Block Download Policy**
To remove the block and allow everyone to download content:
```powershell
Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $false
```

---

## **Quick Start: Full Script**
Copy and paste the following script into your PowerShell console, replacing `<yourtenant>` and `GEC25` with your actual values:

```powershell
# --- Step 1: Install SharePoint Online Management Shell (if not already installed) ---
# Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force

# --- Step 2: Define Your Tenant Name ---
$tenantName = "<yourtenant>"

# --- Step 3: Connect to SharePoint Online ---
$adminUrl = "https://$tenantName-admin.sharepoint.com"
Connect-SPOService -Url $adminUrl

# --- Step 4: Define the Site URL ---
$siteUrl = "https://$tenantName.sharepoint.com/sites/GEC25"
# Example:
# $siteUrl = "https://contoso.sharepoint.com/sites/INDIA25"

# --- Step 5: Apply the Block Download Policy ---
Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true

# --- OPTIONAL: Exclude site owners from block download policy ---
# Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $true -ExcludeBlockDownloadPolicySiteOwners $true

# --- Step 6: (Optional) Verify that the policy is set correctly ---
Get-SPOSite -Identity $siteUrl | Select-Object Url, BlockDownloadPolicy

# --- Step 7: Disconnect from SharePoint Online ---
Disconnect-SPOService

# --- OPTIONAL Step 8: Remove the Block Download Policy (Revert) ---
# Set-SPOSite -Identity $siteUrl -BlockDownloadPolicy $false
```

---

## **Notes**
- This script applies the policy at the site collection level.
- Ensure you have the required permissions before executing these commands.

---

## **References**
- [Microsoft Documentation - Set-SPOSite](https://learn.microsoft.com/powershell/module/sharepoint-online/set-sposite)
- [Microsoft Documentation - Connect-SPOService](https://learn.microsoft.com/powershell/module/sharepoint-online/connect-sposervice)
