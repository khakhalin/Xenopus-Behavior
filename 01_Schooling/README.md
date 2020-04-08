----- U3 LabJack activation and software installation  

Note: software installation is dependent on operating system.

LabJack software/driver installation:

For Windows:

1.	Download, extract, and run the LabJack-2019-05-20.exe file to get the software bundle and drivers for the U3 LabJack (https://labjack.com/support/software/installers). Use the quickstart tutorial included on LabJack's website for information on how to run the various applications included (these are not used for running the schooling experiments): https://labjack.com/support/quickstart/u3


For macOS:

1. Download and unzip the Exodriver_NativeUSB_Setup.zip file (https://labjack.com/support/software/installers). This installation does not include utility applications compatible with Windows operating systems, but provides a native USB driver that can be used for low-level functions necessary to run schooling experiments.

LabJack Python Library installation:

2. Download and unzip the LabJackPython-5-26-2015.zip file (https://labjack.com/support/software/examples/ud/labjackpython).

3. Open a command prompt/terminal window and navigate to the LabJackPython directory (e.g., "cd Desktop/LabJackPython"). Then run one of the followign commands:

Windows:

python setup.py install

macOS:

$ sudo python setup.py install

----- GoPro activation and software installation

4.	Run the following command in a command prompt/terminal window to install packages and dependencies for interfacing with the GoPro:

$ pip install goprocam

5.	On the GoPro screen, navigate to Preferences>Connections>Wireless connections and turn your camera’s Wireless Connections ON.

6.	Using your computer, navigate to available wireless connections, locate your camera’s wireless identifier, and connect to your GoPro camera. Once connected, your command crompt/terminal window should display a message similar to:


7.	In the command prompt/terminal window, enter the following:

$ goPro = GoProCamera.GoPro(constants.gpcontrol)

8.	After entering the line of code above, a new message will appear that reads:

$ Waking up...
$ Camera successfully connected!
$ Connected to (%%.%.%.%) #your computer’s IP address  
