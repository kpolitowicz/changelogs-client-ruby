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

    def test_that_it_inits_new_entry
      entry = Entry.new(@@valid_args)

      @@valid_args.each do |key, val|
        assert_equal entry.public_send(key), val, "Wrong entry.#{key}"
      end
    end

    def test_that_it_creates_new_entry
      stub_request(:post, "https://changelogs.nimonikapp.com/entries").
          with(:body => "{\"data\":{\"type\":\"entries\",\"attributes\":{\"event\":\"C\",\"changeset\":\"{}\",\"account_id\":123,\"user_id\":234,\"user_type\":\"F\",\"logged_type\":\"SomeModel\",\"logged_id\":345,\"logged_at\":\"2001-02-03T04:05:06+00:00\"}}}",
                      :headers => {'Accept'=>'application/vnd.api+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/vnd.api+json', 'User-Agent'=>'Faraday v0.11.0'}).
        to_return(:status => 200, :body => "", :headers => {})

      entry = Entry.create(@@valid_args)

      @@valid_args.each do |key, val|
        assert_equal entry.public_send(key), val, "Wrong entry.#{key}"
      end
    end
  end
end
