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
      stub_request(:post, "https://changelogs.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})
    end

    def test_that_it_creates_new_entry
      entry = Entry.create(@@valid_args)

      @@valid_args.each do |key, val|
        assert_equal entry.public_send(key), val, "Wrong entry.#{key}"
      end
    end

    def test_that_it_configurable_subdomain
      Changelogs.subdomain = 'changelogs.staging'
      stub_request(:post, "https://changelogs.staging.nimonikapp.com/entries").
        to_return(status: 200, body: "", headers: {})

      entry = Entry.create(@@valid_args)

      assert_requested :post, "https://changelogs.staging.nimonikapp.com/entries"
    end
  end
end
