require './graph'

# create the graph representing the land of ooo
Ooo = Graph.new

(?A..?K).each { |node| Ooo.push node }

Ooo.connect_mutually ?F, ?A, 3
Ooo.connect_mutually ?A, ?G, 4
Ooo.connect_mutually ?A, ?E, 6
Ooo.connect_mutually ?A, ?B, 5
Ooo.connect_mutually ?B, ?J, 7
Ooo.connect_mutually ?B, ?C, 9
Ooo.connect_mutually ?C, ?D, 8
Ooo.connect_mutually ?C, ?H, 9
Ooo.connect_mutually ?D, ?I, 5
Ooo.connect_mutually ?D, ?E, 2
Ooo.connect_mutually ?C, ?H, 9
Ooo.connect_mutually ?H, ?K, 3
Ooo.connect_mutually ?J, ?K, 4
