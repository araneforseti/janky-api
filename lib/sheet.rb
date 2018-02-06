class Sheet 
  attr_accessor :strength  
  attr_accessor :dexterity
  attr_accessor :constitution
  attr_accessor :will
  attr_accessor :intelligence
  attr_accessor :charisma
  attr_accessor :skills
  attr_accessor :name

  def initialize(name, params={})
    self.name = name
    self.strength = params["strength"]? params["strength"] : 10
    self.dexterity = params["dexterity"]? params["dexterity"] : 10
    self.constitution = params["constitution"]? params["constitution"] : 10
    self.will = params["will"]? params["will"] : 10
    self.intelligence = params["intelligence"]? params["intelligence"] : 10
    self.charisma = params["charisma"]? params["charisma"] : 10
    self.skills = params["skills"]? params["skills"] : []
  end

  def valid?
    valid = true
    if(!self.name.is_a?(String) || self.name.empty?)then
      valid = false
    end
    if(!(self.strength > 0 && self.strength < 100)) then
      valid = false
    end
    if !(self.dexterity >= 0 && self.dexterity <= 100) then
      valid = false
    end
    if !(self.constitution >= 0 && self.constitution <= 100) then
      valid = false
    end
    if !(self.will >= 0 && self.will <= 100) then
      valid = false
    end
    if !(self.intelligence >= 0 && self.intelligence <= 100) then
      valid = false
    end
    if !all_skills_valid then
      valid = false
    end
    valid 
  end

  def all_skills_valid
    true
  end

  def add_skill(skill)
    self.skills << skill
  end

  def ==(other_sheet)
    return (self.state == other_sheet.state)
  end

  def state
    {:strength => self.strength, :dexterity => self.dexterity, :constitution => self.constitution,
      :will => self.will, :intelligence => self.intelligence, :charisma => self.charisma, :skills => get_skill_state,
      :name => self.name}
  end

  def clone
    new_sheet = Sheet.new(self.name)
    new_sheet.strength = self.strength
    new_sheet.constitution = self.constitution
    new_sheet.dexterity = self.dexterity
    new_sheet.will = self.will
    new_sheet.intelligence = self.intelligence
    new_sheet.charisma = self.charisma
    self.skills.each do |skill|
      new_skill = Skill.new(skill.name)
      new_skill.hours = skill.hours
    end
    new_sheet
  end

  def get_skill_state
    self.skills.collect{ |skill| 
      skill.state 
    }
  end

  def to_json(*args)
    state.to_json
  end
end
