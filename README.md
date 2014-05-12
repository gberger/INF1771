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
 * Gulp (npm install --global gulp)

Make sure the binaries of these tools are available on your PATH. 

Also, make sure all of [SWI-Prolog, Python, Pyswip] are the same architechture (x86 or x64).


Then, at the project root, run the following commands:

```
cd src

# map.txt + item-generator.rb ==> items.txt
ruby generator/item-generator.rb > items.txt`

# map.txt + items.txt + fact-generator.rb ==> facts.pl
ruby generator/fact-generator.rb > facts.pl

# map.txt + items.txt + facts.pl + logic.py ==> action-log.json
python logic/logic.py > action-log.json

# action-log.json + gulp ==> localhost:9000
gulp watch

# now go to http://localhost:9000!
```


## Project Structure

The project is separated in three main applications:

 * **Item Generator**: reads src/map.txt and generates outputs a list of item positions, following the specifications set by the instructions. Implemented in *Ruby*.

 * **Fact Generator**: reads src/map.txt and src/items.txt and generates Prolog facts. Implemented in *Ruby*.

 * **Logic Agent**: reads the map and uses logic to walk through the forest, while facing enemies, gathering valuables, and (hopefully) achieving the objective. Implemented in *Prolog* (logical decisions) and *Python* (consequences, path-finding, etc).

 * **Path Illustrator**: reads the map and path that were generated and draws the forest, illustrating the hero's journey. Implemented in *web technologies*.



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

