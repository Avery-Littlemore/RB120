class Student
  attr_reader :id

  def initialize(name)
    @name = name
    @id
  end

  def id=(value)
    # self.id = value
    @id = value
  end
end

# tom = Student.new("Tom")
# tom.id = 45

#1 — What will the following code output? Why?

class Foo

  def self.create_new
    new
  end

  def self.method_a
    "Justice" + all
  end

  def self.method_b(other)
    "Justice" + other.exclamate
  end

  private

  def self.all
    " for all"
  end

  def self.exclamate
    all + "!!!"
  end
end

foo = Foo.new
p foo
puts Foo.method_a #
puts foo.method_b(Foo) #

obj = Foo.create_new
p obj

# puts Foo.method_b(obj) #

#5 — What will the last 2 lines of code output?