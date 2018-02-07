require 'sinatra'
require 'sinatra/namespace'
require 'redis'
require 'json'
require './lib/repository.rb'
require './lib/sheet.rb'

redis = Redis.new
set :show_exceptions, :after_handler

get '/api-docs' do
  send_file File.join(settings.public_folder, 'index.html')
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
    @repository = Repository.new
  end

  get '/sheets' do
    sheets = []
    @repository.all.collect{ |sheet|
      sheets << sheet
    }
    response = Hash.new
    response[:sheets] = sheets
    response.to_json
  end

  get '/sheets/:name' do
    name = params[:name]
    sheet = @repository.get(name)
    if sheet
      response = Hash.new
      response[:sheet] = sheet
      response.to_json
    else
      halt 404, {"message" => "Sheet #{name} not found"}.to_json
    end
  end

  post '/sheets' do
    params = JSON.parse(request.body.read)
    sheet = Sheet.new(params["name"], params)
    if sheet.valid?
      @repository.add(sheet)
      sheet.to_json
    else
      halt 400, {"errors" => sheet.errors}.to_json
    end
  end

  error 500 do
    {"message": "INTERNAL ERROR"}.to_json
  end
end
