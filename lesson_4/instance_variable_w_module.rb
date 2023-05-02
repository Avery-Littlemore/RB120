module Add
  def mod_instance
    @modded = 'from module'
  end
end

class Greeting
  include Add
  def initialize
    @init = 'initialized'
  end
end

class Diffclass
  include Add
  def initialize
    @init = 'diff_init'
  end
end

greet = Greeting.new
p greet # => #<Greeting:0x000000012f91ebe8 @init="initialized">
greet.mod_instance
p greet # => #<Greeting:0x000000012f91ebe8 @init="initialized", @modded="from module">

diff = Diffclass.new
p diff # => #<Greeting:0x000000012f91ebe8 @init="initialized">
diff.mod_instance
p diff # => #<Greeting:0x000000012f91ebe8 @init="initialized", @modded="from module">
