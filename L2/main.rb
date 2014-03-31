require './genetic'

initial_orders = %w(FAGEDICBJKH AFGBCDEIHKJ JKHCBFAGEID IDCBAEGFJKH)
initial_chromosomes = initial_orders.map { |o| Chromosome.new(o.chars.to_a) }
initial_population = Population.new(initial_chromosomes)


population = initial_population
puts population

5.times do
  population = population.next_generation
  puts population
end


# to run 1000 times on a population of 100:
# population = Population.with_size(100)
# 100.times do
#   population = population.next_generation
# end
# puts population 
