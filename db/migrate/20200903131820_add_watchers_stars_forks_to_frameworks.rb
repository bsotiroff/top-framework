class AddWatchersStarsForksToFrameworks < ActiveRecord::Migration[6.0]
  def change
    add_column :frameworks, :watchers, :bigint
    add_column :frameworks, :stars, :bigint
    add_column :frameworks, :forks, :bigint
  end
end
