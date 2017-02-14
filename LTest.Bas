/'
	Dialog Example, by fsw

	compile with:	fbc -s gui dialog.rc dialog.bas

'/

#Include Once "windows.bi"

#Include "LTest.bi"

Declare Sub CreateTextBoxes(ByVal hWin As HWND)
Declare Sub LoadList(ByVal hWin As HWND)
Declare Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer

'''
''' Program start
'''

	LoadNoPrintAscii()
	
	''
	'' Create the Dialog
	''
	hInstance=GetModuleHandle(NULL)
	DialogBoxParam(hInstance, Cast(ZString Ptr,dlgTest), NULL, @DlgProc, NULL)
	''
	'' Program has ended
	''

	ExitProcess(0)
	End

'''
''' Program end
'''
Function DlgProc(ByVal hWin As HWND,ByVal uMsg As UINT,ByVal wParam As WPARAM,ByVal lParam As LPARAM) As Integer
	Dim As Long id, Event, x, y
	Dim hBtn As HWND
	Dim rect As RECT
	Select Case uMsg
		Case WM_INITDIALOG
			'
			'LoadList(hWin)
		Case WM_CLOSE
			EndDialog(hWin, 0)
			'
		case WM_CTLCOLORSTATIC:
			' 1210 1211 1212 1213 1214 1215 1216 1217 
			' 1218 1219 1220 1221 1222 1223 1224 1225 
			' 1226 1227
 			' blue green red
    		'Dim As HDC hEdit = cast(HDC, wParam)
    		'Dim As HWND hCtrl = Cast(HWND, lParam)
			'Dim As Integer id
			'Dim As String s    		
    		'id = GetDlgCtrlID(hctrl)
    		'If id < 1213 Then
    		'	s = Str((id - textBoxes) Mod 8) + " " + Str(c)
    		'	'MessageBox(NULL, StrPtr(s), "eewww", MB_OK)
    		'EndIf
    		'If (id - textBoxes) Mod 8 = 0 AndAlso id > 1210 Then
    		'	c += 1
    		'	If c = 4 Then
    		'		'MessageBox(NULL, "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","www",MB_OK)
    		'		c = 0
    		'	EndIf
    		'EndIf 
    		'If id = 1227 Then
    		'	s = Str(c)
    		'	'Mess'ageBox(NULL, StrPtr(s), "eee",MB_OK)
    		'EndIf
 			'If c = 3 Then
 			'	SetTextColor( hEdit, RGBA(0, 0, 0, 0) )
    		'	SetBkColor  ( hEdit, RGBA(128, 255, 255, 0) )
    		'EndIf 
    		'
    	
    		return cast(INT_PTR, GetStockObject( WHITE_BRUSH ))

		Case WM_LBUTTONUP
			'Dim As String s
			'id=LoWord(wParam)
			'Event=HiWord(wParam)
			's = Str(id)
			'If id >= textboxes AndAlso id <= textBoxes + 255 Then 
			'	MessageBox(NULL, "yes", "yes", MB_OK)
			'Else
			'	MessageBox(NULL, StrPtr(s), "yes", MB_OK)
			'	
			'EndIf 
					
		Case WM_COMMAND
			id=LoWord(wParam)
			Event=HiWord(wParam)
			Select Case id
				Case cmdExit
					EndDialog(hWin, 0)
					'
				Case cmdTest
					'hBtn = GetDlgItem(hWin, txtTest)
					'MessageBox(NULL, "yes", "yes", MB_OK)
					SetWindowText(hBtn, GetAsciiChar(12))
					CreateTextBoxes(hWin)
				'Case 1210
					'Dim As String s = Str(event)
					
					'MessageBox(NULL, StrPtr(s), "yes", MB_OK)
				Case textboxes To textBoxes + 255
					If Event = WM_MOUSEMOVE Then
						
						Dim As zString * 256 s 
						GetWindowText(GetDlgItem(hwin, id), s, 256) 
						MessageBox(NULL, s, "yes", MB_OK)
					ElseIf event = WM_MBUTTONDOWN Then
						End
					EndIf 
					
				'Case Else
				'	Dim As String s = Str(id)
				'	MessageBox(NULL, "yes", StrPtr(s), MB_OK)
			End Select
		Case WM_SIZE
			GetClientRect(hWin,@rect)
			hBtn=GetDlgItem(hWin,IDC_BTN1)
			x=rect.right-100
			y=rect.bottom-35
			MoveWindow(hBtn,x,y,97,31,TRUE)
			LoadList(hWin)
			'
		Case Else
			Return FALSE
			'
	End Select
	Return TRUE

