:*:zip::
Loop Files, C:\Users\lars\Downloads\*.zip, ;R  ; søk i subfoldere
{
    MsgBox, 3	, , Filepath = %A_LoopFileFullPath%`n`nContinue?`n`Filename = %A_LoopFileName%%A_LoopFileLongPath%
    IfMsgBox, Cancel
        return
    IfMsgBox, Yes
        Run PowerShell.exe -NoExit -Command Expand-Archive -LiteralPath '%A_LoopFileFullPath%' -DestinationPath %A_Desktop%,, Hide
}
return