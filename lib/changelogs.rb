require "changelogs/version"
require "changelogs/entry"

module Changelogs
  class << self
    attr_writer :subdomain

    def api_host
      subdomain = @subdomain || 'changelogs'
      "https://#{subdomain}.nimonikapp.com/"
    end
  end
end
