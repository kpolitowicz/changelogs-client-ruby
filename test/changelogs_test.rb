require 'test_helper'

class ChangelogsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Changelogs::VERSION
  end

  def test_that_api_host_is_assignable
    Changelogs.api_host = 'http://example.com/'

    assert_equal Changelogs.api_host, 'http://example.com/'
  end
end
