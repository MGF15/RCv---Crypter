#CS
	RCv Crypter Coded by dogo h@ck
#CE
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <FileConstants.au3>
#include <Crypt.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ###
$Form1_1 = GUICreate("Rcv - Crypter", 278, 359, 192, 124)
GUISetFont(8, 400, 0, "Audiowide")
GUISetBkColor(0xACA899)
$Label1 = GUICtrlCreateLabel("Rcv - Crypter", 24, 24, 230, 41)
GUICtrlSetFont(-1, 22, 400, 0, "Audiowide")
GUICtrlSetColor(-1, 0x316AC5)
$Browser = GUICtrlCreateButton("Browser", 40, 112, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Audiowide")
$DeCrypt = GUICtrlCreateButton("DeCrypt", 96, 296, 83, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Audiowide")
$EnCrypt = GUICtrlCreateButton("EnCrypt", 96, 256, 83, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Audiowide")
$Input1 = GUICtrlCreateInput("Your Key", 40, 160, 200, 25)
GUICtrlSetFont(-1, 10, 400, 0, "Audiowide")
GUICtrlSetColor(-1, 0x008080)
$Yor = GUICtrlCreateCombo("Your Algorithm", 80, 200, 121, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "AES(256-bit)|DES|RC2|RC4")
$Button1 = GUICtrlCreateButton("Save As", 148, 112, 91, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Audiowide")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg

		Case $GUI_EVENT_CLOSE
			Exit
		Case $Browser
			$R = FileOpenDialog("Select File",@Workingdir,"All (*.*)")

		Case $Button1
			$T = FileSaveDialog("Save As",@Workingdir,"All (*.*)")

		Case $Input1
			$ky = GUICtrlRead($Input1)

		Case $Yor
			$algo = GUICtrlRead($Yor)

			Switch $algo

                Case "AES(256-bit)"
                    $iAlgorithm = $CALG_AES_256
                Case "DES"
                    $iAlgorithm = $CALG_DES
                Case "RC2"
                    $iAlgorithm = $CALG_RC2
                Case "RC4"
                    $iAlgorithm = $CALG_RC4
            EndSwitch
		Case $EnCrypt
			$ky = GUICtrlRead($Input1)
			if $ky = "Your Key" Then
				msgbox(1,"","Please Enter Key")
			Endif
			$algo = GUICtrlRead($Yor)
			if $algo = "Your Algorithm" Then
				msgbox(1,'','Please Select Your Algorithm !')
			Endif
			if $algo <> "Your Algorithm" And $ky <> "Your Key" Then
				$EnCrypted = _Crypt_EncryptFile($R,$T,$Ky,$iAlgorithm)
				if $EnCrypted  Then
					msgbox(64,'Rcv - Crypter','File EnCrypted Successfully' & @CRLF & "Don't Forget Your Algorithm and Key To DeCrypt File !")
				Endif
			Endif
		Case $DeCrypt
			$ky = GUICtrlRead($Input1)
			if $ky = "Your Key" Then
				msgbox(1,"","Please Enter Key")
			Endif
			$algo = GUICtrlRead($Yor)
			if $algo = "Your Algorithm" Then
				msgbox(1,'','Please Select Your Algorithm !')
			Endif
			if $algo <> "Your Algorithm" And $ky <> "Your Key" Then
				$DeCrypted = _Crypt_DecryptFile($R,$T,$ky,$iAlgorithm)
				if $DeCrypted = True Then
					msgbox(4,'','File DeCrypted Successfully')
				Endif
			Endif
	EndSwitch
WEnd
