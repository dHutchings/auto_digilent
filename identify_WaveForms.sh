#!/bin/bash

#construct an array of window id's
WINDOW_STRING="$(xdotool search --onlyvisible .)"
array=($WINDOW_STRING)

waveforms_window=""
for element in "${array[@]}"
do
	#iterate over the elements
	#echo out the window
	window_name=$(xdotool getwindowname $element)
	if [[ $window_name == *"WaveForms"* ]]
	then
		echo "Found waveform window el" $element
		waveforms_window=$element
	fi
done

echo "Waveforms Window is" $waveforms_window
