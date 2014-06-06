require 'matrix'

def sigmoid(x)
  Math.tanh(x)
end

def dsigmoid(y)
  1.0 - y**2
end

# monkey patch...
class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class NeuralNetwork
  def initialize(ni, nh, no)
    # Number of nodes: input, hidden, output
    @ni = ni + 1 # bias
    @nh = nh
    @no = no

    # Activation
    @ai  = [1.0] * @ni
    @ah = [1.0] * @nh
    @ao = [1.0] * @no

    # Weights with random initial values
    @wi = Matrix.build(@ni, @nh) { rand(-0.2..0.2) }
    @wo = Matrix.build(@nh, @no) { rand(-2.0..2.0) }

    # For momentum
    @ci = Matrix.build(@ni, @nh) { 0 }
    @co = Matrix.build(@nh, @no) { 0 }
  end

  def train(patterns, 
            iterations: 1000, 
            learning_rate: 0.3, 
            momentum_rate: 0.5)
    iterations.times do |i|
      puts "  Iteration #{i}"
      error = 0.0
      patterns.each do |p|
        inputs = p[0]
        targets = p[1]
        run(inputs)
        error += backpropagate(targets, learning_rate, momentum_rate)
      end
    end
  end

  def test(patterns)
    total = patterns.length
    correct = 0

    patterns.each do |p|
      input = p[0]
      output = run(p[0]).map(&:round)
      expected = p[1]

      print "out #{output}, exp #{expected}\n"

      if expected == output
        correct += 1
      end
    end

    correct
  end

private

  def run(inputs)
    unless inputs.length == @ni-1
      raise ArgumentError.new('Wrong number of inputs!')
    end

    # Input activations
    (@ni-1).times do |i|
      @ai[i] = inputs[i]
    end

    # Hidden activations
    @nh.times do |j|
      sum = 0
      @ni.times do |i|
        sum += @ai[i] * @wi[i, j]
      end
      @ah[j] = sigmoid(sum)
    end

    # Output activations
    @no.times do |k|
      sum = 0
      @nh.times do |j|
        sum += @ah[j] * @wo[j, k]
      end
      @ao[k] = sigmoid(sum)
    end

    @ao.clone
  end

  def backpropagate(targets, learning_rate, momentum_rate)
    unless targets.length == @no
      raise ArgumentError.new('Wrong number of targets!')
    end

    # Error for output
    output_deltas = [0.0] * @no
    @no.times do |k|
      error = targets[k] - @ao[k]
      output_deltas[k] = dsigmoid(@ao[k]) * error
    end

    # Error for hidden
    hidden_deltas = [0.0] * @nh
    @nh.times do |j|
      error = 0
      @no.times do |k|
        error += output_deltas[k] * @wo[j, k]
      end
      hidden_deltas[j] = dsigmoid(@ah[j]) * error
    end

    # Update output weights
    @nh.times do |j|
      @no.times do |k|
        delta = output_deltas[k] * @ah[j]
        @wo[j, k] = @wo[j, k] + learning_rate*delta + momentum_rate*@co[j, k]
        @co[j, k] = delta
      end
    end

    # Update input weights
    @ni.times do |i|
      @nh.times do |j|
        delta = hidden_deltas[j] * @ai[i]
        @wi[i, j] = @wi[i, j] + learning_rate*delta + momentum_rate*@ci[i, j]
        @ci[i, j] = delta
      end
    end
    
    # Error
    error = 0
    targets.length.times do |k|
      error += 0.5 * (targets[k] - @ao[k])**2
    end

    error
  end
end
