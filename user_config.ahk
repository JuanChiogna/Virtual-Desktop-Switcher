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
; Left  -->  Switch to virtual desktop on the left
; Right -->  Switch to virtual desktop on the right
; Tab   -->  Toggles between current and last opened virtual desktops

; 0 / R --> Rightmost virtual desktop
; 1 / Q --> Desktop 1
; 2 / W --> Desktop 2
; 3 / E --> Desktop 3
; 4 / A --> Desktop 4
; 5 / S --> Desktop 5
; 6 / D --> Desktop 6
; 7 / Z --> Desktop 7
; 8 / X --> Desktop 8
; 9 / C --> Desktop 9
; ----------------------------------------------------------------------------------------------------

; Show current virtual desktop
CapsLock::showCurrent(force:=True)

; Left, Right, and Last
CapsLock & left::Switch("l")
CapsLock & right::Switch("r")
CapsLock & tab::Switch("t")

CapsLock & Space::Send #s
CapsLock & m::toggleMsg()

; Switch to desired virtual desktop
CapsLock & 1::Switch(1)
CapsLock & 2::Switch(2)
CapsLock & 3::Switch(3)
CapsLock & 4::Switch(4)
CapsLock & 5::Switch(5)
CapsLock & 6::Switch(6)
CapsLock & 7::Switch(7)
CapsLock & 8::Switch(8)
CapsLock & 9::Switch(9)
CapsLock & 0::Switch(0)

CapsLock & q::Command(1)
CapsLock & w::Command(2)
CapsLock & e::Command(3)
CapsLock & a::Command(4)
CapsLock & s::Command(5)
CapsLock & d::Command(6)
CapsLock & z::Command(7)
CapsLock & x::Command(8)
CapsLock & c::Command(9)
CapsLock & r::Command(0)

; Manages win functionality
Command(target) {
    if GetKeyState("LWin") {
        ; Q - Win Tab
        if (target == 1) {
            Send #{tab}
        }
        ; W - Alt Tab
        else if (target == 2) {
            Send w
        }
        ; E
        else if (target == 3) {
            Send e
        }
        ; A - Left
        else if (target == 4) {
            Send ^#{left}
            showCurrent()
        }
        ; S - Right
        else if (target == 5) {
            Send ^#{right}
            showCurrent()
        }
        ; D
        else if (target == 6) {
            Send d
        }
        ; Z
        else if (target == 7) {
            Send z
        }
        ; X
        else if (target == 8) {
            Send x
        }
        ; C
        else if (target == 9) {
            Send c
        }
        ; R
        else if (target == 0) {
            Send r
        }
    }
    else {
        Switch(target)
    }
}

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