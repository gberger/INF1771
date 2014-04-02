Project 1 - Heuristic Search
============================

* [Enunciado](ENUNCIADO.pdf)


Open
----

Open `build/index.html` to see it in action.


Project structure
-----------------

 * `css`: all Sass files.
 * `js`: all CoffeeScript files, where the logic happens.
    * `data`: the file with configuration data. The following configs exist:
        * `aliases`: nicknames for sequences of positions. Can use other aliases to define.
        * `solutions`: sequences of positions that represent valid solutions. Can use aliases to define.
        * `terrainTypes`: the cost associated to each type of terrain. `null` represents an inaccessible terrain.
        * `maps`: represented as array of strings, one element per line.
        * `icons`: points of interests in the maps.
    * `delayed-each` is an extension to the LoDash lib.
    * `matrix` makes a matrix.
    * `char-matrix` makes a matrix out of a multiline string.
    * `map` represents one map.
    * `world` encapsulates all the maps.
    * `world-marker` an utility for marking visited positions on the world.
    * `state` represents a node for the heuristic search algorithm.
    * `heuristic-search` is the algorithm. It uses a Heap, sorted by the result of a state's heuristic.
    * `dom-renderer` renders the world, the search indicators and the movements.
    * `main` loads the data, creates the world and calls the algorithm.
 * `lib`: some libraries.
    * `jquery` is for DOM manipulation and Ajax.
    * `lodash` is a utility belt.
    * `heap` is an efficient implementation of a Heap.
    * `font-awesome` has some pretty icons.
 * `index.html` visit this to see the action!


Developing
-----------

    npm install -g harp
    harp server src


Building
--------

    gulp dist

