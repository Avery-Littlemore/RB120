class Pet
  attr_reader :animal, :name
  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  # def to_s
  #   "a #{animal} named #{name}"
  # end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end

  def add_pet(pet)
    self.pets << pet
  end
end

class Shelter
  @@adopters = []
  def adopt(owner, pet)
    owner.add_pet(pet)
    if !@@adopters.include?(owner)
      @@adopters << owner
    end
  end

  def print_adoptions
    @@adopters.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.number_of_pets.times do |idx|
        puts "a #{owner.pets[idx].animal} named #{owner.pets[idx].name}"
      end
      puts ""
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions


# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.