REM Set L2TP password
SET L2tpPsk=

REM Set Name of VPN Connection
SET Name=

REM Set Server Address of VPN Connection (ex. vpn.contoso.com)
SET ServerAddress=

REM Set RememberCredential to [-RememberCredential] if you want credentials cached, leave blank otherwise.
SET RememberCredential=

REM Set SplitTunneling to [-SplitTunneling] to disallow traffic to destinations outside of intranet through VPN tunnel, leave blank to allow.
SET SplitTunneling=

powershell.exe "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -Command "Add-VpnConnection -Name """""""""%Name%""""""""" -AllUserConnection -ServerAddress """""""""%ServerAddress%""""""""" -TunnelType """""""""L2TP""""""""" -L2tpPsk """""""""%L2tpPsk%""""""""" %RememberCredential% %SplitTunneling% -Force"' -Verb RunAs"