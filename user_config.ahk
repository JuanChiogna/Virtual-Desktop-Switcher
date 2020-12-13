; Disable CapsLock functionality. Yuck, such a disgusting key.
SetCapsLockState, AlwaysOff

; ----------------------------------------------------------------------------------------------------
; GENERAL USE:
; CapsLock                  -->  Show current virtual desktop
; CapsLock + <key>          -->  Switch to desired virtual desktop
; CapsLock + ctrl + <key>   -->  Move active window to desired virtual desktop
; CapsLock + alt + <key>    -->  Move active window to desired virtual desktop, and switch to it

; LIST OF KEYS:
; <key>   -->  By default:   Q : 1   W : 2   E : 3   A : 4   S : 5   D : 6   Z : 7   X : 8   C : 9
; Left    -->  Leftmost virtual desktop
; Right   -->  Rightmost virtual desktop
; Tab     -->  Toggles between current and last opened virtual desktops
; ----------------------------------------------------------------------------------------------------

; Show current virtual desktop
CapsLock::showCurrent()

; Switch to desired virtual desktop
CapsLock & q::Switch(1)
CapsLock & w::Switch(2)
CapsLock & e::Switch(3)
CapsLock & a::Switch(4)
CapsLock & s::Switch(5)
CapsLock & d::Switch(6)
CapsLock & z::Switch(7)
CapsLock & x::Switch(8)
CapsLock & c::Switch(9)

; Manages ctrl / alt functionality
Switch(targetDesktop) {
    ; if GetKeyState("Control") and GetKeyState("Alt")
    if GetKeyState("Alt")
    {
        MoveCurrentWindowToDesktop(targetDesktop)
        switchDesktopByNumber(targetDesktop)
    }
    else if GetKeyState("Control")
    {
        MoveCurrentWindowToDesktop(targetDesktop)
    }
    else
    {
        switchDesktopByNumber(targetDesktop)
    }
}

; Toggles between current and last virtual desktops
CapsLock & tab::
if GetKeyState("Alt") {
    MoveCurrentWindowToLast()
    switchDesktopToLast()
}
else if GetKeyState("Control") {
    MoveCurrentWindowToLast()
}
else {
    switchDesktopToLast()
}
return

; Switch to leftmost virtual desktop
CapsLock & left::
if GetKeyState("Alt") {
    MoveCurrentWindowToLeft()
    switchDesktopToLeft()
}
else if GetKeyState("Control") {
    MoveCurrentWindowToLeft()
}
else {
    switchDesktopToLeft()
}
return

; Switch to rightmost virtual desktop
CapsLock & right::
if GetKeyState("Alt") {
    MoveCurrentWindowToRight()
    switchDesktopToRight()
}
else if GetKeyState("Control") {
    MoveCurrentWindowToRight()
}
else {
    switchDesktopToRight()
}
return

^+left::switchDesktopToLeft()
^+right::switchDesktopToRight()