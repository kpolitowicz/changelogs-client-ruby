require 'faraday'

module Changelogs
  class API
    def self.post(attrs)
      conn = Faraday.new(url: Changelogs.api_host)
      resp = conn.post do |req|
        req.url '/entries'
        req.headers['Content-Type'] = 'application/json'
        req.body = attrs.to_json
      end

      resp.status < 400
    end
  end
end
