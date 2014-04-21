List 2 - Genetic Algorithms
===========================

 * [Enunciado](ENUNCIADO.pdf)

The goal of this exercise list was to implement a Genetic Algorithm that attempts to solve the Travelling Salesman Problem.

 * `main.rb` runs a simulation with fixed initial values and 5 generations

 * `graph.rb` is a small graph lib

 * `ooo.rb` defines a constant **Ooo** that is the graph that describes our problem

 * `genetic.rb` defines two classes:
    * **Chromosome** represents one individual, with 11 genes (node visit order). It has methods to **breed** with another indiviual, **mutate** swapping two of its genes, and **rating** which uses the Ooo graph to calculate the total visit cost.
    * **Population** encapsulates a set of indivisuals. It has the class method **with_size**, which can be used like Population.with_size(4) to create a new population with 4 individuals. Its instance methods are **next_generation**, which creates a new population using the return value of **best**, which is a sorted list of the N/2 best individuals of the population, according to their rating.

