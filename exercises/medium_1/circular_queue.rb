require 'pry'

class CircularQueue
  def initialize(num_of_positions)
    @queue_array = Array.new(num_of_positions)
    @add_counter = 0
    @delete_counter = 0
  end

  def enqueue(num)
    if @queue_array[@add_counter] == nil
      @queue_array[@add_counter] = num
      @add_counter = increment(@add_counter)
    else
      @queue_array[@add_counter] = num
      @add_counter = increment(@add_counter)
      @delete_counter = increment(@delete_counter)
    end
  end

  def dequeue
    if @queue_array[@delete_counter] == nil
      nil
    else
      result = @queue_array[@delete_counter]
      @queue_array[@delete_counter] = nil
      @delete_counter = increment(@delete_counter)
      return result
    end
  end

  private

  def increment(position)
    (position + 1) % @queue_array.size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
# binding.pry
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
# binding.pry
puts queue.dequeue == 2


queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
# binding.pry
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

# The above code should display true 15 times.
