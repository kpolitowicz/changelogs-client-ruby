require 'faraday'

module Changelogs
  class API
    def self.post(attrs)
      conn = Faraday.new(url: Changelogs.api_host)
      conn.post '/entries', attrs
    end
  end
end
