-- AnyConnect now refered to as targetApp
set targetApp to "Cisco AnyConnect Secure Mobility Client"


-- Determine if AnyConnect is currently running
tell application "System Events"
	set processExists to exists process targetApp
end tell


-- Close connection if running; else start connection and fill in password
if processExists is true then
	tell application targetApp
		quit
	end tell
else
	set vpnPasswd to the text returned of (display dialog "NRG Password" default answer "")

	tell application targetApp
		activate
	end tell

	tell application "System Events"
		-- Wait for first window to open. Press "return".
		repeat until (window 1 of process targetApp exists)
			delay 1
		end repeat
		keystroke return

		-- Wait for second window to open. Enter password. Press "return".
		repeat until (window 2 of process targetApp exists)
			delay 2
		end repeat
		tell process targetApp
			keystroke (vpnPasswd as string)
			keystroke return
		end tell

	end tell
end if
