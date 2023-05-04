<#
This script is provided as a convenience for Level.io customers. We cannot 
guarantee this will work in all environments. Please test before deploying
to your production environment.  We welcome contribution to the scripts in 
our community repo!

.DESCRIPTION
    Pull Office Product Key
.LANGUAGE
    PowerShell
.TIMEOUT
    600
.LINK
#>

$OfficeKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
if ($OfficeKey) {
    $OfficeKey
}
else {
    wmic path SoftwareLicensingService get OA3xOriginalProductKey
}

#Office 2016-2021 (32-bit) on a 32-bit Windows OS   "C:\Program Files\Microsoft Office\Office16\OSPP.vbs" 
#Office 2016-2021 (32-bit) on a 64-bit Windows OS   "C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS"
#Office 2016-2021 (64-bit) on a 64-bit Windows OS   "C:\Program Files\Microsoft Office\Office16\OSPP.VBS"
#Office 2013 (32-bit) on a 32-bit Windows OS    "C:\Program Files\Microsoft Office\Office15\OSPP.VBS"
#Office 2013 (32-bit) on a 64-bit Windows OS    "C:\Program Files (x86)\Microsoft Office\Office15\OSPP.vbs"
#Office 2013 (64-bit) on a 64-bit Windows OS    "C:\Program Files (x86)\Microsoft Office\Office15\OSPP.VBS"
#Office 2010 (32-bit) on a 32-bit Windows OS    "C:\Program Files\Microsoft Office\Office14\OSPP.VBS"
#Office 2010 (32-bit) on a 64-bit Windows OS    "C:\Program Files (x86)\Microsoft Office\Office14\OSPP.VBS"
#Office 2010 (64-bit) on a 64-bit Windows OS    "C:\Program Files\Microsoft Office\Office14\OSPP.VBS"
#Office 2007 (32-bit) on a 32-bit Windows OS    "C:\Program Files\Microsoft Office\Office12\OSPP.VBS"
#Office 2007 (32-bit) on a 64-bit Windows OS    "C:\Program Files (x86)\Microsoft Office\Office12\OSPP.VBS"
#Office 2007 (64-bit) on a 64-bit Windows OS    "C:\Program Files\Microsoft Office\Office12\OSPP.VBS"
#Office 2003 (32-bit) on a 32-bit Windows OS    "C:\Program Files\Microsoft Office\Office11\OSPP.VBS"
#Office 2003 (32-bit) on a 64-bit Windows OS    "C:\Program Files (x86)\Microsoft Office\Office11\OSPP.VBS"
#Office 2003 (64-bit) on a 64-bit Windows OS    "C:\Program Files\Microsoft Office\Office11\OSPP.VBS"

$OfficePaths = @"
"C:\Program Files\Microsoft Office\Office16\OSPP.vbs"
"C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office16\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office15\OSPP.VBS"
"C:\Program Files (x86)\Microsoft Office\Office15\OSPP.vbs"
"C:\Program Files (x86)\Microsoft Office\Office15\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office14\OSPP.VBS"
"C:\Program Files (x86)\Microsoft Office\Office14\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office14\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office12\OSPP.VBS"
"C:\Program Files (x86)\Microsoft Office\Office12\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office12\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office11\OSPP.VBS"
"C:\Program Files (x86)\Microsoft Office\Office11\OSPP.VBS"
"C:\Program Files\Microsoft Office\Office11\OSPP.VBS"
"@ -split "`n" | ForEach-Object { $_.trim() }

foreach ($OfficePath in $OfficePaths) {
    if (Get-Item $OfficePath -ErrorAction SilentlyContinue) {
        cscript $OfficePath /dstatus
    }
}
