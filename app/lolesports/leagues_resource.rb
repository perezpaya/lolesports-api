class LeaguesResource < Resource

  def url
    'http://api.lolesports.com/api/v1/leagues'
  end

  def all
    Enumerator.new do |e|
      leagues_list.each do |v|
        e << v
      end
    end.lazy
  end

  def leagues_list
    response = RestClient.get url
    if json = JSON.parse(response.body)
      json["leagues"]
    else
      []
    end
  end

  def league_by_slug(slug=nil)
    response = RestClient.get url, params: {slug: slug}
    begin
      json_body = JSON.parse(response.body)
      league_hash = {}
      league_hash[:league] = json_body["leagues"].first
      league_hash[:tournaments] = json_body["highlanderTournaments"]
      league_hash[:match_results] = json_body["highlanderRecords"]
      league_hash[:teams] = json_body["teams"]
      league_hash
    rescue
      raise 404, 'No league found for this slug'
    end
  end

end

# RestClient.get 'http://example.com/resource'
# RestClient.get 'http://example.com/resource', {:params => {:id => 50, 'foo' => 'bar'}}
# RestClient.get 'https://user:password@example.com/private/resource', {:accept => :json}
# RestClient.post 'http://example.com/resource', :param1 => 'one', :nested => { :param2 => 'two' }
# RestClient.post "http://example.com/resource", { 'x' => 1 }.to_json, :content_type => :json, :accept => :json
# RestClient.delete 'http://example.com/resource'