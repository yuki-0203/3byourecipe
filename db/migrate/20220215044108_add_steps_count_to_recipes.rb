class AddStepsCountToRecipes < ActiveRecord::Migration[5.2]
  def self.up
    add_column :recipes, :steps_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :recipes, :steps_count
  end
end
