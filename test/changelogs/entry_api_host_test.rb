require 'test_helper'

module Changelogs
  class EntryApiHostTest < Minitest::Test
    @@valid_args = {
      event:       'C',
      changeset:   '{}',
      account_id:  123,
      user_id:     234,
      user_type:   'F',
      logged_type: 'SomeModel',
      logged_id:   345,
      logged_at:   DateTime.parse('2001-02-03 04:05:06 UTC'),
    }

    def setup
      WebMock.reset!

      stub_request(:post, "https://changelogs.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})
    end

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

    def test_that_it_creates_new_entry
      entry = Entry.create(@@valid_args)

      @@valid_args.each do |key, val|
        assert_equal entry.public_send(key), val, "Wrong entry.#{key}"
      end
    end

    def test_that_it_calls_api_to_create
      entry = Entry.create(@@valid_args)

      assert_requested :post, "https://changelogs.nimonikapp.com/entries" do |req|
        req = '{"event":"C","changeset":"{}","account_id":123,"user_id":234,"user_type":"F","logged_type":"SomeModel","logged_id":345,"logged_at":"2001-02-03T04:05:06+00:00"}'
      end
    end

    private

      def change_subdomain_to(subdomain)
        Changelogs.subdomain = subdomain
      end
  end
end
