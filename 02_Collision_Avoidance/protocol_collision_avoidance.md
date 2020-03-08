# Analysis of Visual Collision Avoidance in Xenopus Tadpoles

Running title: Visual Collision Avoidance in Xenopus Tadpoles

Arseny S. Khakhalin - Biology Program, Bard College, Annandale-on-Hudson, NY, 12504, USA. email: khakhalin@bard.edu

## Abstract

A good exam question is one that is easy to ask, but that can easily lead to deep and nuanced conversations. Similarly, to probe brain development, we should look for behaviors that are easy to evoke and quantify, but that are demanding, and inherently varying to serve as a good test for brain function. Visual collision detection and avoidance in Xenopus tadpoles is an example of such a behavior: it is ecologically relevant, robust, and easy to record, but also nuanced, and sensitive to both the development, and their recent sensory history of the animal (Khakhalin 2014; James 2015; Khakhalin 2019). We describe how to set up a visual avoidance assay, and how to use it as a test of sensory processing and sensorimotor transformations in the vertebrate brain.

# Materials

## Reagents

Tadpole rearing media: a solution of 15 mM NaCl, 0.5 mM KCl, 1.0 mM MgSO4, 150 μM KH2PO4, 50 μM NaHPO4, 1.0 mM CaCl2, 0.7 mM NaHCO3, 0.5 mg/L methylene blue in DI H2O; pH 7.2-7.6. Other rearing media, such as the popular "0.1X Steinberg" solution, are of course also acceptable.

## Equipment

* Projection table

> To build a projection table you will need about 1100 cm (36 feet) of 20×40 mm (1'' × 2'') pine beam; 32 wood screws; 4 furniture felt pads; 2 pieces of clean acrylic 31×31 cm (1' × 1'); and a white disposable plastic apron. See Fig 1A for a blueprint.

* Short throw projector, such as AAXA P300 pico projector

> As an alternative projecting device, one can use an old CRT monitor, or an iPad-like tablet; see below.

* Computer with USB connection and Internet access
* Plastic Petri dish
* Web-camera for video recording

**Optional:**

* Cardboard box to cover the top of the projection device

# Method

## Projecting device

As the visual stimulus is projected on the floor of the tadpole chamber, the tadpole should be able to see this image at a sharp angle. Because of that, one cannot use a standard LCD monitor for visual stimulation, but has to either use a projector, an old CRT monitor placed horizontally, or a good IPad-like tablet. As a simple test, if you cannot see the image on the screen when you bring your eye to it and look along the surface (at a sharp angle), the tadpole won't be able to see the image as well.

We had most success with a short-throw USB pico-projector, and a screen made of a piece of white disposable polyethilene apron, fixed between two pieces of clean acrylic (Fig 1A). However, previous versions of our setup used an old CRT monitor placed with a screen up. The downsides of using a CRT is that the surface is never quite flat; they heat the water in the chamber; and recording video becomes problematic because of a refresh beam artifact. We are also aware of at least one successful use or our protocol with an iPad (unpublished).

## Recording

1. In a browser, open the depository of Xenopus behavioral protocols: https://github.com/khakhalin/Xenopus-Behavior . Navigate to the current working version of the Collision Avoidance Stimulator (Fig 1B). Project the image on your projection device.
2. Adjust the background lightness to medium levels. If the background is too dark, the contrast will be too low, and the tadpole won't avoid the circle. If the background is too bright however, the tadpole may be temporarily blinded, and
3. Place a Petri dish on top of the projection screen. Make the circle of the program match the Petri dish; adjust the radius in the program if needed.
4. Adjust stimulus parameters if needed. We recommend to wait for 30 s between stimuli, to prevent habituation (20 s may also be possible, but more frequent stimuli would habituate the tadpole). Make the black circle have about 5 mm in diameter (comparable to the size of a tadpole), and travel at speed of 2-5 cm/s (comparable to the speed of the tadpole). 
5. Note that making the circle faster and smaller would increase the chances of triggering a "fast", poorly coordinated escape response, while keeping it slower and larger would allow tadpoles to implement slower, spatially adjusted course corrections (Khakhalin 2014; Khakhalin 2019).
6. Target the circle with LEFT / RIGHT keys, and send it towards the tadpole by pressing the UP key. You can also return it to the center by hitting the DOWN key. Sending the circle towards the tadpole resets the timer in the left bottom corner of the screen, and also controls the color of the circle that gets pale during the inter-stimulus interval, to prevent habituation.
7. Before running actual experiments, use a dozen of animals to practice targeting the tadpole. As healthy tadpoles tend to travel around the edges of the arena, it is usually enough to keep the target fixed, and just time the command that sends the circle on the collision track. Make sure not to use the LEFT / RIGHT keys while the circle is in motion, as it would change the speed of the circle. 
8. During actual experiments, place all control tadpoles in one bowl, and all treatment tadpoles in another one. Keep the experimental blinded to the identity of tadpoles in each bowl, and let them test both groups in turn (odd experiments with one bowl; even experiments with the other). Quantify each stimulus as you go, as either a success (the response was triggered) or failure, but also record all trials with a camera.

