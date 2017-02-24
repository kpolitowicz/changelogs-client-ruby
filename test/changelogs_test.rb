require 'test_helper'

class ChangelogsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Changelogs::VERSION
  end

  def test_that_api_subdomain_is_assignable
    Changelogs.subdomain = 'subdomain'

    assert_equal Changelogs.api_host, 'https://subdomain.nimonikapp.com/'
  end
end
