# # class Animal
# #   def speak
# #     "Hello!"
# #   end
# # end

# # class GoodDog < Animal
# #   def speak
# #     super + " from GoodDog class"
# #   end
# # end

# # class Cat < Animal
# # end

# # sparky = GoodDog.new
# # paws = Cat.new
# # puts paws.speak             # => Hello!
# # puts sparky.speak           # => Hello! from GoodDog class


# module Swimmable
#   def swim
#     "I'm swimming!"
#   end
# end

# class Animal; end

# class Fish < Animal
#   include Swimmable         # mixing in Swimmable module
# end

# class Mammal < Animal
# end

# class Cat < Mammal
# end

# class Dog < Mammal
#   include Swimmable         # mixing in Swimmable module
# end

# sparky = Dog.new
# neemo  = Fish.new
# paws   = Cat.new

# p sparky.swim                 # => I'm swimming!
# p neemo.swim                  # => I'm swimming!
# p paws.swim                   # => NoMethodError: undefined method `swim' for #<Cat:0x007fc453152308>

# module Walkable
#   def walk
#     "I'm walking."
#   end
# end

# module Swimmable
#   def swim
#     "I'm swimming."
#   end
# end

# module Climbable
#   def climb
#     "I'm climbing."
#   end
# end

# class Animal
#   include Walkable

#   def speak
#     "I'm an animal, and I speak!"
#   end
# end

# # puts Animal.ancestors
# fido = Animal.new
# puts fido.speak
# puts fido.walk

# class Person
#   def initialize(age)
#     @age = age
#   end

#   def older?(other_person)
#     age > other_person.age
#   end

#   protected

#   attr_reader :age
# end

# malory = Person.new(64)
# sterling = Person.new(42)

# p malory.older?(sterling)  # => true
# p sterling.older?(malory)  # => false

# malory.age
  # => NoMethodError: protected method `age' called for #<Person: @age=64>

  class Parent
    def say_hi
      p "Hi from Parent."
    end
  end
  
  puts Parent.ancestors       # => Object