class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Cat < Pet
end

kit = Cat.new
# puts kit.swim
puts kit.run
# puts kit.fetch