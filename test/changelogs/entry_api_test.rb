require 'test_helper'

module Changelogs
  class EntryApiTest < Minitest::Test
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

      stub_request(:post, "https://changelogs.nimonikapp.com/api/changelogs").
        to_return(status: 200, body: "", headers: {})

      change_api_host_to("https://changelogs.nimonikapp.com/api/changelogs")
    end

    def teardown
      change_api_host_to("https://changelogs.nimonikapp.com/api/changelogs")
    end

    def test_that_it_uses_default_api_host
      entry = Entry.create()

      assert_requested :post, "https://changelogs.nimonikapp.com/api/changelogs"
    end

    def test_that_it_uses_configurable_api_host
      change_api_host_to("https://changelogs.staging.nimonikapp.com/api/changelogs")
      stub_request(:post, "https://changelogs.staging.nimonikapp.com/api/changelogs").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_requested :post, "https://changelogs.staging.nimonikapp.com/api/changelogs"
    end

    def test_that_it_disables_logging_if_api_host_not_specified
      change_api_host_to(nil)
      stub_request(:post, //).to_return(status: 200, body: "", headers: {})

      entry = Entry.create()

      assert_not_requested :post, //
    end

    def test_that_it_creates_new_entry
      entry = Entry.create(@@valid_args)

      @@valid_args.each do |key, val|
        assert_equal entry.public_send(key), val, "Wrong entry.#{key}"
      end
    end

    def test_that_it_calls_api_to_create
      entry = Entry.create(@@valid_args)

      assert_requested :post, 
                       "https://changelogs.nimonikapp.com/api/changelogs",
                       body: '{"changelog":{"event":"C","changeset":"{}","account_id":123,"user_id":234,"user_type":"F","logged_type":"SomeModel","logged_id":345,"logged_at":"2001-02-03T04:05:06+00:00"}}'
    end

    def test_that_successful_save_returns_true
      entry = Entry.new(@valid_args)

      assert_same entry.save, true
    end

    def test_that_unsuccessful_save_returns_false
      stub_request(:post, "https://changelogs.nimonikapp.com/api/changelogs").
        to_return(status: 422, body: "", headers: {})

      entry = Entry.new()

      assert_same entry.save, false
    end

    private

      def change_api_host_to(api_host)
        Changelogs.api_host = api_host
      end
  end
end
