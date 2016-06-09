This is the git repo for the automatic digilent setup.

For the display cases outside 125 Cory

Setup:

0) Pre-reqs.  Assumes:
-Raspi, running Jessie Debian version of Raspbian.
-Normal monitors, etc, that go with a raspi.
-The Raspi has been setup to auto-logon to its GUI
-A digilent explorer board.

1) Get internet onto the raspi.
Usually, this is best done w/ a wifi dongle connecting to calvisitor.  Setup of this implimentation is pretty easy.

If you're doing anything else, you're on your own.  Google will help you.


2) Clone this repo onto the raspi's DESKTOP.

git clone git clone https://github.com/dHutchings/auto_digilent.git

3) Run the following installs, while located in the git repo you just cloned.

sudo apt-get install git-cola

sudo dpkg -i digilent.waveforms_3.2.6_armhf.deb
sudo dpkg -i digilent.adept.runtime_2.16.1-armhf.deb 


//sudo dpkg -i digilent.adept.2.16.1-armnf.deb
//this one isn't needed---i think

4) Edit the file to auto-start the scripts.

Note: there are many ways to auto-boot scripts.
Unfortuantely, most of the go-to options (I.E. Crontab) doesn't work here, because of graphics driver problems.

navigate to the LXDE autostart file:
cd ~/.config/lxsession/LXDE-pi/

edit the autostart file:
sudo nano autostart

add the following line to the bottom:
@/home/pi/Desktop/auto_digilent/auto_digilent/auto_run.sh

Then, close the file (CTRL-X, then "Y").

5) Setup the options you want the waveforms to boot into.

Startup waveforms, by running 'waveforms' from a terminal.
Once it boots, check the option "Open last session on boot"
Then, setup waveform to have the exact, running, setup that you want it to auto-boot to.
Then, save the workspace.

Now, every time waveforms is opened, it should automatically boot into the workspace you want, except with every instrument off.

6) Calibrate the click locations.

Now, you will be editing the auto_run.sh file, starting on line 36:
nano auto_boot.sh

You will have to calibrate the mouse movements & clicks to the specific workspace you want.
You can see a thoroughly commencted example in this commit, just change the XY locations to match your own needs
Add additional mousemoves / mouse clicks as needed.

You can test the script itself by running the script from the command line:
./auto_boot.sh

The script is intelligent enough to determine if waveforms is already booted or not, and only boot it if needed.

the xdotool mousemove command is a little hectic, so just pay attention to the last two numbers.
Those are the x/y locations that the cursor is moved to, measured in pixels from the top-left corner of the waveforms window.


7) Test, and repeat 6 as needed.

Once it runs by directly calling the script, reboot the raspi and see if autoboot works.
