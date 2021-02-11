; Disable CapsLock functionality. Yuck, such a disgusting key.
SetCapsLockState, AlwaysOff

; ----------------------------------------------------------------------------------------------------
; GENERAL USE:
; CapsLock                  -->  Show current virtual desktop
; CapsLock + <key>          -->  Switch to desired virtual desktop
; CapsLock + ctrl + <key>   -->  Move active window to desired virtual desktop
; CapsLock + alt + <key>    -->  Move active window to desired virtual desktop, and switch to it
; CapsLock + shift + <key>  -->  Move all windows to desired virtual desktop, and switch to it

; LIST OF KEYS:
; Z / Left  -->  Switch to virtual desktop on the left
; X / Right -->  Switch to virtual desktop on the right
; C         -->  Quick Alt Tab
; Tab       -->  Toggles between current and last opened virtual desktops

; Q     --> Desktop 1
; W     --> Desktop 2
; E     --> Desktop 3
; A     --> Desktop 4
; S     --> Desktop 5
; D     --> Desktop 6
; Space --> Desktop 7
; ----------------------------------------------------------------------------------------------------

; Show current virtual desktop
CapsLock::showCurrent(force:=True)

; Left, Right, and Last
CapsLock & left::Switch("l")
CapsLock & right::Switch("r")
CapsLock & tab::Switch("t")

CapsLock & m::toggleMsg()

; Switch to desired virtual desktop
CapsLock & q::Switch(1)
CapsLock & w::Switch(2)
CapsLock & e::Switch(3)

CapsLock & a::Switch(4)
CapsLock & s::Switch(5)
CapsLock & d::Switch(6)

CapsLock & z::Switch("l")
CapsLock & x::Switch("r")
CapsLock & c::Send !{tab}

CapsLock & Space::Switch(0)


; Manages ctrl / alt / shift functionality
Switch(target) {
    if GetKeyState("Shift") {
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
            switchDesktopToLeft()
        }
        else if (target == "r") {
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToRight()
            }
            switchDesktopToRight()
        }
        else if (target == 0) {
            DesktopCount := LastNumber()
            WinGet, List, List
            Loop % List {
                WinActivate % "ahk_id " List%A_Index%
                MoveCurrentWindowToDesktop(DesktopCount)
            }
            switchDesktopByNumber(DesktopCount)
        }     
        else {
            WinGet, List, List
            Loop % List {
                WinActivate, % "ahk_id " List%A_Index%
                MoveCurrentWindowToDesktop(target)
            }
        }
    }
    else if GetKeyState("Alt") {
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
    else if GetKeyState("Control") {
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