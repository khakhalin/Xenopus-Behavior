# Analysis of Visual Collision Avoidance in Xenopus Tadpoles

Running title: Visual Collision Avoidance in Xenopus Tadpoles

Arseny S. Khakhalin - Biology Program, Bard College, Annandale-on-Hudson, NY, 12504, USA. email: khakhalin@bard.edu

# Abstract

In teaching, the best exam questions are those that seem simple at first, but can lead to deep and nuanced conversations. Similarly, to probe brain development, we should look for behaviors that are easy to evoke and quantify, but that are demanding, malleable, and inherently variable. Visual collision avoidance in Xenopus tadpoles is an example of such a behavior: it is ecologically relevant, robust, and easy to record, but also nuanced, and shaped by the sensory history of the animal (Khakhalin 2014; James 2015; Khakhalin 2019). Here we describe how to set up a visual avoidance assay, and how to use it to test sensory processing and sensorimotor transformation in the vertebrate brain.

# Materials

## Reagents

Tadpole rearing media: a solution of 15 mM NaCl, 0.5 mM KCl, 1.0 mM MgSO4, 150 μM KH2PO4, 50 μM NaHPO4, 1.0 mM CaCl2, 0.7 mM NaHCO3, 0.5 mg/L methylene blue in DI H2O; pH 7.2-7.6. Other rearing media, such as the popular "0.1X Steinberg" solution, are also acceptable.

## Equipment

* Projection table

> To build a projection table, use 1100 cm (36 feet) of 20×40 mm (1''×2'') pine beam; 32 wood screws; 4 furniture felt pads; 2 pieces of clean acrylic 31×31 cm (1'×1'), and a white disposable plastic apron (Fig 1A).

* Short throw projector (e.g. AAXA P300)

> As an alternative, use an old CRT monitor, or an iPad-like tablet.

* Computer with Internet access
* Plastic Petri dish (8.5 cm in diameter)
* Web-camera for video recording

**Optional:**

* Cardboard box to cover the top of the projection device
* IR light source (e.g. Univivi U48R LED wide angle source for CCTV security systems)
* Acrylic light filters
* Some open-source tracking solutions:
  http://ctrax.sourceforge.net
  http://sourceforge.net/projects/buridan/

# Methods

## Projecting device

As the visual stimulus is projected on the floor of the chamber, the tadpole should be able to see the image even at sharp angles. We therefore cannot use a standard LCD monitor for visual stimulation, but have to use either a projector, an old CRT monitor placed horizontally, or a tablet. As a test, if you cannot see the image on the screen when looking along the surface, the tadpole won't be able to see it as well.

We recommend to use a short-throw USB pico-projector, and a screen made of a piece of white disposable polyethilene apron, fixed between two pieces of clean acrylic (Fig 1A). The downsides of CRT monitors is that the surface is never quite flat; they heat the water, and the recording is compromised by a refresh beam artifact. The protocol seems to also work with high-end tablets, but we have not explored this approach systematically.

## Recording

1. In a browser, open the repository of Xenopus behavioral protocols: https://github.com/khakhalin/Xenopus-Behavior . Navigate to the current version of the Collision Avoidance Stimulator (Fig 1B). Project the image.
2. Adjust the background lightness to medium levels, to maximize the contrast without blinding the tadpole.
3. Place a Petri dish on top of the screen, and fill it with tadpole water, 1-1.5 cm deep. Make the arena of the program match the position and size of the Petri dish; adjust the radius if needed.
4. Set the stimulation parameters. Wait for at least 20, better 30 s between the stimuli, to prevent habituation. Make the black dot ~5 mm in diameter (comparable to the size of a tadpole), traveling at a speed of 2-5 cm/s (comparable to the speed of a tadpole). Note that making the circle faster and smaller would increase the chances of triggering a "fast" poorly coordinated escape response, while keeping the circle slower and larger allows tadpoles to implement slower, more spatially informed course corrections (Khakhalin 2014; Khakhalin 2019).
5. Target the circle using LEFT / RIGHT keys, and send it towards the tadpole by pressing the UP key. You can always return it to the center by hitting the DOWN key. Sending the circle towards the tadpole set the timer in the left bottom corner of the screen. The timer controls the color of the stimulus circle, making it pale during the inter-stimulus interval, to prevent habituation.
6. Before running actual experiments, practice your targeting. As healthy tadpoles tend to travel around the edges of the arena, it is usually enough to keep the target fixed, and time your sending the circle on the collision trajectory. Do not press the LEFT / RIGHT keys when the circle is in motion, as lateral motion increases the speed of the circle.
7. During actual experiments, place all control tadpoles in one bowl, and all treatment tadpoles in another one. Keep the experimenter blinded to the identity of tadpoles in each bowl, and let them alternate between bowls.
8. Quantify each trial as you go, as either a "success "(if the avoidance response was triggered; Fig 1C, D) or a "failure", while also recording a video for further processing.

## Analysis

The simplest experimental design for collision avoidance involves comparing rates of avoidance responses across different treatment groups (Fig 1E). This analysis requires minimal equipment, can be done by eye during the experiment, and verified from the video (scored by another person, with matching scores included in the final analysis). This design is also appropriate for teaching labs. To further probe brain development, one can sweep across a range of values for circle speeds, sizes, or contrasts, and compare the data between groups (Henriet 2017). 

A more sophisticated analysis involves tracking the tadpole position at every frame, which can be done manualy (ImageJ), or automatically, using commercial (Noldus EthoVision; CleverSys AquaScan) or open source software (CeTrAn, C-trax, and other solutions; Colomb 2012; Chao 2015). A perfect tracking of both the stimulus and the tadpole gives access to several more variables, including the peak swimming speed, the angle at which the tadpole turns during the maneuver (Fig 1F), and the distance to the circle when the response is triggered (Khakhalin 2014). It also allows automated classification of responses into "successes" and "failures".

