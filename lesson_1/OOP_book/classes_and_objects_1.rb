class GoodDog
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  attr_accessor :name, :height, :weight
  # attr_reader # getter only
  # attr_write # setter only

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end
  
  def speak
    "#{name} says: Arf!"
  end

  def info
    "#{name} weighs #{self.weight} and is #{height} tall"
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10lbs')
puts sparky.speak
puts sparky.info
# sparky.name = 'Spartacus'
sparky.change_info('Spartacus', '13 inches', '12lbs')
puts sparky.info

# fido = GoodDog.new("Fido")
# puts fido.speak
# puts fido.get_name