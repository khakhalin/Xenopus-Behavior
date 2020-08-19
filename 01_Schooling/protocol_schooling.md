# Schooling in Xenopus laevis tadpoles as a way to assess neural development

Running title: Schooling in tadpoles

Virgilio Lopez III - Department of Neuroscience, Brown University, Providence RI, 02912

Arseny S. Khakhalin - Biology Program, Bard College, Annandale-on-Hudson, NY, 12504, USA. email: khakhalin@bard.edu

Carlos Aizenman  - Department of Neuroscience, Brown University, Providence RI, 02912. email: Carlos_Aizenman@brown.edu

# Abstract

Escape behaviors, orienting reflexes, and social behaviors in Xenopus laevis tadpoles have been well documented in the literature (Lee et al. 2010; Roberts et al. 2000; Simmons et al. 2004; Katz et al. 1981; Villinger and Waldman 2012). Schooling behavior experiments allow for the observation of tadpole social interactions and in the past has been used as a method to characterize behavioral deficits in models of neurodevelopmental disorders (James et al., 2015). Unlike other species of frogs, Xenopus tadpoles show polarized schooling. Not only do tadpoles aggregate, they also swim in the same direction. Quantifying both aggregation and relative swim angle can give us an important measure of social behavior and sensory integration (Wassersug et al. 1981). Past iterations of these experiments have required the continued presence of an experimenter throughout the duration of each trial and relied upon expensive software for subsequent data analysis. The instrument configuration and analysis protocol outlined here provide an automated method to assess schooling by delivering a series of timed vibratory stimuli to a group of tadpoles to induce swimming behavior, and then controlling a camera (Iturbe 2020) to document their positions via still images. Both stimulus delivery and image acquisition are automated using the Python programming language.  Analysis is done using ImageJ (Schindelin, et al. 2012) and custom Python scripts which are provided in this protocol. The specific equipment configuration, and scripts shown show here provide one solution, but other equipment and custom scripts can be substituted.

# Materials

## Reagents

* Xenopus rearing media (see Appendix 1 below for options and recipes)

## Equipment 

* **LabJack U3-HV** – an inexpensive analog-digital data acquisition device for controlling vibration delivery by a computer
* **Jintai Dental Laboratory Vibrator** – to provide vibratory stimulus
* **GoPro Hero 7** (with any flexible mount of choice)  – to acquire video and still images 
* Any **LED light tracing tablet** (eg. Picture/Perfect light pad) – to provide ilumination
* **IOT Controllable Power Relay** – for powering vibrator, activated by the LabJack DAQ
* **17 cm diameter flat bottom glass bowl** – experimental arena

## Software 

* Python 3.X: https://www.python.org/
* Jupyter: https://jupyter.org/install.html
* FIJI: https://imagej.net/Fiji/Downloads
* LabJack drivers and software: https://labjack.com/support/software/installers
* LabJack Python library:
  https://labjack.com/support/software/examples/ud/labjackpython
