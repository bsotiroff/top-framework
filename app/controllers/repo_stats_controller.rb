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
end
