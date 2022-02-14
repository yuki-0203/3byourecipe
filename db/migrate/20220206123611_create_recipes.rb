class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :serving, null: false
      t.text :note
      t.text :image_id, null: false
      t.timestamps
    end
  end
end
