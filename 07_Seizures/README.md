# Xenopus Behavior / Seizures

A protocol for seizures detection was described in:

* James, Eric J., Jenny Gu, Carolina M. Ramirez-Vizcarrondo, Mashfiq Hasan, Torrey LS Truszkowski, Yuqi Tan, Phouangmaly M. Oupravanh, Arseny S. Khakhalin, and Carlos D. Aizenman. "Valproate-induced neurodevelopmental deficits in Xenopus laevis tadpoles." Journal of Neuroscience 35, no. 7 (2015): 3218-3229.

This folder contains a Matlab script that can process tracks exported from Noldus EthoVision (or any other similar tracking system), automatically detect seizures, quantify them, and output some simple statistics.

## 2013 protocol, by Jenny Gu

(Slightly abbreviated by Arseny Khakhalin in 2021)

1. Get s47 control and treatment tadpoles from the incubator. Place both groups of tadpoles in (separate) fresh containers of     Steinberg’s. Leave for one hour on the bench, in order to wash out the effects of a drug (in which they are raised).
2. Set up the Styrofoam box underneath the camera. Set up the six-well plate, with 10 mL of PTZ solution in each well (a concentration of 5, 7.5, or 10 mM. 5 and 7.5 mM concentrations typically result in clearer difference between treatment and control, compared to 10 mM).
3. After one hour, start recording the (empty)  six-well plate using EthoVision (“Acquisition 2012 VPA seizures”). We want to see the entirety of the tadpoles’ behaviour, so we want to record their entry into the wells too. 
4. Place three control tadpoles and three treatment tadpoles into the well, while recording is on. Record for 20 min. 
5. Analysis: Export raw data as an Excel spreadsheet. Use the MATLAB file “**seizures.m**”. This program returns frequency of seizures, time until first seizure, and average seizure length. It reads the entire 20-mintrial for a six-well plate.