class GoodDog
  DOG_YEARS = 7
  
  attr_accessor :name, :age

  @@number_of_dogs = 0

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def to_s
    "This dog's name is #{name} and it is #{age} dog years old."
  end
end

puts GoodDog.total_number_of_dogs   # => 0

sparky = GoodDog.new("Sparky", 4)
spot = GoodDog.new("Spot", 2)

puts GoodDog.total_number_of_dogs   # => 2

# puts "#{sparky.name} #{sparky.age}"            # => 28
# puts "#{spot.name} #{spot.age}"

puts sparky.to_s
puts spot