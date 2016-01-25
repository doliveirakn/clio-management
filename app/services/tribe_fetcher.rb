class TribeFetcher
  
  def users
    make_request("/users.json")
  end
  
  def user(id)
    make_request("/users/#{id}.json")
  end
  
  private
  def make_request(path)
    JSON.parse(RestClient.get("https://clio.mytribehr.com#{path}", headers))
  end

  
  def headers    
    {
      x_api_version: "2.0.0",
      authorization: "Basic #{Rails.application.secrets[:tribe_api_key]}"
    }
  end
  
end
