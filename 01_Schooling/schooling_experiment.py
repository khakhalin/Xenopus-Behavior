# GoPro should be connected via wifi
# make sure the 2.4ghz connection is selected and connect via the computer's wifi
# need to cite this github repo https://github.com/KonradIT/gopro-py-api

from goprocam import GoProCamera, constants # imports GoPro capabilities
gpCam = GoProCamera.GoPro() # defines gpCam as variable

import time

def snapshot():
    gpCam.take_photo() # initializes GoPro photo acquisition
    p = time_stamp() # creates variable to add to the list of photo time stamps
    photo_stamp.append(p) # adds the time stamp variable from line above to the list
    print (photo_stamp) # prints the list

def stimulate():
    import u3 # Open the first found LabJack U3
    vibrator = u3.U3() # defines vibrator variable as u3 labjack
    FIO4_STATE_REGISTER = 6004 # defines which connection will be used to deliver power to vibrator
    vibrator.writeRegister(FIO4_STATE_REGISTER, 1) # Deliver voltage to FIO4 to power the vibrator
    time.sleep(0.15) # wait for 0.15 seconds, the length of the stimulus vibration
    t = time_stamp() # creates variable to add to the list of stimulus time stamps
    stim_stamp.append(t) # adds the time stamp variable from the line above to the list
    print (stim_stamp) # prints the list
    vibrator.writeRegister(FIO4_STATE_REGISTER, 0) # Deliver voltage to FIO4 to power the vibrator

global start_timer # makes this a global variable
start_timer = time.time() # creates variable for experiment start time
end_timer = start_timer + 4200 # this is when the experiment should stop running, should be enough time to acquire 12 images
print (start_timer)


def time_stamp(): # this function is used to get time stamps for stimuli presentations & photos
    elapsed_time = time.time() - start_timer # defines a variable to give time elapsed since start of experiment
    return elapsed_time


stim_stamp = [] # creates an empty list vector to store time stamps of stimulus presentations
photo_stamp = [] # creates an empty list vector to store time stamps of photos


def start(): # this function runs the actual experiment
    while round(end_timer - time.time()) > 0: # creates a timer using a while loop
        snapshot() # calls on the GoPro to take a photo

        time.sleep(150) # 2.5 minute wait before stimulus

        stimulate() # u3 labjack delivers power to vibrator to reset schooling pattern

        time.sleep(150) # 2.5 minute wait before repeating the loop

start() # calls start() function to run experiment

print ('Here are the time stamps for photo acquisitions: ', photo_stamp) # prints vector with photo time stamps

print ('Here are the time stamps for stimulus presentations: ', stim_stamp) # prints vector with stimuli presentation time stamps

gpCam.downloadAll() # downloads all media from GoPro to current working directory
