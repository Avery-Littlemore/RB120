module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  attr_accessor :name
  COLOUR = 'black'

  @@number_of_cats = 0
  
  def initialize(name)
    @name = name
    @@number_of_cats += 1
  end

  def rename(new_name)
    self.name = new_name
  end

  def greeting
    puts "Hello! My name is #{name} and I am a #{COLOUR} cat!"
  end

  def identify
    self
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! I am #{name}!"
  end

  def self.total
    puts @@number_of_cats
  end

  def to_s
    "I'm #{name}!"
  end
end

class Person
  attr_writer :secret

  def compare_secret(comparator)
    secret == comparator
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)