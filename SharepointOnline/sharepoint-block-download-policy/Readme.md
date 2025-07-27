# SharePoint Online - Block Download Policy Script

This PowerShell script helps **enforce or remove a download block policy** on a SharePoint Online site using the **SharePoint Online Management Shell**. It is especially useful for protecting sensitive content by preventing users from downloading documents from a site.

---

##Features

- Block downloads for a specific SharePoint Online site
- Optionally **exclude site owners** from this restriction
- Remove the block policy when no longer required
- Verify policy status with a single command
- Admin-friendly step-by-step format



📄 File Structure
- sharepoint-block-download-policy/
├── Set-BlockDownloadPolicy.ps1    # Full script
└── README.md                      # Documentation (this file)
