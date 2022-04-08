class RecipePost
  include ActiveModel::Model

  
  validates :name, presence: true, length: { in: 1..40 }
  validates :introduction, presence: true, length: { in: 1..80 }
  validates :serving, presence: true, numericality: { less_than_or_equal_to: 5 }
  validates :image, presence: true
  validates :explanation, presence: true, length: { in: 1..50 }
  validates :quantity, presence: true, length: { in: 1..10 }
  
  attr_accessor :id, :name, :introduction, :note, :image, :image, :user_id, :tag_list, :serving, :steps_count, :tag_list,:recipe_id

    
  def save
    user = current_user
    recipe = Recipe.create(user_id: user.id,name: name, introduction: introduction, 
                           serving: serving,note: note,image: image,steps_count: steps_count,tag_list: tag_list)
    Material.create(recipe_id: recipe.id, name: name, quantity: quantity)
    Step.create(recipe_id: recipe.id, explanation: explanation)
  end
  

  
end