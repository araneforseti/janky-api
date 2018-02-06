require_relative '../spec_helper.rb'
require 'sheet'

describe Sheet do
  context 'default values' do
    let (:sheet) { Sheet.new('New Name') }
    let (:average) { 10 }

    it 'strength is average' do
      expect(sheet.strength).to eq(10)
    end

    it 'dexterity is average' do
      expect(sheet.dexterity).to eq(10)
    end

    it 'constitution is average' do
      expect(sheet.constitution).to eq(10)
    end

    it 'will is average' do
      expect(sheet.will).to eq(10)
    end

    it 'intelligence is average' do
      expect(sheet.intelligence).to eq(10)
    end

    it 'charisma is average' do
      expect(sheet.charisma).to eq(10)
    end

    it 'skills is an empty list' do
      expect(sheet.skills).to eq([])
    end

    it 'takes a name' do 
      expect(sheet.name).to eq('New Name')
    end
  end
 
  context 'manage skills' do
    let(:sheet) { Sheet.new('name') }

    it 'can add skill' do
      sheet.add_skill Skill.new('New Skill')
      skills = sheet.skills
      expect(skills.size).to eq(1)
      expect(skills[0].name).to eq('New Skill')
    end
  end

  context 'comparing sheets' do
    let(:default_sheet) { Sheet.new('default') }
 
    it 'returns true for same sheet' do
      expect(default_sheet == default_sheet).to be true
    end
 
    it 'returns true for different sheet with same values' do
      other_sheet = Sheet.new('default')
      expect(default_sheet == other_sheet).to be true
    end

    it 'returns false for sheets with different names' do
      other_sheet = Sheet.new('other name')
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different strengths' do
      other_sheet = default_sheet.clone
      other_sheet.strength = default_sheet.strength - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different dexterities' do
      other_sheet = default_sheet.clone
      other_sheet.dexterity = default_sheet.dexterity - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different constitutions' do
      other_sheet = default_sheet.clone
      other_sheet.constitution = default_sheet.constitution - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different wills' do
      other_sheet = default_sheet.clone
      other_sheet.will = default_sheet.will - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different intelligences' do
      other_sheet = default_sheet.clone
      other_sheet.intelligence = default_sheet.intelligence - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different charismas' do
      other_sheet = default_sheet.clone
      other_sheet.charisma = default_sheet.charisma - 2
      expect(default_sheet == other_sheet).to be false
    end

    it 'returns false for sheets with different skills' do
      other_sheet = default_sheet.clone
      other_sheet.add_skill Skill.new('Skill')
      expect(default_sheet == other_sheet).to be false
    end
  end
end
