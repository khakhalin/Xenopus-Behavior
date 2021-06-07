# Xenopus Behavior / Habituation

A protocol for habituation quantification was described in:

* James, Eric J., Jenny Gu, Carolina M. Ramirez-Vizcarrondo, Mashfiq Hasan, Torrey LS Truszkowski, Yuqi Tan, Phouangmaly M. Oupravanh, Arseny S. Khakhalin, and Carlos D. Aizenman. "Valproate-induced neurodevelopmental deficits in Xenopus laevis tadpoles." Journal of Neuroscience 35, no. 7 (2015): 3218-3229.

For stimulation, you can use the "clicker" JavaScript program, given in the [../04_PPI] folder. (You just need to turn off the PPI protocol, making the program deliver only single clicks, with a period of 5-10 seconds).

This folder contains a Matlab script that can process tracks exported from Noldus EthoVision (or any other similar tracking system), automatically detect seizures, quantify them, and output some simple statistics.

## Original protocol description by Jenny Gu (2013)

(Slightly abbreviated by Arseny Khakhalin in 2021)

1. Get s49 control and VPA tadpoles from the incubator. Place both groups of tadpoles in (separate) fresh containers of     Steinberg’s. Leave for one hour on the bench, in order to wash out the effects of VPA.
2. Set up the apparatus. Position the Styrofoam box (used for illumination) and the “mechanical arm”.
3. Verify that Master-8 is delivering the correct protocol to the apparatus. The interval should be set at 5 and the duration reading is 4-3 (presumably, ms?). 

1. Position a six-well plate at the upper right corner of the Styrofoam box. Fill each well with 6.5 mL of Steinberg’s.
2. After one hour, place tadpoles into the wells. Start recording from EthoVision (“Acquisition 2012 startles 6well” file); then     start the stimulus protocol on Master-8. Run the protocol for 2 min. Then, stop the stimulation, and the EthoVision trial.
3. Remove six-well plate from the apparatus and give tadpoles 5 min of rest before the next round of stimulation.
4. Repeat protocol of "2 min stimulation, followed by a 5 min of rest" until the tadpoles have had 5 rounds of stimulation. After the 5th round, give the tadpoles 15 min of rest. For each 2-min round of stimulation, start a new EthoVision trial.
5. After 15 min of rest, give the tadpoles one final round of stimulation (2 min).
6. Analysis: Export raw data as an Excel spreadsheet. Use MATLAB file “**habituation_6well_a.m**” and input correct Trial Numbers. The program returns the average speed of responses. It reads a 2-min trial with events every 5 seconds (24 data points). 
7. Take the output from this program and put it into the Excel document “habituationformatlab.xlsx”.
8. Finally, use MATLAB file “**habituation_6well_part2.m**”. This program reads the habituationformatlab.xlsx document (make sure that you type in the relevant sheet number for the trial you want to analyze, together with codes 0 and 1 for control and treatment trials, respectively). This program returns rapid habituation, short habituation, long habituation, short recovery, and long recovery.

