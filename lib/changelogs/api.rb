require 'faraday'

module Changelogs
  class API
    def self.post(attrs)
      return if inactive?

      conn = Faraday.new(url: Changelogs.api_host)
      resp = conn.post do |req|
        req.url '/api/changelogs'
        req.headers['Content-Type'] = 'application/json'
        req.body = attrs.to_json
      end

      resp.status < 400
    end

    private

      def self.inactive?
        Changelogs.api_host.nil?
      end
  end
end