As not all software solutions can track both the circle and the tadpole, another option is to add a near-IR light source below the projection screen, and turn the camera to IR-only, by replacing a glass IR filter inside it with a stack of of thee colored (red, green, and blue) acrylic filters (Truszkowski 2017). In this configuration, the camera would only record the tadpole, but not the stimulus, which would still allow some types of analysis.

The stimulation program presented here can also be used for multisensory experiments (Truszkowski 2017), as it can deliver a sound either when the circle hits the wall, or immediately before that, or immediately after. The description of this protocol however falls out of scope of this paper.

## Troubleshooting

**Problem:** Tadpoles are sluggish and don't swim, staying in one place; yet the moment they are returned to the tank, they start swimming again.

**Solutions:**

* Give the tadpole a minute to acclimate, then startle it with a gentle tap on the projection device. Ideally, a tadpole should always be swimming, with a speed of 1-3 cm/s.
* Check the water temperature. *X. laevis* tadpoles prefer the water to be slightly colder them at room temperature (18° to 21°C). If the projector heats the dish, replace the water regularly.
* Add ambient light to the chamber: e.g. make the screen around it white. Tadpoles stop swimming if the environment is too dark.
* Run the experiments earlier in the morning: if kept on a 12/12 light cycle with "dawn" at 7 am, tadpoles seem most active between 9 am and 12 pm, and often stop responding in the afternoon.
* Try not feeding tadpoles before the experiment.

**Problem:** Tadpoles swim, but do not avoid circles.

**Solutions:**

* Adjust the brightness down (to reduce retinal bleaching), or increase the contrast.
* Improve the screen around the chamber, or reduce movement, to avoid visual habituation.

# Discussion

A typical responsiveness for this protocol is 80% for healthy naive stage 49 tadpoles (Khakhalin 2014), but it goes down to 70% in dark-reared tadpoles (Ramirez-Vizcarrondo 2015), 50% for tadpoles adjusted to strong visual stimulation (Jang 2016); 40% for tadpoles with mild neurodevelopmental abnormalities (James 2015), and 20% in nutritionally restricted tadpoles (Khakhalin, unpublished). A power analysis shows that with 20 stimuli per tadpole (10 minutes of recording), base response probability of 70%, 20 animals in each group, and α = 0.05, one can detect a drop of responsiveness to 60% with power of β = 80%.

A typical fast avoidance maneuver involves a sharp turn at ~90±40° performed at a distance of ~1 cm from the circle, followed by a brief acceleration to 12±4 cm/s. A slow "course correction" is produced in response to larger, slower circles, and involves a shallower turn by ~70±50° and to acceleration to ~7±4 cm/s (Khakhalin 2014). Together, this makes visual collision avoidance a powerful tool to detect and dissect abnormalities in the sensorimotor system of Xenopus tadpoles.

# Figure 1

**A.** Projection table, with dimensions. **B.** Schematics of one collision. **C.** Representative avoidance trajectories (Khakhalin 2014). **D.** Average (solid) and standard deviation (dashed) of swimming speeds for 500 fast avoidance responses (ibid.). **E.** Response probabilities for normal and dark-reared tadpoles (Ramirez-Vizcarrondo 2015). **F.** Angles of the original sharp turn for normal and dark-reared tadpoles (ibid.).

# References

Chao, R., Macía-Vázquez, G., Zalama, E., Gómez-García-Bermejo, J., & Perán, J. R. (2015). Automated tracking of drosophila specimens. Sensors, 15(8), 19369-19392.

Colomb, J., Reiter, L., Blaszkiewicz, J., Wessnitzer, J., & Brembs, B. (2012). Open source tracking and analysis of adult Drosophila locomotion in Buridan's paradigm with and without visual targets. PloS one, 7(8).

Henriet, E., Mannioui, A., Khakhalin, A., & Zalc, B. (2017). A behavioral test to evaluate the functional consequences in a Xenopus laevis model of inducible-demyelination and myelin repair. In Multiple Sclerosis Journal (Vol. 23, pp. 996-996).

James, E. J., Gu, J., Ramirez-Vizcarrondo, C. M., Hasan, M., Truszkowski, T. L., Tan, Y., ... & Aizenman, C. D. (2015). Valproate-induced neurodevelopmental deficits in Xenopus laevis tadpoles. Journal of Neuroscience, 35(7), 3218-3229.

Jang, E. V., Ramirez-Vizcarrondo, C., Aizenman, C. D., & Khakhalin, A. S. (2016). Emergence of selectivity to looming stimuli in a spiking network model of the optic tectum. Frontiers in neural circuits, 10, 95.

Khakhalin, A. (2019). Graph analysis of looming-selective networks in the tectum, and its replication in a simple computational model. BioRxiv, 589887.

Khakhalin, A. S., Koren, D., Gu, J., Xu, H., & Aizenman, C. D. (2014). Excitation and inhibition in recurrent networks mediate collision avoidance in X enopus tadpoles. European Journal of Neuroscience, 40(6), 2948-2962.

Ramirez-Vizcarrondo, C., Hasan, M., Gu, J., Khakhalin, A., & Aizenman, C. (2015). Novel Behavioral Assays to Model Neurodevelopmental Disorders in the Xenopus laevis Tadpole. The FASEB Journal, 29(1_supplement), 657-1.

Truszkowski, T. L., Carrillo, O. A., Bleier, J., Ramirez-Vizcarrondo, C. M., Felch, D. L., McQuillan, M., ... & Aizenman, C. D. (2017). A cellular mechanism for inverse effectiveness in multisensory integration. Elife, 6, e25392.