class CreateImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :impressions do |t|
       t.integer :recipe_id,null: false
       t.integer :user_id,null: false
          t.text :impression,null: false
          t.text :image_id
          t.text :reply_comment
      t.timestamps
    end
  end
end
