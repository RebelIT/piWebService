require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'webrick'
require_relative './actions.rb'
require_relative './secrets.rb'
require_relative './text.rb'
require_relative '../common/http/http.rb'

set :port, 8089
set :bind, '0.0.0.0'

namespace '/api' do
  namespace '/calendar/' do

    get do
      [200, {}, ["#{get_calendar}"]]
    end

    namespace '/action' do

      get do
        [200, {}, ["#{get_action}"]]
      end

      post do
        input = JSON.parse(request.body.read)
        error 401 unless valid_token(input['token'])

        action = input['action'].downcase

        case action
        when "reboot"
          logger.info "Processing Request for #{input['action']}"
          response = CalendarAction.new.reboot
          unless response.nil?
            [200, {}, ["#{response}"]]
          end

        when "shutdown"
          logger.info "Processing Request for #{input['action']}"
          response = CalendarAction.new.shutdown
          unless response.nil?
            [200, {}, ["#{response}"]]
          end

        when "update"
          logger.info "Processing Request for #{input['action']}"
          response = CalendarAction.new.update
          unless response.nil?
            [200, {}, ["#{response}"]]
          end

        else
          err = "invalid request, #{action} not available, accepts #{action_accept}"
          logger.error err
          notify_error(err)
          halt 400 , err

        end
      end
    end
  end
end

def valid_token (key)
  if key == ENV['key']
    logger.info "Token Validated"
  else
    err = "Token invalid throwing 401 \nRequest Details: \n#{request.inspect}"
    logger.error err
    raise err
  end
rescue
  notify_error(err)
  halt 401
end

def notify_error(message)
  user = 'piSinatraErrors'
  uri = ENV['slack_uri']
  icon = ENV['slack_icon']
  method = 'POST'

  body = Http.new.create_payload_slack(message,user,icon)
  logger.info "Sending Error Message: #{message}"

  Http.new.post_req(method,uri,body)
end
