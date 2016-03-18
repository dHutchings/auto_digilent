#!/bin/bash

#script to automatically run the digilent board.... only if it's plugged in.

echo "Determining if there is a digilent board plugged in..."

#pass the output of lsusb into grep, which counts how many instances of the "Digilent Development board JTAG" there are.
BOARDCOUNT="$(lsusb | grep --count 'Digilent\ Development\ board\ JTAG')"


#logic to compare boardcount to 0, so that we won't run the waveforms software
#if there is no board.
if [ "$BOARDCOUNT" -gt "0" ]; then

	echo "There is at least one board"
	#ampersand to boot waveforms & them immediately move on, instead of waiting for waveforms to close.
	echo "Will boot up waveforms if it is not running"
	if pgrep "waveforms" > /dev/null
	then
		echo "Running"
	else
		echo "Will boot - wait 3 min"
		waveforms &
		sleep 180
	fi

	#waveforms is setup to load the last workspace.... which is the workspace that this computer wants.
	#we will then use xdotool magic to enable it.
	echo "Running Window Identifier"
	source ./identify_WaveForms.sh
	echo "Window @ " $waveforms_window

	#moving mouse & click, on o-scope.  Click once will bring window to front & run the mouse click
	xdotool mousemove --window $waveforms_window 120 40
	xdotool click 1

	sleep 5
	xdotool mousemove --window $waveforms_window 250 40
	xdotool click 1

	sleep 5
	xdotool mousemove --window $waveforms_window 460 40
	xdotool click 1

	sleep 5
	xdotool mousemove --window $waveforms_window 0 0
else

	echo "There is no board"

fi
