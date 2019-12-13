# Pre-Pulse Inhibition Stimulators

## ppi.html

Java Script stimulator for PPI experiments.

[Direct links to a working program](http://faculty.bard.edu/~akhakhal/progs/ppi.html).

Controls:

* **Period:** how often the stimuli are delivered. In real experiments, use 30 seconds or less to avoid habituation. For troubleshooting purposes, set it to 2 seconds or so.
* **Background control:** sets the shade of screen background, which is useful if this screen is projected into the tadpole arena.
* **Running mode:** the program starts in "Silent" mode. Switch it to "Singles" for a series of single stimuli, or to "PPI protocol" to make it alternate between single and double (those with a pre-pulse) stimuli. In "PPI" mode, odd stimuli (first, third, etc.) are single, while even stimuli (second etc.) have a pre-pulse.
* **Volume:** the volume in %, from 0 (for no sound), to 100 (for loudest possible sound). For best PPI experiments, adjust this volume, to hit the 50% chance of responses to single stimuli.
* **ISI:** the Inter-Stimulus Interval, in ms, between the pre-pulse and the main pulse, for double stimuli. 100 ms works well.
* **Prepulse %:** The volume of pre-pulse stimuli, relative to the main pulse, in percent. 20% works well.
* **Show countdown:** Uncheck to hide mirrored countdown in the middle of the screen.
* **"Start anew" button** resets the cycle count, and also re-initializes the p5 sound system. Sometimes when the sound is glitchy, pressing this button may help to fix it.
* The **countdown** is shown on the screen in two different places: below the "Start Anew" button (in normal human-readable font), and in the middle of a screen (in mirrored form, to make it properly shown on the video, for projector-based setups illuminated from below). The countdowns include: the cycle number, aka the last stimulus number (0 is shown before the first stimulus); time to next stimulus in s; ISI in ms; volume in %, pre-pulse volume in %, protocol (S for "singles", D for PPI), and whether the next stimulus in the PPI protocol will be a single (D1) or a double (D2).

All Java Script scripts use the [p5 JS library](https://p5js.org/), and require p5 to be placed in a neighboring folder (in other words, library script tags at the beginning of each file are pointing at src="../p5/p5.js"). The scripts are tested with [version v0.9.0](https://github.com/processing/p5.js/releases/tag/0.9.0) (released July 01, 2019).

## ppi_chuck.ck

An alternative version of the PPI stimulator, for the [Chuck programming language](https://chuck.cs.princeton.edu/) (a strongly-timed language for sound generation). All parameters are set in the header of the script, and are self-explanatory (mirror the logic of the JS version described above).