# AI-2

Second project of Artificial Intelligence class @ PUC-Rio


## Instructions

The project instructions are located at [ENUNCIADO.pdf](ENUNCIADO.pdf).


## The Pipeline -- Running the Project

First, install the dependencies:

 * Ruby
 * SWI-Prolog
 * Python 2.7
 * Pyswip
 * Node.js

Make sure the binaries of these tools are available on your PATH. 

Also, make sure all of [SWI-Prolog, Python, Pyswip] are the same architechture (x86 or x64).

Run these commands at `src/visualization`:

```
npm install --global gulp bower
npm install
bower install
```

Also, download 

Then, at the project root, run the following commands:

```
cd src

echo "Generating random items"
ruby generator/item-generator.rb > items.txt
cp items.txt visualization/app/items.txt

echo "Generating facts"
ruby generator/fact-generator.rb > facts.pl

echo "Generating action log... May take a while"
python logic/logic.py > action-log.json
cp action-log.json visualization/app/action-log.json

echo "Running gulp"
cd visualization
gulp
gulp watch
```

However, if you want to use a custom `items-custom.txt`, place it in `src` and run this one instead:

```
cd src

echo "Skipping random items, copying from src/items.txt"
cp items-custom.txt visualization/app/items.txt

echo "Generating facts"
ruby generator/fact-generator.rb > facts.pl

echo "Generating action log... May take a while"
python logic/logic.py > action-log.json
cp action-log.json visualization/app/action-log.json

echo "Running gulp"
cd visualization
gulp
gulp watch
```


## Project Structure

The project is separated in three main applications:

 * **Fact Generator**: reads src/map.txt and generates simple Prolog facts. Implemented in *Ruby*.

 * **Item Generator**: reads src/map.txt and generates a list of item positions, following the specifications set by the instructions. Implemented in *Ruby*.

 * **Logic Agent**: reads the map and uses logic to walk through the forest, while facing enemies, gathering valuables, and (hopefully) achieving the objective. Implemented in *Prolog* (logical decisions) and *Python* (consequences, path-finding, etc).

 * **Path Visualizer**: reads the map and path that were generated and draws the forest, illustrating the hero's journey. Implemented in *web technologies*.



### Item Generator

The main script is `src/generator/item-generator.rb`. You can run it like this, if you have Ruby installed:

```
ruby src/generator/item-generator.rb > src/items.txt
```

It outputs the list of items to stdout, so we'll be redirecting it to a file.

It is important that the file `src/map.txt` is accessible and in the correct format. 


### Fact Generator

The main script is `src/generator/fact-generator.rb`. You can run it like this, if you have Ruby installed:

```
ruby src/generator/fact-generator.rb > src/facts.pl
```

It outputs the facts to stdout, so we'll be redirecting it to a file.

It is important that the files `src/map.txt` and `src/items.txt` are accessible and in the correct format. 


### Logic Agent

The main script is `src/logic/logic.py`, but you must execute it from `src`. You should run it like this, if you have Python installed:

```
cd src
python logic/logic.py >  action-log.json
``` 

It outputs an array of strings to stdout, so we'll be redirecting it to a file.

It is important that the file `src/facts.pl` is accessible and up to date.


### Path Visualizer

Copy the necessary files:

```
cd src
cp items.txt /visualization/app/items.txt
cp actions-log.json /visualization/app/action-log.json
```

If you want to change some files in this step, like the map, for instance, please read Development; otherwise just read Release.

#### Development

Install the dependencies:

```
cd visualization
npm install -g gulp bower
npm install
bower install
```

And then run it:

```
gulp
gulp watch
```
A new browser window should be now open at http://loclhost:9000.

#### Release

Download [Node Webkit](https://github.com/rogerwang/node-webkit) and extract it into `src/visualization`.

Then, run `nw.exe`.

## File Formats

### map.txt

Each line corresponds to one row in the map.

Each line must contain a space-separated list of 'f' and 'g' characters, indicating whether the tile is a forest or a grass tile.

### items.txt

Each line corresponds to an item placement. 

Each line is formatted like `Y X ITEM`, where Y and X are the coordinates of a tile in map.txt, and ITEM is either:

 * `B` hole
 * `E` enemy
 * `V` vortex
 * `M` master sword
 * `F` fake master sword
 * `C` heart
 * `R` rupee

Coordinates follow these rules:

 * Begin on the top-left corner
 * Are 0-indexed
 * X is horizontal
 * Y is vertical

### log.json

It's an array of strings.
