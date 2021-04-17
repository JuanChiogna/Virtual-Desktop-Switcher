; Disable CapsLock functionality. Yuck, such a disgusting key.
SetCapsLockState, AlwaysOff

; ----------------------------------------------------------------------------------------------------
; GENERAL USE:
; CapsLock                       -->  Show current virtual desktop
; CapsLock + <key>               -->  Switch to desired virtual desktop
; CapsLock + ctrl + <key>        -->  Move active window to desired virtual desktop
; CapsLock + alt  + <key>        -->  Move active window to desired virtual desktop, and switch to it
; CapsLock + ctrl + alt + <key>  -->  Move all windows to desired virtual desktop, and switch to it

; LIST OF KEYS:
; A / Left  -->  Switch to virtual desktop on the left
; S / Right -->  Switch to virtual desktop on the right
; D         -->  Show current desktop
; Tab       -->  Toggles between current and last opened virtual desktops

; Q     --> Desktop 1
; W     --> Desktop 2
; E     --> Desktop 3

; Z     --> Desktop 4
; X     --> Desktop 5
; C     --> Desktop 6

; 1     --> Desktop 7
; 2     --> Desktop 8
; 3     --> Desktop 9
; ----------------------------------------------------------------------------------------------------
CapsLock & d::
showCurrent()
KeyWait, d
hideCurrent()
return

CapsLock & tab::Switch("t")

CapsLock & q::Switch(1)
CapsLock & w::Switch(2)
CapsLock & e::Switch(3)

CapsLock & a::Switch("l")
CapsLock & s::Switch("r")

CapsLock & z::Switch(4)
CapsLock & x::Switch(5)
CapsLock & c::Switch(6)

CapsLock & 1::Switch(7)
CapsLock & 2::Switch(8)
CapsLock & 3::Switch(9)

; Manages ctrl / alt / shift functionality
Switch(target) {
    if (GetKeyState("Control", "P") and GetKeyState("Alt", "P")) {
        if (target == "t") {
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToLast()
            }
            switchDesktopToLast()
        }
        else if (target == "l") {
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToLeft()
            }
            Sleep 10
            switchDesktopToLeft()
        }
        else if (target == "r") {
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToRight()
            }
            Sleep 10
            switchDesktopToRight()
        }
        else if (target == 0) {
            DesktopCount := LastNumber()
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToDesktop(DesktopCount)
            }
            Sleep 10
            switchDesktopByNumber(DesktopCount)
        }     
        else {
            WinGet, List, List
            Loop % List {
                WinActivate, % "ahk_id " List%A_Index%
                MoveCurrentWindowToDesktop(target)
            }
            Sleep 10
            switchDesktopByNumber(target)
        }
    }
    else if GetKeyState("Alt", "P") {
        focusTheForemostWindow()
        if (target == "t") {
            MoveCurrentWindowToLast()
            switchDesktopToLast()
        }
        else if (target == "l") {
            MoveCurrentWindowToLeft()
            switchDesktopToLeft()
        }
        else if (target == "r") {
            MoveCurrentWindowToRight()
            switchDesktopToRight()
        }
        else if (target == 0) {
            DesktopCount := LastNumber()
            MoveCurrentWindowToDesktop(DesktopCount)
            switchDesktopByNumber(DesktopCount)
        }     
        else {
            MoveCurrentWindowToDesktop(target)
            switchDesktopByNumber(target)
        }
    }
    else if GetKeyState("Control", "P") {
        focusTheForemostWindow()
        if (target == "t") {
            MoveCurrentWindowToLast()
        }
        else if (target == "l") {
            MoveCurrentWindowToLeft()
        }
        else if (target == "r") {
            MoveCurrentWindowToRight()     
        }
        else if (target == 0) {
            DesktopCount := LastNumber()
            MoveCurrentWindowToDesktop(DesktopCount)
        }
        else {
            MoveCurrentWindowToDesktop(target)
        }
    }
    else {
        if (target == "t") {
            switchDesktopToLast()
        }
        else if (target == "l") {
            switchDesktopToLeft()
        }
        else if (target == "r") {
            switchDesktopToRight()
        }
        else if (target == 0) {
            DesktopCount := LastNumber()
            switchDesktopByNumber(DesktopCount)
        }
        else {
            switchDesktopByNumber(target)
        }
    }
}