// Initialize
SinOsc s1 => dac.left;  0 => s1.gain; 
SinOsc s2 => dac.right; 0 => s2.gain;

// ------- Tuning parameters

0.3 => float vol;       // Stimulus volume (relative units, between 0 and 1)
2000 => int period;     // Interval betweeen stimuli, ms (20000 is good)
100 => int isi;         // Inter-stimulus interval for PPI, ms
0.2 => float prepulse;  // How much weaker pre-pulse is, compared to the pulse.
                        // Set to 0 for single pulses.
200 => float f;         // Carrying frequency, Hz (200 is good)

// ------- END of tuning parameters



1000/f => float len;    // Length of each stimulus, ms
0.5 => s2.phase;
f => s1.freq;
f => s2.freq;
0 => int counter;
    
while( true )
{
    1 +=> counter;
    if((counter % 2 ==0) & (prepulse>0)) {
        vol*prepulse => s1.gain; 
        vol*prepulse => s2.gain;  
        <<< counter, "- Double" >>>;
    }
    else {
        <<< counter , "- Single" >>>;
    }
    len::ms => now;
    0.0 => s1.gain; 
    0.0 => s2.gain;  
    isi::ms => now;
    vol => s1.gain; 
    vol => s2.gain;  
    len::ms => now;
    0.0 => s1.gain; 
    0.0 => s2.gain;    
    (period-2*len-isi)::ms => now;
}