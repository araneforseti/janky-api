require_relative '../spec_helper.rb'
require 'repository'
require 'redis'
require 'json'

describe Repository do
  let(:repository) { Repository.new }

  before(:each) do
    @redis = Redis.new
    keys = @redis.keys('*')
    keys.each{ |key| @redis.del(key)}
  end

  context 'no data' do
    it 'gets an empty list of sheets' do
      expect(repository.all).to eq([])
    end
  end

  context 'some data' do
    it 'gets all stored data' do
      sheet = Sheet.new('Cal')
      @redis.setnx "Cal", sheet.state.to_json
      sheets = repository.all
      expect(sheets.size).to eq(1)
    end

    it 'returns data as sheets objects' do
      sheet = Sheet.new('Cal')
      @redis.setnx "Cal", sheet.state.to_json
      sheets = repository.all
      expect(sheets[0] == sheet).to be true
    end

    it 'retrieves skills' do
      sheet = Sheet.new('Cal')
      skill = Skill.new('skillz')
      skill.hours = 23
      sheet.add_skill skill
      @redis.setnx "Cal", sheet.state.to_json
      stored_skills = repository.all[0].skills
      expect(stored_skills.size).to eq(1)
      expect(stored_skills[0] == skill).to be true
    end

    it 'returns data as sheets objects' do
      sheet = Sheet.new('Cal')
      @redis.setnx "Cal", sheet.state.to_json
      sheets = repository.all
      expect(sheets[0] == sheet).to be true
    end
  end

  context 'retrieve by name' do
    it 'returns nil if name does not exist' do
      expect(repository.get('nada')).to eq(nil)
    end

    it 'returns sheet if name is found' do
      sheet = Sheet.new('Cal')
      @redis.setnx "Cal", sheet.state.to_json
      expect(repository.get('Cal') == sheet).to be true
    end

    it 'retrieves skills' do
      sheet = Sheet.new('Cal')
      skill = Skill.new('skillz')
      skill.hours = 23
      sheet.add_skill skill
      @redis.setnx "Cal", sheet.state.to_json
      stored_skills = repository.get('Cal').skills
      expect(stored_skills.size).to eq(1)
      expect(stored_skills[0] == skill).to be true
    end
  end

  context 'adding sheet' do
    it 'adds given sheet to database by name' do
      sheet = Sheet.new('New Sheet')
      repository.add(sheet)
      expect(@redis.keys('*')[0]).to eq('New Sheet')
      stored_sheet = @redis.get('New Sheet')
      expect(stored_sheet == sheet.state.to_json).to be true
    end
  end
end
