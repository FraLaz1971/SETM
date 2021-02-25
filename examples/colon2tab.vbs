Option Explicit
Dim objFSO, strFileName, txsInput, strInput, strOutput
If InStr( LCase(WScript.FullName), "cscript" ) <> 0 Then
	Const FOR_READING = 1
	Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
	strFilename = WScript.Arguments(0)
	Set txsInput = objFSO.OpenTextFile(strFileName, FOR_READING)
	Do Until txsInput.AtEndOfStream
		strInput = txsInput.ReadLine
		strOutput = Replace( strInput, ":", vbTab )
		Call WScript.StdOut.WriteLine(strOutput)
	Loop
	txsInput.Close
Else
	Call WScript.StdErr.WriteLine("ERROR")
End If
