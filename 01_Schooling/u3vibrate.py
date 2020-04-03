# At this point, GoPro should be connected via wifi
# make sure the 2.4ghz connection is selected and connect via the computer's wifi 
from goprocam import GoProCamera, constants
goproCamera = GoProCamera.GoPro()

# Open the first found LabJack U3
import u3

import time

# Tic toc function so we can keep track of the timing of stimulus presentations
def tic():
    #Homemade version of matlab tic and toc functions
    import time
    global startTime_for_tictoc
    startTime_for_tictoc = time.time()

def toc():
    import time
    if 'startTime_for_tictoc' in globals():
        print "Elapsed time is " + str(time.time() - startTime_for_tictoc) + " seconds."
    else:
        print "Toc: start time not set"


vibrator = u3.U3()

FIO4_STATE_REGISTER = 6004
tic()
stim_stamp = [] # creates empty vector to store time stamps of stimulus presentations

for x in range(1,6):
# Set pin assignments to the factory default condition
    vibrator.writeRegister(FIO4_STATE_REGISTER, 0) # Set FIO4 low, LED on

# Deliver voltage to FIO4 to power the vibrator

    vibrator.writeRegister(FIO4_STATE_REGISTER, 1) # Set FIO4 high, LED off

    time.sleep(0.15) # wait for 0.15 seconds
    toc()
    stim_stamp.append(str(time.time() - startTime_for_tictoc))
    vibrator.writeRegister(FIO4_STATE_REGISTER, 0)  # Set FIO4 low, LED on

    time.sleep(30) # wait ten seconds

    print x

    print stim_stamp
