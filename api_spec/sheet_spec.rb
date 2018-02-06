require_relative 'api_spec_helper.rb'
require 'rack/test'

include Rack::Test::Methods

describe Sheet do
  it 'returns empty list with no data' do
    response = get "http://localhost:4567/api/v1/sheets"
    expect(response.body).to eq '{"sheets":[]}'
  end

  context 'adding sheets' do
    ["sheet1", "sheet2", "sheet3", "sheet4", "sheet5"].each do | name |
      it "valid sheet for #{name}" do
        json = {"name" => "#{name}", "dexterity" => 2, "strength" => 4,
               "constitution" => 3, "will" => 4, "intelligence" => 5, "charisma"=> 6,
               "skills"=> []}
        response = post "http://localhost:4567/api/v1/sheets", json.to_json, { 'CONTENT_TYPE' => 'application/json' }
        expect(JSON.parse(response.body)).to eq json
      end
    end
  end
end

def get url
  browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  browser.get url
end
