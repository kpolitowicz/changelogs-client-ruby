require 'test_helper'

module Changelogs
  class EntryApiHostTest < Minitest::Test
    def teardown
      change_subdomain_to(nil)
    end

    def test_that_it_uses_default_api_subdomain
      stub_request(:post, "https://changelogs.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_requested :post, "https://changelogs.nimonikapp.com/entries"
    end

    def test_that_it_uses_configurable_subdomain
      change_subdomain_to('changelogs.staging')
      stub_request(:post, "https://changelogs.staging.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_requested :post, "https://changelogs.staging.nimonikapp.com/entries"
    end

    private

      def change_subdomain_to(subdomain)
        Changelogs.subdomain = subdomain
        reload_json_resource_connection
      end

      # Needed because JsonApiClient::Resource caches the connection
      def reload_json_resource_connection
        Entry.connection(true)
      end
  end
end
