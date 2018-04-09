require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require_relative './http/http.rb'
require_relative './secrets.rb'

set :bind, '0.0.0.0'

namespace '/notify ' do
  post '/slack' do
    uri = secret [:slack_uri]
    icon = secret [:slack_icon]
    method = 'POST'
    'request submitted'
    body = Http.new.create_payload_slack('test','test_pi',icon)

    Http.new.post_req(method,uri,body)
  end
end
