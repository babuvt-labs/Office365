# VBA Project Unlock Tool (64-bit Excel)

## VBA Code

```vb
Private Const PAGE_EXECUTE_READWRITE = &H40

Private Declare PtrSafe Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" _
    (Destination As LongPtr, Source As LongPtr, ByVal Length As LongPtr)

Private Declare PtrSafe Function VirtualProtect Lib "kernel32" (lpAddress As LongPtr, _
    ByVal dwSize As LongPtr, ByVal flNewProtect As LongPtr, lpflOldProtect As LongPtr) As LongPtr

Private Declare PtrSafe Function GetModuleHandleA Lib "kernel32" (ByVal lpModuleName As String) As LongPtr

Private Declare PtrSafe Function GetProcAddress Lib "kernel32" (ByVal hModule As LongPtr, _
    ByVal lpProcName As String) As LongPtr

Private Declare PtrSafe Function DialogBoxParam Lib "user32" Alias "DialogBoxParamA" (ByVal hInstance As LongPtr, _
    ByVal pTemplateName As LongPtr, ByVal hWndParent As LongPtr, _
    ByVal lpDialogFunc As LongPtr, ByVal dwInitParam As LongPtr) As Integer

Dim HookBytes(0 To 11) As Byte
Dim OriginBytes(0 To 11) As Byte
Dim pFunc As LongPtr
Dim Flag As Boolean

Private Function GetPtr(ByVal Value As LongPtr) As LongPtr
    GetPtr = Value
End Function

Public Sub RecoverBytes()
    If Flag Then MoveMemory ByVal pFunc, ByVal VarPtr(OriginBytes(0)), 12
End Sub

Public Function Hook() As Boolean
    Dim TmpBytes(0 To 11) As Byte
    Dim p As LongPtr, osi As Byte
    Dim OriginProtect As LongPtr

    Hook = False

#If Win64 Then
    osi = 1
#Else
    osi = 0
#End If

    pFunc = GetProcAddress(GetModuleHandleA("user32.dll"), "DialogBoxParamA")

    If VirtualProtect(ByVal pFunc, 12, PAGE_EXECUTE_READWRITE, OriginProtect) <> 0 Then
        MoveMemory ByVal VarPtr(TmpBytes(0)), ByVal pFunc, osi + 1

        If TmpBytes(osi) <> &HB8 Then
            MoveMemory ByVal VarPtr(OriginBytes(0)), ByVal pFunc, 12

            p = GetPtr(AddressOf MyDialogBoxParam)

            If osi Then HookBytes(0) = &H48
            HookBytes(osi) = &HB8
            osi = osi + 1

            MoveMemory ByVal VarPtr(HookBytes(osi)), ByVal VarPtr(p), 4 * osi

            HookBytes(osi + 4 * osi) = &HFF
            HookBytes(osi + 4 * osi + 1) = &HE0

            MoveMemory ByVal pFunc, ByVal VarPtr(HookBytes(0)), 12

            Flag = True
            Hook = True
        End If
    End If
End Function

Private Function MyDialogBoxParam(ByVal hInstance As LongPtr, _
    ByVal pTemplateName As LongPtr, ByVal hWndParent As LongPtr, _
    ByVal lpDialogFunc As LongPtr, ByVal dwInitParam As LongPtr) As Integer

    If pTemplateName = 4070 Then
        MyDialogBoxParam = 1
    Else
        RecoverBytes
        MyDialogBoxParam = DialogBoxParam(hInstance, pTemplateName, _
            hWndParent, lpDialogFunc, dwInitParam)
        Hook
    End If
End Function

Sub UnprotectVBA()
    If Hook Then
        MsgBox "VBA Project is unprotected!", vbInformation, "VBA Unlocked"
    End If
End Sub
```

---

## Notes

- The above code is intended for **64-bit Excel**.
- A separate version may be required for **32-bit Excel** (not tested here).

---

## How to Check Excel Version

- Open Excel  
- Go to **File → Account → About Excel**  
- Check whether it says **32-bit** or **64-bit**

---

## Steps to Use the Macro

1. Keep the Excel file open that contains the locked VBA project.
2. Open a **new Excel file**.
3. Open the **VBA Editor**:
   - Press `ALT + F11`  
   - Or go to **Developer → Visual Basic`
4. Insert a new module:
   - `Insert → Module`
5. Copy and paste the VBA code into the module.
6. Place the cursor inside the `UnprotectVBA` subroutine.
7. Run the macro:
   - Press `F5`  
   - Or click **Run**

---

## Expected Result

A message box will appear:

```
VBA Project is unprotected!
```

After closing the message:
- Return to the VBA editor
- The VBA project should now be accessible
