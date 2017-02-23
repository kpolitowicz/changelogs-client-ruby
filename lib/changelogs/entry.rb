require 'json_api_client'

module Changelogs
  class Entry < JsonApiClient::Resource
    self.site = 'https://changelogs.nimonikapp.com'
  end
end
