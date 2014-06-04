Project 3 - Machine Learning - Hand Gestures
============================================

* [Enunciado](ENUNCIADO.pdf)


## Instructions

The project instructions are located at [ENUNCIADO.pdf](ENUNCIADO.pdf).


## Installation

Instructions for installing OpenCV on Ubuntu 14.04 or 13.10:
[here](http://www.sysads.co.uk/2014/05/install-opencv-2-4-9-ubuntu-14-04-13-10/).

Instructions for installing OpenCV on Ubuntu 13.04 or below:
[here](https://help.ubuntu.com/community/OpenCV).

Download the [example sets](ftp://mi.eng.cam.ac.uk/pub/CamGesData/)
and extract them to the examples folder.

## Generating ARFF files

Run `arff_generator.py`, providing the number of frames extracted per example
(more than 2 -- more frames provides better but slower classification) and the
example sets that will be used. 

The following call extracts 6 frames per example, uses the Sets 2, 3 and 5, and
saves it all on a file:

```
$ python extractor/arff_generator.py 6  2 3 5 > 6-235.arff
```

## Classifying on Weka

Load up the arff files.
