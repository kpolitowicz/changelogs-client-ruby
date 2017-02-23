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

      assert_equal entry.event, 'C'
    end
  end
end
