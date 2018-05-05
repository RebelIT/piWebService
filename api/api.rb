require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require_relative '../common/http/http.rb'
require_relative '../common/secrets.rb'
require_relative './sinatra_ssl'

set :ssl_certificate, "cert.crt"
set :ssl_key, "pkey.pem"
set :port, 8089
set :bind, '0.0.0.0'

namespace '/api' do
  namespace '/notify/' do

    get do
      ["Notify Slack",
        "Notify email",
      ].join("\n") + "\n"
    end

    namespace '/slack' do

      get do
        ["Notify Slack",
          "Methods: POST",
          "Param: message, user, token",
          "Example:",
          "     {",
          "      \"token\" : \"xxxxxxxx\"",
          "      \"message\" : \"xxxxxxxx\"",
          "      \"user\" : \"xxxxxxxx\"",
          "      }"
        ].join("\n") + "\n"
      end

      post do
        input = JSON.parse(request.body.read)
        error 401 unless valid_token(input['token'])

        msg = input['message']
        user = input['user']
        uri = ENV['slack_uri']
        icon = ENV['slack_icon']
        method = 'POST'

        body = Http.new.create_payload_slack(msg,user,icon)
        logger.info "Processing Request"

        Http.new.post_req(method,uri,body)
      end
    end

    namespace '/email' do

      get do
        ["Notify email",
          "Methods: POST",
          "Param: email_message, email_title, email_body, token",
          "Example:",
          "     {",
          "      \"token\" : \"xxxxxxxx\"",
          "      \"email_message\" : \"xxxxxxxx\"",
          "      \"email_title\" : \"xxxxxxxx\"",
          "      \"email_body\" : \"xxxxxxxx\"",
          "      }"
        ].join("\n") + "\n"
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
