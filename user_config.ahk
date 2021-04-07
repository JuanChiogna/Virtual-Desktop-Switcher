; Disable CapsLock functionality. Yuck, such a disgusting key.
SetCapsLockState, AlwaysOff

; ----------------------------------------------------------------------------------------------------
; GENERAL USE:
; CapsLock                  -->  Show current virtual desktop
; CapsLock + <key>          -->  Switch to desired virtual desktop
; CapsLock + ctrl + <key>   -->  Move active window to desired virtual desktop
; CapsLock + shift + <key>    -->  Move active window to desired virtual desktop, and switch to it
; CapsLock + alt + <key>  -->  Move all windows to desired virtual desktop, and switch to it

; LIST OF KEYS:
; A / Left  -->  Switch to virtual desktop on the left
; S / Right -->  Switch to virtual desktop on the right
; D         -->  Close current window
; F         -->  Toogle always on top
; Tab       -->  Toggles between current and last opened virtual desktops

; Q     --> Desktop 1
; W     --> Desktop 2
; E     --> Desktop 3
; R     --> Desktop 4

; Z     --> Desktop 5
; X     --> Desktop 6
; C     --> Desktop 7
; V     --> Desktop 8

; Space --> Desktop 8
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
CapsLock & r::Switch(4)

CapsLock & a::Switch("l")
CapsLock & s::Switch("r")
CapsLock & d::Send !{F4}
CapsLock & f::Winset, Alwaysontop, Toggle, A

CapsLock & z::Switch(5)
CapsLock & x::Switch(6)
CapsLock & c::Switch(7)
CapsLock & v::Switch(8)

CapsLock & Space::Switch(0)


; Manages ctrl / alt / shift functionality
Switch(target) {
    if GetKeyState("Alt") {
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
            switchDesktopByNumber(target)
        }
    }
    else if GetKeyState("Shift") {
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