End Function
Sub CreateTextBoxes(ByVal hWin As HWND)
	' 3 45 top 5 top 21
	Dim As HWND tBox
	Dim As hwnd ccc
	Dim As Integer nX, nY, n
	Dim As Integer u = GetConsoleoutputCP()
	Dim As String s = Str(u)

	'dim As HFONT hfont1 = CreateFont(12, 10, 0, 0, _
   '                FW_NORMAL, TRUE, TRUE, TRUE,_
   '                ANSI_CHARSET, OUT_DEFAULT_PRECIS,_
   '                CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,_
   '                DEFAULT_PITCH or FF_ROMAN,_
   '                "Terminal")	

	dim As HFONT hfont1 = CreateFont( _
		12, 0, 0, 0, _
		FW_DONTCARE, _
		FALSE, _
		FALSE, _
		FALSE, _
		DEFAULT_CHARSET, _
		OUT_DEFAULT_PRECIS, _
		CLIP_DEFAULT_PRECIS, _
		DEFAULT_QUALITY, _
		DEFAULT_PITCH, _
		"Terminal")	
	For y As UByte = 1 To 16
		For x As UByte = 1 To 8
			nY = (y - 1) * 18 + 5
			nX = (x - 1) * 62 + 3

			Dim As String s
			s = GetAsciiChar(n)
			s = RightAlignNumber(n) + " - " + s

			tBox = CreateWindowEx(NULL, StrPtr("Edit"),NULL,WS_BORDER or ES_READONLY Or WS_CHILD Or WS_VISIBLE Or SS_SUNKEN Or SS_NOTIFY,_	'ES_READONLY
				 nX, nY, 62, 18, hWin, Cast(HMENU, textboxes + n),GetModuleHandle(NULL), NULL)

			Dim As HDC dc = GetDC(tBox)
			SendMessage(tBox, WM_SETFONT, Cast(lparam, hfont1), 0)
			SetWindowText(tbox, StrPtr(s))
			s = GetAsciiChar(n + 128)
			s = Str(n + 128) + " - " + s

			tBox = CreateWindowEx(NULL, StrPtr("Edit"),NULL,WS_BORDER or ES_READONLY Or WS_CHILD Or WS_VISIBLE Or SS_SUNKEN Or SS_NOTIFY,_
				 nX + 510, nY, 62, 18, hWin, Cast(HMENU, textboxes + n + 128),GetModuleHandle(NULL), NULL)

			SendMessage(tBox, WM_SETFONT, Cast(lparam, hfont1), 0)
			SetWindowText(tbox, StrPtr(s))
			
			s = GetAsciiChar(n)
			n += 1
		Next
	Next
	
	
	
End Sub
Sub LoadList(ByVal hWin As HWND)
	'
	Dim As HWND lst = GetDlgItem(hWin, lstTest)
	Dim As String s 
	'MessageBox(NULL, StrPtr(s), "ssss",MB_OK)
	For x As UByte = 0 To 31
		s = GetAsciiChar(x)
		SendMessage(lst, LB_ADDSTRING, 0, Cast(LPARAM, strptr(s)))
		'SendMessage(lst, LB_ADDSTRING, 0, Cast(LPARAM, StrPtr("test")))
	Next
	
End Sub

LowAscii:
Data "NUL", "Null", "SOH", "Start of Heading", "STX", "Start of Text", "ETX", "End of Text"
Data "EOT", "End of Transmission", "ENQ", "Enquiry", "ACK", "Acknowledgment", "BEL", "Bell"
Data " BS", "Back Space", " HT", "Horizontal Tab", " LF", "Line Feed", " VT", "Vertical Tab"
Data " FF", "Form Feed", " CR", "Carriage Return", " SO", "Shift Out / X-On", " SI", "Shift In / X-Off"
Data "DLE", "Data Line Escape", "DC1", "Device Control 1 (oft. XON)", "DC2", "Device Control 2", "DC3", "Device Control 3 (oft. XOFF)"
Data "DC4", "Device Control 4", "NAK", "Negative Acknowledgement", "SYN", "Synchronous Idle", "ETB", "End of Transmit Block"
Data "CAN", "Cancel", " EM", "End of Medium", "SUB", "Substitute", "ESC", "Escape"
Data " FS", "File Separator", " GS", "Group Separator", " RS", "Record Separator", " US", "Unit Separator"