* Custom scripts for this project (from this repository, https://github.com/khakhalin/Xenopus-Behavior )

# Methods

## Software installation

1. Install Python 3, and Jupyter notebooks. We recommend using Anaconda distribution package, but installing Python and Jupyter separately would also work. Step-by-step instructions can be found here: https://jupyter.readthedocs.io/en/latest/install/notebook-classic.html
2. Download or clone the GitHub repository located at: https://github.com/khakhalin/Xenopus-Behavior
   For this protocol in particular, you will only need the files in the folder `01_Schooling` .
3. Follow the instructions in the [instructions.md](instructions.md) file to download and setup all necessary software and drivers to run the LabJack-U3 and GoPro. 

# Equipment setup

 (See Fig. 1A)

4. Connect one wire from the FIO4 pin on the LabJack-U3, to the positive terminal on the IOT power relay’s removable screw terminal block and one wire from the adjacent GND pin on the LabJack-U3 to the negative terminal.
5. Plug the LabJack-U3 into your computer via USB. The green light on the device should illuminate. 
6. Plug the dental vibrator into one of the “normally off” outlets on the Power Relay and ensure that the vibrator is turned on high. 
7. Connect the power relay to an outlet and switch on, a red light should appear. 
8. Open a Command prompt/Terminal window, ensure that you are in the directory with the supplied Python programs and run the following command: `$ Python u3vibrate.py` This should trigger a series of 4 vibrations, indicating that you have successfully installed the appropriate drivers to connect to the LabJack-U3. 
9. Set up the camera above the arena using a flexible mount. Once the camera has been successfully connected to the computer via WIFI, open a second Command prompt/Terminal window and run the following command: `$ Python GoProStream.py` A live feed of your GoPro camera should open. You are now ready to run your experiment.
10. Secure the illumination pad to the dental vibrator platform with doube-sided tape or Velcro to provide illumination from the bottom.
11. Add 350 mL of 10% Steinberg’s Solution to a large round dish, 17cm in diameter and place the dish on the dental vibrator, directly beneath the GoPro (Note: It is helpful to include some barriers to hold the bowl in place, should the vibrations cause it to move throughout the duration of the experiment.) Use the screen on the GoPro to adjust the placement of the vibrator and dish to ensure it is in the camera’s frame. The distance between the GoPro and the arena will vary depending on the specifics of your setup, typically it is around 50 cm above the dish. 
12. Add 15 to 20 stage 46-49 Xenopus laevis tadpoles to the dish and be sure to leave an object of known length somewhere in frame, a small ruler or some marked distance of known length.
13. Run the following command in the first Command Prompt window: `$ Python schooling_experiment.py`. The entire experiment is executed using a programmed loop. The loop consists of an image acquisition command, a 150 second wait time, a vibratory stimulus command, and another 150 second wait time. Therefore, each image and stimulus event is separated by a 300 second wait period, but the two events are offset from each other by 150 seconds. This loop is set to execute for 4000 seconds, which in the end will result in 12 acquired images for each experiment. Images acquired by the GoPro are saved as automatically named .JPG files, making the sequence clear. The timing parameters for the experiment can be easily altered by the experimenter by changing the values for the timer (line 29) and wait times (lines 46 & 50) in the script.

## Data analysis – FIJI

This section describes how to record position and orientation of tadpoles in each frame.

14. Open the first image in FIJI.
15. Use the line tool to measure the known distance included at the beginning of the experiment. 
16. Select `Analyze>Set` scale and include the measured distance in the ‘known distance’ box. Be sure to change the unit of length to the unit used for the measured distance (e.g., cm) and select the ‘global’ box to apply this scale to all subsequent images.
17. Use the multipoint tool to mark the head and gut of each individual tadpole such that each tadpole has a sequential odd number and even number marking for its head and gut, respectively. Care should be taken that the two spots create a vector that aligns with the direction the tadpole body is pointing to. 
18. Select `Analyze>Measure` and copy the results into an excel sheet. Repeat this process for every image, adding the measured data to the same excel sheet. When finished, the excel sheet will have 12 blocks of data, representing x-y coordinates for each tadpole, in all 12 images. *Note:* Alternatively, the experimenter may use the ROI Manager tool in Fiji to select the points; this will allow user to save the ROIs with the image. 
19. Save the excel sheet as a CSV file `input_control.csv`

## Data analysis – Jupyter notebook 

This section describes how to calculate and analyze inter-tadpole distances and relative angles, generating data output files.

20. Run the Jupyter notebooks environment, and navigate to your repository. Open the [schooling_analysis](schooling_analysis.ipynb) notebook. 
21. Look through the notebook (perhaps using the “Find” command), and make sure the names of all input and output CSV files are correct. By default, the notebook attempts to read files `input_control.csv` and `input_treatment.csv` from the `data` subfolder, and then saves the analysis results as `output_processed_control.csv` and `output_processed_treatment.csv` respectively, in the same subfolder.
22. Run the notebook. The program will perform a Delaunay triangulation (a standard way to identify a set of “neighboring” points for every point on a plane), find inter-tadpole distances, and angles between orientations of neighboring tadpoles (**Fig. 1B**). The results, including figures and Kolmogorov-Smirnov test p-values for distance and angle comparisons will appear under respective sections (**Fig. 1C**). In schooling tadpoles, one would observe more short distances, and fewer medium distances, compared to non-schooling (randomly distributed) tadpoles. The distribution of angles will be uniform (flat) for randomly oriented tadpoles, and declining for tadpoles that co-orient.
23. The last few sections of the code compare data from a single set of experiments (control experiments by default) to reshuffled data, as a way to estimate p-values for a null-hypothesis of “no schooling”. The data is shuffled by taking all observed tadpoles and assigning them to random frames, which preserves the spatial and angular distributions of the data, but removes any patterns, and any coordination between neighboring tadpoles.

# Figure

![](../preprint_images/schooling.png)

**Figure 1. Schematic of equipment setup and analysis. (A)** Diagram outlining experimental setup using the u3 LabJack, power relay, dental vibrator and GoPro camera. **(B)** Result of triangulation function showing tadpole positions and swimming angle. **(C)** Output of analysis function showing distribution of inter tadpole distances and angles, comparing a control and treatment group. 

## Troubleshooting

This experiment can be customized a number of ways in order to suit the needs of the experimenter. The schooling_experiment.py script is written to run on a set timer, which can be shortened or lengthened in order to yield more or fewer images for analysis. In order to do this, simply change the value given on line 29 of the code, which is currently set to 4000 seconds by default. Additionally, we have found that tadpole activity decreases as the day goes on, with the highest amount of swimming activity occurring within 1-3 hours into the start of their diurnal cycle (tadpoles are housed in a 12:12 light/dark cycle). As such, care should be taken with regards to when schooling experiments are conducted. Ideally, experiments should be run around the same point of their L/D cycle. Specific criteria should be carefully set up for inclusion of control and experimental groups in the analysis. These criteria could involve a baseline swimming threshold, or accurate schooling in control group. These criteria may vary by age or nature of the experiment, but experimenters should take care to set these a priori criteria for inclusion into their experimental groups. 

# Discussion

In our experimental setup, tadpoles organize themselves into small groups within a dish swimming together in one direction. Formation of these schools takes about 30-60 seconds after a vibration stimulus is provided to induce swimming behavior. Thus, we deliver this stimulus with a given time interval so we can sample several schooling configurations from a single group of tadpoles. The included analysis script provides an output file that contains the result of a triangulation used to calculate distances between neighboring tadpoles in each image. It also calculates the relative angles between the orientations of neighboring tadpoles. For normal schooling, the distribution of inter-tadpole distances will be non-random, with more values at shorter distances and longer distances, and fewer “intermediate distances”, representing the tadpole-tadpole distances within a school, and between schools.

Our general approach to experiment design is to have a treatment group and a control group of 20 tadpoles each from the same clutch to account for variations within clutches. Typically, each experiment is run with at least 5 control groups and 5 treatment groups, generally more. Distributions of controls and treatment groups can be compared directly using non-parametric statistics (eg. Kolmogorov-Smirnov test), or each group can be compared to a random distribution to test for presence or absence of schooling (see a simulation notebook on GitHub for more details, and power analysis for these tests). It is important to consider that treatments that result in hyper or hypo activity will almost always show up as differences in schooling behavior. Therefore, it is helpful to assess general swimming activity separately by using video tracking to compare baseline swimming speed between groups.

# References

Iturbe, K. 2020. Unofficial GoPro API Library for Python – connect to GoPro via WiFi, GitHub Repository, https://github.com/KonradIT/gopro-py-api

James E J, Gu J, Ramirez-Vizcarrondo CM, Hasan M, Truszkowski TL, Tan Y, . . . Aizenman, CD. 2015. Valproate-induced neurodevelopmental deficits in Xenopus laevis tadpoles. *J Neurosci, 35*(7), 3218-3229. doi:10.1523/jneurosci.4050-14.2015

Katz LC, Potel MJ, Wassersug RJ. 1981. Structure and mechanisms of schooling intadpoles of the clawed frog, *Xenopus laevis. Animal behaviour, 29(1),* 20-33. 

Lee RH, Mills EA, Schwartz N, Bell MR, Deeg KE, Ruthazer ES, . . . Aizenman CD. 2010. Neurodevelopmental effects of chronic exposure to elevated levels of pro-inflammatory cytokines in a developing visual system. *Neural development, 5(2)*

Roberts A, Hill NA, Hicks R. 2000. Simple mechanisms organise orientation of escape swimming in embryos and hatchling tadpoles of Xenopus laevis. *J Exp Biol, 203*(Pt 12), 1869-1885. 

Schindelin, J.; Arganda-Carreras, I. & Frise, E. et al. (2012), "Fiji: an open-source platform for biological-image analysis", *Nature methods* 9(7): 676-682, PMID 22743772,doi:10.1038/nmeth.2019

Simmons AM, Costa LM, Gerstein HB. 2004. Lateral line-mediated rheotactic                  behavior in tadpoles of the African clawed frog (*Xenopus laevis*). *J Comp Physiol A,* 190,             747-758. doi: 0.1007/s00359-004-0534-3

Villinger J, Waldman B. 2012. Social discrimination by quantitative assessment of immunogenetic similarity. *Proc Biol Sci, 279*(1746), 4368-4374. doi:10.1098/rspb.2012.1279

Wassersug RJ, Andrew ML, Michael JP. 1981. An Analysis of School Structure for Tadpoles (Anura: Amphibia). 

# Appendix 1

## 10% Steinberg’s Rearing Solution

The recipe below describes how to prepare **10X Stock** Steinberg's solution. In practice, tadpoles are reared in 10% Steinberg's solution. It means that the recipe below gives you a fluid that needs to be diluted 100 times to produce appropriate Xenopus rearing media. The reasons for this confusing naming situation are purely historical.

| **Reagent**     | **Amount** |
| --------------- | ---------- |
| NaCl            | 34.0 g     |
| HEPEs           | 119.0 g    |
| Ca(NO3)2 · 4H2O | 0.8 g      |
| MgSO4 · 7H2O    | 2.06 g     |
| KCl             | 0.5 g      |
| dH2O            | 1 L        |

 Preparation protocol:

1. Completely dissolve all reagents in 850 mL of dH2O.
2. Adjust pH to 7.5 with 10N NaOH. To prepare 10N NaOH, slowly dissolve 40g NaOH in 100 ml dH20. Store at room temperature.
3. Add dH2O to reach final volume of 1 L and store at 4°C. 
4. Dilute 1:100 to create 10% Stenberg’s, to use as rearing solution for tadpoles.  