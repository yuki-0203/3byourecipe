require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  let!(:user) { FactoryBot.create(:user) }
  let!(:recipe) { FactoryBot.create(:recipe,user_id: user.id) }
  let(:favorite) { create(:favorite, user_id: user.id, recipe_id: recipe.id) }

    describe "#create" do
        it "Ajexが反応すること" do
          post :create, format: :json,
          params: { recipe_id: recipe.id, id: favorite.id ,user_id: user.id }
          expect(response.content_type).to eq "application/json"
        end
        it "お気に入り登録ができること" do
          expect { post :create, format: :json, params: { recipe_id: recipe.id,user_id: user.id, id: favorite.id } }.to change(Favorite,:count ).by(1)
        end
    end

    describe "#destroy" do
      let!(:favorite) { create(:favorite, user_id: user.id, recipe_id: recipe.id) }
        before do
          sign_in user
        end
          it "Ajexが反応すること" do
            delete :destroy, format: :js, params: { recipe_id: recipe.id, user_id: user.id, id: favorite.id }
            expect(response.content_type).to eq 'text/javascript'
          end
          it "お気に入り解除ができること" do
            expect { delete :destroy, format: :js, params: { recipe_id: recipe.id, user_id: user.id, id: favorite.id } }.to change(Favorite, :count).by(-1)
          end
    end
end