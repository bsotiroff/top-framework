# frozen_string_literal: true

class RepoStatsController < ApplicationController
  before_action :authorize_repo_stats
  def index
    vote_counts = {}
    Framework.all.each do |f|
      vote_counts[f.name] = f.vote_count
    end
    configs = { voteCounts: vote_counts }
    @configs = configs.to_json
    pp @configs
  end

  def vote(repo_name)
    framework = Framework.find_by(name: repo_name)

    framework.vote_count.increment!
  end

  def fetch_api_data
    # frameworks = Framework.all.select('owner', 'name')
    # pp frameworks
    # frameworks.each do |framework|
    #   response = RestClient.get("https://api.github.com/repos/#{framework.owner}/#{framework.name}")
    #                             # {
    #                             #   Authorization: "token #{Rails.application.secrets.github_api_token}"
    #                             # }
    #                           # )
    #   pp response.body
    # end
    response = RestClient.get('https://api.github.com/repos/facebook/react', headers = { Authorization: "token #{Rails.application.secrets.github_api_token}"})
    
    pp body = JSON.parse(response.body)
    pp body["forks_count"]        # forks
    pp body["stargazers_count"]   # stars
    pp body["subscribers_count"]  # watchers
    render json: body, status: :ok
  end

  def authorize_repo_stats
    authorize :repo_stats
  end
end
