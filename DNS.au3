Opt("TrayMenuMode", 1)
#RequireAdmin
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=C:\App\@ixjb94\dns\DNS.kxf
$DNS = GUICreate("DNS", 194, 108, -1, -1)
$setGoogle = GUICtrlCreateButton("Google", 8, 8, 75, 25)
$setRadar = GUICtrlCreateButton("Radar", 112, 40, 75, 25)
$setCloudflare = GUICtrlCreateButton("Cloudflare", 112, 8, 75, 25)
$set403 = GUICtrlCreateButton("403", 8, 40, 75, 25)
$unset = GUICtrlCreateButton("Unset", 8, 72, 75, 25)
GUICtrlSetBkColor(-1, 0xC8C8C8)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

        ;~ Set
        Case $setGoogle
            setDNS("Google")
        Case $setCloudflare
            setDNS("Cloudflare")
        Case $set403
            setDNS("403")
        Case $setRadar
            setDNS("Radar")

        ;~ Unset
        Case $unset
            unsetDNS()
	EndSwitch
WEnd


Func setDNS($kind)

    $first  = ""
    $second = ""

    If $kind == "Google" Then
        $first  = "8.8.8.8"
        $second = "8.8.4.4"

    ElseIf $kind == "Cloudflare" Then
        $first  = "1.1.1.1"
        $second = "1.0.0.1"

    ElseIf $kind == "403" Then
        $first  = "10.202.10.202"
        $second = "10.202.10.102"

    ElseIf $kind == "Radar" Then
        $first  = "10.202.10.10"
        $second = "10.202.10.11"
    EndIf

    Run(@ComSpec & ' /c powershell "foreach ($c in Get-NetAdapter) { write-host ''Setting DNS for'' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ServerAddresses (''' & $first & ''', ''' & $second & ''') }"', "", @SW_HIDE)
    MsgBox(0, "Set Done", $kind & " Done")
EndFunc

Func unsetDNS()
    Run(@ComSpec & ' /c powershell "foreach ($c in Get-NetAdapter) { write-host ''Unsetting DNS for'' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ResetServerAddresses }"', "", @SW_HIDE)
    MsgBox(0, "Unset", "Unset")
EndFunc