## Analysis

The simplest experimental design with this behavior involves comparing the rates at which escape responses were triggered. This analysis requires minimal equipment, as it can be done by eye during the experiment, and verified with the video (potentially, the video can be scored by another person, with only matching scores included in the final analysis). This approach is also appropriate for teaching labs.

A slightly more sophisticated analysis may include classifying all responses into fast "escapes", and slow "course corrections" (Khakhalin 2014). While this could still be done by eye, it is much easier to do with tracking.

* Simplest: probability only. Try diff speeds, sizes, contrast
* Next step: a proportion of fast and slow responses
* Tracking: manual, cheap, expensive
* Analyze escape speed (2 types of escapes), turning angle

The Java Script program we present here can also be used for multisensory stimulation, as it can deliver a sound stimulus either at the moment when the black circle hits the arena wall, or immediately before, or immediately after that. The description of this protocol however is out of scope of this piece.

# Troubleshooting

**Problem:** tadpoles are sluggish and don't swim in the Petri dish, but stay in place, or even turn belly up; yet the moment they are returned to the tank, they start swimming again.

**Possible solutions:**

* Give the tadpole a few seconds to acclimate, then startle it with a gentle tap on the projection device. A healthy happy tadpole should always be swimming around the wall of the Petri dish, with a speed of about 2-5 cm/s.
* Check the water temperature. *X. laevis* tadpoles prefer cooler temperatures of 18° to 21°C, and behave best if the water in the chamber is the same or slightly colder than the one they were raised at.
* Add some ambient light in the chamber; e.g. make the cardboard box that screens the Petri Dish white rather than black inside. Tadpoles stop swimming if the surrounding is too dark.
* Run the experiments earlier in the morning: if kept on a 12/12 light cycle with "dawn" at 7 am, tadpoles seem most active between 9 am and 12 pm. They often stop responding to stimuli in the afternoon.

**Problem:** tadpoles swim in the Petri dish, but do not avoid circles.

**Possible solutions:**

* Adjust the brightness up (to make the tadpole more active, and increase the contrast), or down (to reduce retinal bleaching).
* Without a cardboard screen around the Petri dish, the tadpole may be habituated by too moving visual stimuli. While it is possible to work without a screen in a isolated room, or in a teaching setting, screening the arena tends to give better results.

# Discussion

...

Collision avoidance in Xenopus tadpoles was reported to change across developmental stages (Dong 2009), in response 

A typical responsiveness for this protocol is about 80% for healthy naive stage 49 tadpoles (Khakhalin 2014), down to about 50% in tadpoles adjusted to strong sensory stimulation (Jang 2016); 40% in tadpoles raised in valproic acid (a teratogenic psychopharmacological agent; James 2015), and down to 20% in severely nutritionally restricted tadpoles (unpublished data). A simple power analysis shows that with 20 stimuli per tadpole (10 minutes of recording), base response probability of 70%, 20 animals in each group, and $\alpha=0.05$, one can detect a drop of responsiveness to 60% with 80% probability (power $\beta=$ 0.8).

A typical response (describe)

# References

Dong, W., Lee, R. H., Xu, H., Yang, S., Pratt, K. G., Cao, V., ... & Aizenman, C. D. (2009). Visual avoidance in Xenopus tadpoles is correlated with the maturation of visual responses in the optic tectum. Journal of neurophysiology, 101(2), 803-815.

Henriet, E., Mannioui, A., Khakhalin, A., & Zalc, B. (2017, October). A behavioral test to evaluate the functional consequences in a Xenopus laevis model of inducible-demyelination and myelin repair. In Multiple Sclerosis Journal (Vol. 23, pp. 996-996).

James, E. J., Gu, J., Ramirez-Vizcarrondo, C. M., Hasan, M., Truszkowski, T. L., Tan, Y., ... & Aizenman, C. D. (2015). Valproate-induced neurodevelopmental deficits in Xenopus laevis tadpoles. Journal of Neuroscience, 35(7), 3218-3229.

Jang, E. V., Ramirez-Vizcarrondo, C., Aizenman, C. D., & Khakhalin, A. S. (2016). Emergence of selectivity to looming stimuli in a spiking network model of the optic tectum. Frontiers in neural circuits, 10, 95.

Khakhalin, A. (2019). Graph analysis of looming-selective networks in the tectum, and its replication in a simple computational model. BioRxiv, 589887.

Khakhalin, A. S., Koren, D., Gu, J., Xu, H., & Aizenman, C. D. (2014). Excitation and inhibition in recurrent networks mediate collision avoidance in X enopus tadpoles. European Journal of Neuroscience, 40(6), 2948-2962.

Ramirez-Vizcarrondo, C., Hasan, M., Gu, J., Khakhalin, A., & Aizenman, C. (2015). Novel Behavioral Assays to Model Neurodevelopmental Disorders in the Xenopus laevis Tadpole. The FASEB Journal, 29(1_supplement), 657-1.