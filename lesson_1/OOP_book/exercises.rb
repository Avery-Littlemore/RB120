require 'time'

module Convertible
  def convert
    "I can put the top down!"
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Student
  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(comparator)
    grade > comparator.grade
  end

  protected
  attr_reader :grade

  # def grade
  #   @grade
  # end
end

class Vehicle
  @@number_of_vehicles = 0

  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    @@number_of_vehicles 
  end

  attr_accessor :colour
  attr_reader :year
  attr_reader :model
  # attr_reader :current_speed --> not sure why this won't work... come back to it.

  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
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

  def age
    "Your #{model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - year.to_i
  end

end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  include Convertible
  def to_s
    "Your car is a #{colour} #{model} and from #{year} it is going #{@current_speed} km/h."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Towable
  def to_s
    "Your truck is a #{colour} #{model} from #{year} and it is going #{@current_speed} km/h."
  end
end

ave = Student.new('Avery', 100)
sean = Student.new('Sean', 99)
puts ave.better_grade_than?(sean)
puts sean.better_grade_than?(ave)

# jag = MyCar.new(1979, 'red', 'jag')
# # puts jag
# # puts jag.convert
# # puts Vehicle.number_of_vehicles
# truck = MyTruck.new(2012, 'white', 'F100')
# # puts truck
# # puts truck.can_tow?(4000)
# # puts Vehicle.number_of_vehicles
# # puts "-----"
# # puts MyCar.ancestors
# # puts "-----"
# # puts MyTruck.ancestors
# # puts "-----"
# # puts Vehicle.ancestors


# # jag.accelerate(20)
# # jag.current_speed
# # jag.accelerate(20)
# # jag.current_speed
# # jag.decelerate(20)
# # jag.current_speed
# # jag.decelerate(20)
# # jag.current_speed
# # jag.park
# # MyCar.mileage(13, 351)
# # puts jag

# puts jag.age
# puts truck.age

# # truck.accelerate(20)
# # truck.current_speed
# # truck.accelerate(20)
# # truck.current_speed
# # truck.decelerate(20)
# # truck.current_speed
# # truck.decelerate(20)
# # truck.current_speed
# # truck.park
# # MyTruck.mileage(100, 201)
# # puts truck
# # lumina.spray_paint("red")
# # puts lumina
# # puts MyCar.ancestors
# # puts MyTruck.ancestors
# # puts Vehicle.ancestors