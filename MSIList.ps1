get-wmiobject Win32_Product | sort Name| Format-Table Name, IdentifyingNumber, LocalPackage -AutoSize
Read-Host "Press Enter to Exit"