# Jessica's Journaling Cyberdeck

A handheld Linux journaling device built from a Raspberry Pi 4, housed in a Battleship board game case. Press your finger, start writing.

---

## Why I built this

I journal a lot but my thoughts move faster than I can handwrite. I wanted something dedicated just for journaling but not my laptop or phone with all their distractions. I just wanted a device that opens straight into a blank page when I turn it on. I also wanted it to be private so I added fingerprint authentication and full disk encryption so only I can read it.

---

## What it does

- Boots straight into a journaling environment  
- Fingerprint authentication via an R503 optical sensor before anything loads
- Full disk encryption using LUKS/AES-256 so the SD card is unreadable without my fingerprint
- Auto-creates a new journal entry named with today's date every session
- Organises entries by year and month automatically
- Shows a word count when you close the journal
- Lets you search and read past entries from within the interface

---

## How it works

### Encryption

The SD card is encrypted using LUKS (Linux Unified Key Setup) with AES-256. This means every bit on the disk is scrambled using a randomly generated master key and without that key the SD card just looks like random noise to anyone who takes it. LUKS stores the master key in encrypted form, locked by either the fingerprint or a backup passphrase. So there are two layers: your fingerprint unlocks the master key, and the master key decrypts the disk.

### Fingerprint authentication

The R503 connects to the Pi's GPIO pins via four wires. At boot, a Python script runs before the OS loads. It waits for a fingerprint, converts the scan to a mathematical template, and compares it against the stored template in the sensor's onboard memory. If it matches, it passes a keyfile to LUKS which unlocks the encrypted partition and the Pi boots normally. If it doesn't match, the disk stays locked.


### Journal software

Written in Bash. On login `.bashrc` automatically runs `journal.sh` which creates a dated entry file, shows a welcome screen, and opens it in the `micro` text editor. When you close the editor it shows your word count and updates your streak. A separate `readEntries.sh` script lets you browse and open past entries by date.

---

## How to use it

1. Power on the device
2. Press your finger to the sensor on the front
3. Wait a few seconds for the disk to unlock and the Pi to boot
4. The welcome screen appears automatically
5. Press Enter to start journaling, R to read past entries, or E to exit to terminal
6. Write. Press Ctrl+S to save, Ctrl+Q to close.
7. Your word count and streak appear when you're done

---


## Scripts

| File | What it does |
|------|-------------|
| `journal.sh` | Main launcher — welcome screen, opens today's entry, shows word count |
| `readEntries.sh` | Browse and open past journal entries by date |
| `unlock.py` | Runs at boot — reads R503 fingerprint sensor and unlocks LUKS encrypted partition |
| `boot.sh` | Goes in your .bashrc file — Copy paste the code in this file at the bottom of .bashrc file so that it runs each time you open a terminal |

---

## CAD

The enclosure is a wooden box that I made myself. The screen is mounted with screws and the bottom tray holds the keyboard, R503, Pi, and PiSugar battery.
Here's the link to OnShape:
https://cad.onshape.com/documents/9e8fc8fa49fc9f6e9f6fc67d/w/f8624b57fe9f54373a6fee66/e/190da50fa6b62c096456a805?renderMode=0&uiState=6a33074bd2cc085c33a98b5d

---

## Built with

- Raspberry Pi OS Lite (64-bit)
- LUKS / cryptsetup
- pyfingerprint Python library
- micro text editor
- Bash + Python 3
- Onshape (CAD)

## Some pictures
This is what the screen will look like on boot
<img width="739" height="543" alt="Screenshot 2026-05-06 at 12 13 03 AM" src="https://github.com/user-attachments/assets/c61de37e-581b-4599-90bc-cb297bffc23d" />

This is what the CAD looks like 
<img width="667" height="669" alt="Screenshot 2026-06-17 at 3 30 49 PM" src="https://github.com/user-attachments/assets/25d15907-078b-48e4-bb57-392ad0f30492" />


This is the wiring schematic 
<img width="721" height="437" alt="Screenshot 2026-05-25 at 5 04 48 PM" src="https://github.com/user-attachments/assets/d9158700-313e-42a6-9c68-5e11ef060c18" />


## Hack club zine flyer
<img width="322" height="528" alt="Screenshot 2026-05-10 at 7 23 31 PM" src="https://github.com/user-attachments/assets/ca2ca0ed-866d-4c7d-b0c8-e692414cdb71" />
(I'll switch the picture of the CAD with the real things once I get it built)



