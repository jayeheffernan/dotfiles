global myProcessId, myProcess

tell application "System Events"
    set myProcessId to 
    set myProcess to 1st item of (processes whose unix id = myProcessId)
    tell myProcess to set frontmost to true
end tell
