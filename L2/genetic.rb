require './ooo'

class Chromosome
  GENOME = (?A..?K).to_a
  GENES_COUNT = 11
  MUTATION_CHANCE = 0.20

  attr_reader :genes
  attr_reader :mutated
  attr_reader :rating

  def initialize(genes, mutated = false)
    raise ArgumentError.new("Must have #{GENES_COUNT} genes!") unless genes.length == GENES_COUNT
    raise ArgumentError.new("Possible genes: #{GENOME.join}.") if genes.join =~ /[^A-K]/

    @genes = genes
    @mutated = mutated
    rate!
  end

  def self.gen
    Chromosome.new(GENOME.shuffle)
  end

  def rate!
    @rating = genes.each_cons(2).reduce(0) do |sum, curnex|
      cur, nex = curnex
      sum + Ooo.dijkstra(cur, nex)
    end
  end

  def breed(other)
    bit_mask = Array.new(GENES_COUNT) { rand(2) }

    # using the bit mask, copy genes from the first parent
    new_genes = genes.each_with_index.map do |g, i|
      if bit_mask[i] == 1
        g
      else
        nil
      end
    end

    # sort the remaining genes in the order of the other parent's genes
    remaining_genes = genes.reject {|g| new_genes.include?(g) }
    remaining_genes.sort! do |a, b|
      other.genes.index(a) <=> other.genes.index(b)
    end

    # insert the remaining genes into the gaps
    new_genes.map! do |g|
      if g == nil
        remaining_genes.shift
      else
        g
      end
    end

    if rand(100)/100.0 <= MUTATION_CHANCE
      Chromosome.new(new_genes).mutate
    else
      Chromosome.new(new_genes)
    end
  end

  def mutate
    new_genes = genes.clone

    begin
      i, j = rand(GENES_COUNT), rand(GENES_COUNT)
    end while i == j

    new_genes[i], new_genes[j] = new_genes[j], new_genes[i]

    Chromosome.new(new_genes, true)
  end


  def to_s
    "#{genes.join} #{mutated ? '*' : ' '} --> #{rating}"
  end
end


class Population
  attr_reader :individuals

  def self.with_size(n)
    Population.new(Array.new(n) { Chromosome.gen })
  end

  def initialize(individuals)
    @individuals = individuals
  end

  def best(n = nil)
    n = individuals.count/2 if n.nil?
    individuals.sort_by { |i| i.rating }.take(n)
  end

  def next_generation
    new_individuals = []
    elite = best
    new_individuals = elite

    begin
      a, b = elite.shuffle.take(2)
      new_individuals << a.breed(b)
    end while new_individuals.count != individuals.count

    Population.new(new_individuals)
  end

  def to_s
    "Population <#{object_id}> size: #{individuals.count}\n" + individuals.map {|i| ">>> #{i.to_s}"}.join("\n")
  end
end