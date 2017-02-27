require "changelogs/version"
require "changelogs/entry"
require "changelogs/api"

module Changelogs
  class << self
    attr_accessor :api_host
  end
end
