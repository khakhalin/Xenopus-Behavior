# Behavioral assays to assess neural development in Xenopus laevis tadpoles

This repository contains a collection of protocols and software tools for behavioral studies in Xenopus tadpoles.

See our preprint for detailed instructions, comments, and advice on protocol implementation: https://www.biorxiv.org/content/10.1101/2020.08.21.261669v1

## Separate Protocols

1. [Schooling](01_Schooling/protocol_schooling.md)
2. [Collision Avoidance](/02_Collision_Avoidance/protocol_collision_avoidance.md)
3. Optomotor Response (OMR)
4. Pre-Pulse Inhibition (PPI)
5. [Acoustic Habituation](05_Habituation/readme.m)
6. Multisensory protocols
7. [Seizures](07_Seizures/readme.m)

## Java Script stimulation programs

**All Java Script scripts use [p5 JS library](https://p5js.org/), and require p5 to be placed in a neighboring folder.** In other words, script tags at the beginning of each html file are pointing at src="../p5/p5.js", as well as "../p5/addons/p5.dom.js" and "../p5/addons/p5.sound.js", which is the way these files are organized in the p5.zip distribution that can be downloaded at [p5js.org](http://p5js.org). The scripts are tested with [version v0.9.0](https://github.com/processing/p5.js/releases/tag/0.9.0) (released July 01, 2019).

Direct links to working versions of Java Script stimulation programs:

**List of programs:**

* Collision avoidance:
  * [Stimulation program, Basic version](http://faculty.bard.edu/~akhakhal/progs/collision.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/collision.html)) - Key bindings: LEFT / RIGHT to target; UP to send the circle towards the animal; DOWN to reset the circle to the center.
  * [Multisensory with cycling of sequences](http://faculty.bard.edu/~akhakhal/progs/collision_multisens.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/collision_multisens.html)) - alternates between visual only stimulus (collision), acoustic only, and a combo of both.
  * [Multisensory with cycling of ISIs](http://faculty.bard.edu/~akhakhal/progs/collision_cycle_isi.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/collision_cycle_isi.html)) - same as above, but you can cycle through severeal ISIs (inter-stimulus intervals)
* Pre-Pulse Inhibition (PPI) and habituation
  * [Stimulation program](http://faculty.bard.edu/~akhakhal/progs/ppi.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/ppi.html))
* Opto-Motor Response (OMR)
  * [Basic version](http://faculty.bard.edu/~akhakhal/progs/omr_noise.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/omr_noise.html)) - with a field of noise, moving. Key bindings: DOWN to stop a stimulus, UP to start a stimulus, LEFT and RIGHT to pick the direction in which the stimulus is scrolled.
  * [Same but with solid bars](http://faculty.bard.edu/~akhakhal/progs/omr_bars.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/omr_bars.html)) - much older version, with no keyboard controls
  * [Same with bars of noise](http://faculty.bard.edu/~akhakhal/progs/omr_noisebars.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/omr_noisebars.html))
  * [OMR habituation](http://faculty.bard.edu/~akhakhal/progs/omr_habituator.html) ([code](https://github.com/khakhalin/js-experiments/blob/master/omr_habituator.html)) - A constantly moving (and slowly changing) stimulus that may be used to habituate OMR
* Full-field multisensory stimulation
  * [Main version](http://faculty.bard.edu/~akhakhal/progs/multisensory_corner_cycle_isi.html) (see [this folder](06_Multisensory/stimulation/) for code)
  * There are quite a few other versions here, with various experimental functionalities (all scripts that start with "multisensory_". Working links to these can be found [here](https://sites.google.com/view/khakhalin/research/programs))
  * [Multisensory conditioning protocol](http://faculty.bard.edu/~akhakhal/progs/multisensory_conditioning.html) (see [this folder](06_Multisensory/conditioning/) for code)

