require 'redis'
require 'json'
require './lib/sheet.rb'
require './lib/skill.rb'

class Repository
  def initialize()
    @redis = Redis.new
  end

  def all
    values = []
    keys = @redis.keys('*')

    keys.each do |key|
      values << create_sheet(JSON.parse(@redis.get(key)))
    end

    values
  end

  def get(name)
    response = @redis.get(name)
    if response
      create_sheet(JSON.parse(response))
    end
  end

  def add(sheet)
    name = sheet.name
    @redis.set(name, sheet.to_json)
  end

  private
    def create_sheet(hash)
      sheet = Sheet.new(hash["name"])
      sheet.strength = hash["strength"]
      sheet.dexterity = hash["dexterity"]
      sheet.constitution = hash["constitution"]
      sheet.will = hash["will"]
      sheet.intelligence = hash["intelligence"]
      sheet.charisma = hash["charisma"]
      hash["skills"].each do |skill|
        name = skill["name"]
        hours = skill["hours"]
        skill = Skill.new(name)
        skill.hours = hours
        sheet.add_skill skill
      end
      sheet
    end
end
