require 'sinatra'
require 'sinatra/namespace'
require 'redis'
require 'json'
require './lib/repository.rb'
require './lib/sheet.rb'

redis = Redis.new
set :show_exceptions, :after_handler

namespace '/api/v1' do
  before do
    content_type 'application/json'
    @repository = Repository.new
  end

  get '/sheets' do
    if params[:name]
      sheet = @repository.get(params[:name])
      if sheet
        response = Hash.new
        response[:sheet] = sheet
        response.to_json
      else
        halt 404
      end
    else
      sheets = []
      @repository.all.collect{ |sheet|
        sheets << sheet
      }
      response = Hash.new
      response[:sheets] = sheets
      response.to_json
    end
  end

  post '/sheets' do
    params = JSON.parse(request.body.read)
    sheet = Sheet.new(params["name"], params)
    @repository.add(sheet)
    sheet.to_json
  end

  error 500 do
    {"message": "INTERNAL ERROR"}.to_json
  end

  error 404 do
    {"message": "Resource not found"}.to_json
  end

  error 400 do
    {"message": "Problem with request format"}.to_json
  end
end
