require 'test_helper'

module Changelogs
  class EntryTest < Minitest::Test
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
      Changelogs.subdomain = nil
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
  end
end
