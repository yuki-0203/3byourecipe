class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
       t.integer :recipe_id,null: false
          t.text :explanation,null: false
          t.text :image_id
        t.timestamps
    end
  end
end
