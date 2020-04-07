import time

import u3 # Open the first found LabJack U3

vibrator = u3.U3() # defines vibrator variable as u3 labjack

def stimulate():
    FIO4_STATE_REGISTER = 6004 # defines which connection will be used to deliver power to vibrator
    vibrator.writeRegister(FIO4_STATE_REGISTER, 1) # Delivers power to FIO4 to power the vibrator
    time.sleep(0.15) # wait for 0.15 seconds, the length of the stimulus vibration
    vibrator.writeRegister(FIO4_STATE_REGISTER, 0) # Delivers power to FIO4 to power the vibrator
    
def start(): # defines a function to test labjack-power_relay-computer connection
    for x in range(4): # will activate the setup to trigger a series of 4 vibrations that are each two seconds apart 
        stimulate()

        time.sleep(2)

start()

vibrator.close()
