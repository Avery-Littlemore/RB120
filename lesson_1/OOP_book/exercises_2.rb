class Vehicle
  
end  
  
class MyCar < Vehicle
  INFORMATION = 
  
  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = 0
  end

  attr_accessor :colour
  attr_reader :year
  attr_reader :model
  # attr_reader :current_speed --> not sure why this won't work... come back to it.

  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    "Your #{colour} #{model} is going #{@current_speed} km/h."
  end


  def spray_paint(paint)
    self.colour = paint
    puts "Your new #{paint} colour looks great!"
  end

  def accelerate(speed)
    @current_speed += speed
    puts "You have sped up to a whopping speed of #{@current_speed} km/h!!!"
  end

  def decelerate(speed)
    @current_speed -= speed
    puts "You have slowed down to a leisurely speed of #{@current_speed} km/h..."
  end

  def park
    @current_speed = 0
    puts "That's enough for today, let's park it."
  end

  def current_speed
    puts "You are now going #{@current_speed} km/h."
  end

  # attr_accessor :year, :colour, :model, :speed
  
  # def info
  #   "Your car is a #{colour} #{model} from #{year}. You are going #{speed} km/h"
  # end
end

jag = MyCar.new(1979, 'blue', 'jag')
# p jag
# puts jag.info
jag.accelerate(20)
jag.accelerate(20)
jag.accelerate(20)
jag.decelerate(15)
jag.accelerate(99)
jag.decelerate(100)
jag.park
puts jag
# jag.current_speed
# puts jag.colour
# jag.colour = 'red'
# puts jag.colour
# puts jag.year
# jag.year = 1989
# puts jag.year
# p jag
# puts jag.colour
# jag.spray_paint('red')
# puts jag
# p jag

# MyCar.mileage(10, 100)