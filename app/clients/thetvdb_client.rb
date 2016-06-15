class ThetvdbClient
  require 'rest-client'

  USERNAME = "bbseries" # needed to access the APi
  APIKEY = "2D3BF7A0C4D3E722" # needed to access the APi
  USERKEY = "1A12E142E54F6149"
  API_BASE_URL = "https://api.thetvdb.com" # base url of the API

  @@token = nil
  @@token_date = nil

  def self.token
    if @@token
      @@token
    else
      json_params = {'apikey' => APIKEY, 'username' => USERNAME, 'userkey' => USERKEY }.to_json
      response_string = RestClient.post API_BASE_URL + '/login', json_params, :content_type => :json, :accept => :json
      response = JSON.parse(response_string, :symbolize_names => true)
      if response[:token]
        @@token_date = Time.current
        @@token = response[:token]
      else
        @@token = nil
        "Non-authorized"
      end
    end
  end

  def refresh_token

  end

  def self.get(path, json_params)
    JSON.parse(RestClient.get API_BASE_URL + path, :content_type => :json, :accept => :json, :Authorization =>  'Bearer ' + token)
  end

  def self.search(series_name)
    response = get("/search/series?name="+series_name, {'name' => series_name}.to_json)
    puts "response class " + response.class.name
    TvdbParser.parse_series(response["data"])
    #response["data"]
  end

end
