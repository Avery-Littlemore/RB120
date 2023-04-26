class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    parse_full_name(name)
  end

  def to_s
    name
  end

  private
  def parse_full_name(name)
    name = name.split
    self.first_name = name.first
    self.last_name = name.size == 1 ? '' : name.last
  end
    
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = 'John Adams'
p bob.first_name
p bob.last_name

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

puts "This person's name is #{bob}"