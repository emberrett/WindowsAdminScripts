# WindowsAdminScripts
A collection of helpful scripts from my time as a system admin.


##InstallVPN.bat

Simple batch script to create L2TP VPN connection with pre-shared key on Windows 10. Once configured, will allow you to create VPN for all users in one click.

Batch script requires the following to be configured by the user prior to running .bat file:
*L2TP pre-shared key
*Name of the VPN connection
*Server Address of the VPN server

Optional settings include:
*Remember credentials
*Split tunneling

Batch script intializes elevated PowerShell script, which in turn runs another PowerShell script which bypasses the client's execution policy and adds a VPN based on the variables provided by the user.

##CreateUser.ps1
This PowerShell script creates a user in AD after prompting for the following user input:
*First name of the user
*Last name of the user
*Password for the user (as secure string)

The following variables will need to be modified for the specifications of whoever is running it:
*$FullUsername
*$SamAccountName
*$HomeDrive
*$HomeDirectory

The script runner will also need to modify what groups they would like the user to be added to.

After the variables are modified and the inputs are given, the script will:
*Create a user with the first letter of the provided first name and their full last name concatenated (John Smith > jsmith)
*Create a home directory (user drive), mapped to a directory under their name on the specified file server (if it doesn't already exist)
*Grant the user full permission to their home directory
*Set the DisplayName, GivenName, Surname, UserPrincipalName, SamAccountName, and EmailAddress attributes in AD to values based on the name provided
*Enable the user account
*Set a password based on the secure string provided
*Add user to the specified groups in AD

*Actual company name/domain replaced by Contoso, Microsoft's placeholder company.

##FindLostComputers.ps1
Summary: Finds computers in Active Directory that do not have a manager or description listed. Returns information about lost computers in CSV format.

This PowerShell script iterates through computers whose ManagedBy and Description attributes are null. Based on this list, the script pings each computer and returns the results into a CSV file which is exported to the scripts root, with the date as the title. Result columns include:

*Computer (Hostname)
*Status (Shows Offline or Online depending on ping results)
*LastLogon (Last date that computer was logged onto)
*IPv4 (IPv4 Address)
*OS (Operating System)

The results are sorted by Status, then LastLogon.

##MSIList.ps1
PowerShell script that provides list of MSIs installed on a Windows machine. Includes following information:
*Name (of the software the MSI installs)
*Identifying Number of MSI (GUID)
*LocalPackage (where the MSI is located)

The list is sorted by name.

##NumWin7Computers.ps1
Very simple PowerShell script that finds the number of Windows 7 computers listed in Active Directory. Can be easily modified to find total number of computers with any Windows OS.

