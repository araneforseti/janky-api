class Skill
  attr_accessor :hours
  attr_accessor :name

  def initialize(name)
    self.name = name
    self.hours = 0
  end

  def progress
    return (hours / 10000.0) * 100.0
  end

  def state
    {:name => name, :hours => hours}
  end

  def ==(other_skill)
    return self.state == other_skill.state
  end
end
