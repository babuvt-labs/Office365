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

