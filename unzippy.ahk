Array := []

While, True {
    Loop Files, C:\Users\%A_UserName%\Downloads\*.zip, ;R  ; søk i subfoldere
    {
        If (HasVal(Array, A_LoopFileFullPath) = 0) {
            MsgBox, 4, , Found zip: %A_LoopFileFullPath%`n`Unzip?
            IfMsgBox, Yes 
            RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%A_LoopFileFullPath%' -DestinationPath %A_Desktop%,, Hide
            FileDelete, %A_LoopFileFullPath%
            IfMsgBox, No 
            Array.Push(A_LoopFileFullPath)
        }
    }
}

HasVal(haystack, needle) {
    for index, value in haystack
        if (value = needle)
        return index
    if !(IsObject(haystack))
        throw Exception("Bad haystack!", -1, haystack)
    return 0
}