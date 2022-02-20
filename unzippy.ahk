Blacklist := []
CoordMode, Mouse, Screen

findZip:
    While, True {
        Loop Files, C:\Users\%A_UserName%\Downloads\*.zip, ;R  ; søk i subfoldere
        {
            If (HasVal(Blacklist, A_LoopFileFullPath) = 0) {
                MouseGetPos, mx, my
                Gui, New
                Gui, add, text, , Found zip: %A_LoopFileFullPath%`n`Unzip?
                Gui, add, button, xm gYes w40, Yes
                Gui, add, button, x+10 gNo w40, No
                Gui, Show, x%mx% y%my%, Unzippy
                ALFFP := A_LoopFileFullPath
                Return
            }
        }
    }

Yes:
    Gui, Destroy
    MouseGetPos, mx, my
    Gui, New
    Gui, Add, Text, , Select destination
    Gui, Add, ListBox, gAction vChoice w200 h80, Downloads|Desktop|Documents|Pictures
    Gui, Show, x%mx% y%my%, Unzippy
Return

No:
    Gui, Destroy
    Blacklist.Push(ALFFP)
    Goto, findZip
Return

Action:
    Gui, Submit
    If (Choice = "Downloads") {
        RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%ALFFP%' -DestinationPath C:\Users\%A_UserName%\Downloads\,, Hide
        FileDelete, %ALFFP%
        Goto, findZip
    }
    If (Choice = "Desktop") {
        RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%ALFFP%' -DestinationPath C:\Users\%A_UserName%\Desktop\,, Hide
        FileDelete, %ALFFP%
        Goto, findZip
    }
    If (Choice = "Documents") {
        RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%ALFFP%' -DestinationPath C:\Users\%A_UserName%\Documents\,, Hide
        FileDelete, %ALFFP%
        Goto, findZip
    }
    If (Choice = "Pictures") {
        RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%ALFFP%' -DestinationPath C:\Users\%A_UserName%\Pictures\,, Hide
        FileDelete, %ALFFP%
        Goto, findZip
    }
    Gui, Destroy
Return

HasVal(haystack, needle) {
    For index, value in haystack
        If (value = needle)
        Return index
    If !(IsObject(haystack))
        Throw Exception("Bad haystack!", -1, haystack)
Return 0
}
