
import pyfingerprint.pyfinerprint import Pyfingerprint
import subprocess
import sys


try: 
    #creates a connection to sensor. 
    # Arguments are serial port, communication speed, sensor device address and sensor password respectively
    f = PyFingerprint('/dev/ttyS0', 57600, 0xFFFFFFFF, 0x00000000)

    #make sure that the connection is working 
    if not f.verifyPassword():
        raise ValueError("sensor password is wrong")
    
except Exception as e:
    print("Sensor error: " + str(e))
    sys.exit(1)

print("place your finger on the sensor")

while not f.readImage(): #loop that runs until finger is present
    pass 


f.convertImage(0x01) #convert raw fingerprint image to mathematical template
result = f.searchTemplate() #compare the template against stored templates 
positionNumber = result[0] #extracts position number
#-1 = no match, 0 or higher = match was found

if positionNumber > 0:
    #runs a terminal command from inside python
    #unlocks the encrypted partition
    subprocess.run([
        'cryptsetup', 'luksOpen', 
        '/dev/mmcblk0p2', 'myjournal',
        '--key-file', '/boot/keyfile'
    ])
    #/boot/keyfile is random encryption key to unlock disk
    print("unlocked. Welcome")
else:
    print("foriegn fingerprint")
    sys.exit(1)