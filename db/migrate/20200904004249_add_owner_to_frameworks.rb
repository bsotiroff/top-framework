class AddOwnerToFrameworks < ActiveRecord::Migration[6.0]
  def change
    add_column :frameworks, :owner, :string
  end
end
