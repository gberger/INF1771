require './nn'

xor = [        
  [[0,0], [0]],
  [[0,1], [1]],
  [[1,0], [1]],
  [[1,1], [0]]
]

# input, hidden, output
n = NeuralNetwork.new(2, 2, 1)

puts "Training..."
n.train(xor)

puts "Evaluating..."
correct = n.test(xor)

puts "Got #{correct}/#{xor.length} -> #{100.0*correct/xor.length}%"

n.internal