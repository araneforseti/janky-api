require_relative '../spec_helper.rb'
require 'skill'

describe Skill do
  context 'new skill' do
    let(:skill) { Skill.new("New Skill") }

    it 'name is set' do
      expect(skill.name).to eq("New Skill")
    end

    it 'hours are default zero' do
      expect(skill.hours).to eq(0)
    end

    it 'progress is zero' do
      expect(skill.progress).to eq(0)
    end
  end

  context 'skill with some hours' do
    it 'progress is based on percentage of 10,000 hours' do
      skill = Skill.new("name")
      skill.hours = 250
      expect(skill.progress).to eq(2.5)
    end
  end

  context 'skill with 10,000 hours' do
    it 'progress is full' do
      skill = Skill.new("name")
      skill.hours = 10000
      expect(skill.progress).to eq(100)
    end
  end

  context 'equality' do
    let(:skill) { Skill.new('Default') }

    it 'is equal for same object' do
      expect(skill == skill).to be true
    end

    it 'is equal for object with same name and hours' do
      other_skill = Skill.new(skill.name)
      other_skill.hours = skill.hours
      expect(skill == other_skill).to be true
    end

    it 'is not equal for different hours' do
      other_skill = skill.clone
      other_skill.hours = skill.hours + 2
      expect(skill == other_skill).to be false
    end

    it 'is not equal for different name' do
      other_skill = skill.clone
      other_skill.name = skill.name + "asdf"
      expect(skill == other_skill).to be false
    end
  end
end
