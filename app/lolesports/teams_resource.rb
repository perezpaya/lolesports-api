class TeamsResource < Resource

  def url
    'http://api.lolesports.com/api/v1/teams'
  end

  def all_by_slug_and_tournament(slug, tournament)
    Enumerator.new do |e|
      teams_by_slug_and_tournament(slug, tournament).each do |v|
        e << v
      end
    end.lazy
  end

  def teams_by_slug_and_tournament(slug, tournament)
    response = RestClient.get url, params: {slug: slug, tournament: tournament}
    if json = JSON.parse(response.body)
      json["videos"]
    else
      []
    end
  end

end
