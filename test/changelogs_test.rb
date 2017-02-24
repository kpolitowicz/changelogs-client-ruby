require 'test_helper'

class ChangelogsTest < Minitest::Test
  def teardown
    Changelogs.subdomain = nil
  end

  def test_that_it_has_a_version_number
    refute_nil Changelogs::VERSION
  end

  def test_that_api_subdomain_is_assignable
    Changelogs.subdomain = 'subdomain'

    assert_equal Changelogs.api_host, 'https://subdomain.nimonikapp.com/'
  end

  def test_that_api_subdomain_has_default
    assert_equal Changelogs.api_host, 'https://changelogs.nimonikapp.com/'
  end
end
