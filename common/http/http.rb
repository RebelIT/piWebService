require 'rest-client'
require 'json'

class Http
  def post_req(method,uri,json)
    
    RestClient::Request.execute(
      method: method,
      url: uri,
      payload: json
    )

  end

  def create_payload_slack(message,username,icon)
    body = {
        text: message,
        username: username,
        icon_url: icon
    }.to_json
    body
  end

end

#Http.new.send_req
