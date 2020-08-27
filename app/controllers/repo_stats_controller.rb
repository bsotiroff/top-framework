class RepoStatsController < ApplicationController
  def index
    configs = {
      "message": "hello World"
    }
    @configs = configs.to_json
  end
end
