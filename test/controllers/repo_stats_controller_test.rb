require 'test_helper'

class RepoStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repo_stats_index_url
    assert_response :success
  end

end
