require 'test_helper'

module Changelogs
  class EntryApiHostTest < Minitest::Test
    def teardown
      Changelogs.subdomain = nil
    end

    def test_that_it_uses_default_api_subdomain
      Changelogs.subdomain = nil
      stub_request(:post, "https://changelogs.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_requested :post, "https://changelogs.nimonikapp.com/entries"
    end

    def test_that_it_uses_configurable_subdomain
      Changelogs.subdomain = 'changelogs.staging'
      stub_request(:post, "https://changelogs.staging.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_requested :post, "https://changelogs.staging.nimonikapp.com/entries"
    end
  end
end
