# frozen_string_literal: true

class RepoStatsController < ApplicationController
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

    RestClient.get('https://api.github.com/repos/facebook/react', headers={Authorization: "token #{Application.secrets.github_api_token}"})

  end
end
