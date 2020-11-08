SetCapsLockState, AlwaysOff

Switch(targetDesktop) {
    if GetKeyState("Alt") and GetKeyState("Control")
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

CapsLock & q::Switch(1)
CapsLock & w::Switch(2)
CapsLock & e::Switch(3)
CapsLock & a::Switch(4)
CapsLock & s::Switch(5)
CapsLock & d::Switch(6)
CapsLock & z::Switch(7)
CapsLock & x::Switch(8)
CapsLock & c::Switch(9)

CapsLock::showCurrent()
#CapsLock::Send #{tab}

CapsLock & tab::
if GetKeyState("Alt") and GetKeyState("Control") {
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

CapsLock & left::
if GetKeyState("Alt") and GetKeyState("Control") {
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

CapsLock & right::
if GetKeyState("Alt") and GetKeyState("Control") {
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