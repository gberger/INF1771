Project 1 - Heuristic Search
============================

* [Enunciado](ENUNCIADO.pdf)

See it in action
-----------

    npm install -g harp
    harp server src

Project structure
-----------------

 * `css`: all Sass files.
 * `data`: all map files. Each map is a text file in 3 parts, separated by a `\n---\n`:
    * the index of the map
    * the map itself
    * "doors" leading to other maps
    * objectives
 * `js`: all CoffeeScript files, where the logic happens.
    * `delayed-each` is an extension to the LoDash lib
    * `matrix` makes a matrix
    * `char-matrix` makes a matrix out of a multiline string
    * `map` represents one map
    * `world` encapsulates all the maps
    * `world-marker` an utility for marking visited positions on the world
    * `state` represents a node for the heuristic search algorithm
    * `heuristic-search` the algorithm. It uses a Heap instead of a Tree.
    * `dom-renderer` renders the world, the search indicators and the movements
    * `main` calls the algorithm and has some logic of its own
    * `loader` loads the `data` files and kicks off `main`
 * `lib`: some libraries.
    * `jquery` is for DOM manipulation and Ajax
    * `lodash` is a utility belt
    * `heap` is an efficient implementation of a Heap
    * `font-awesome` has some pretty icons
 * `index.html` visit this to see the action
