# Circadian_toolbox

Citing:
Levine JD, Funes P, Dowse HB, Hall JC: Signal Analysis of Behavioral and Molecular Cycles. BMC Neuroscience 2002, 3:1. 

# Instructions
Download the current version .zip file containing all the .m files needed to analyze Drosophila Actvity Monitor data.

Unzip the 'matlab extras' folder.

Open Matlab

Click File->Set Path

Click 'Add with Subfolders'

Navigate to where you extracted the 'matlab extras' folder

Select it and click 'Ok'

Click 'Save'

To test if it is working, type 'help dam_load' (it should spit out text - it is useful to know that typing help can bring up help text
about a specific command [e.g. help dam_panels2, help dam_analyze]).

# Requirements
These require the signal processing toolbox, I've included open source alternatives (circ_toolbox/open_source_alternatives/ needs extracting). BUT these files seem to output a different
analysis than the signal processing toolbox (most likely due to the open source filtfilt.m). Although it seems fairly close, the autocorrelation is
slightly affected and the mesa order and period are a little off
