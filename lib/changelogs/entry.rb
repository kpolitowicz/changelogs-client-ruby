require 'json_api_client'

module Changelogs
  class Entry < JsonApiClient::Resource
    def self.site
      Changelogs.api_host
    end
  end
end
