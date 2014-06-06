require './nn'
require './rarff'

rel = Rarff::Relation.new
rel.parse(ARGF.read)

def to_output_arr(num, total)
  arr = Array.new(total){0}
  arr[num] = 1
  arr
end

examples = rel.instances.map do |i|
  [i[0...-1], to_output_arr(i[-1], 9)]
end

input = rel.attributes.size - 1
hidden = rel.attributes.size + 9
output = 9

# input, hidden, output
n = NeuralNetwork.new(input, hidden, output)

puts "Training..."
n.train(examples)

puts "Evaluating..."
correct = n.test(examples)

puts "Got #{correct}/#{examples.length} -> #{100.0*correct/examples.length}%"
