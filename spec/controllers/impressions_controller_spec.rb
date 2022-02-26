require 'rails_helper'

RSpec.describe ImpressionsController, type: :controller do

  before do
    @user = create(:user)
    @recipe = create(:recipe, user_id: @user.id)
    @impression_user = create(:user)
    @impression = create(:impression, user_id: @impression_user.id, recipe_id: @recipe.id)
    @other_user =  create(:user)
  end

    describe "#index" do
      it "正常にレスポンスを返すこと" do
          get :index ,params: {recipe_id: @recipe.id }
          expect(response).to be_successful
      end
    end


    describe "#create" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:recipe) { FactoryBot.create(:recipe,user_id: user.id) }
        context "認可されているユーザーの場合" do
          it "脱レポを投稿できること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              sign_in @impression_user
              expect{
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              }.to change(@recipe.impression,:count).by(1)
          end
           it "脱レポを投稿後、レシピ詳細ページへリダイレクトすること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              sign_in @impression_user
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              expect(response).to redirect_to recipe_path(@recipe.id)
          end
        end

        context "認可されていないユーザーの場合" do
          it "脱レポは投稿できない脱レポは投稿できず、302レスポンスが返ること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              sign_in @recipe.user
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              expect(response).to have_http_status "302"
          end
           it "レシピ詳細ページへリダイレクトすること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              sign_in @recipe.user
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              expect(response).to redirect_to recipe_path(@recipe.id)
          end
        end

        context "ゲストユーザーの場合" do
          it "脱レポは投稿できず、302レスポンスが返ること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              expect(response).to have_http_status "302"
          end
           it "新規登録画面へリダイレクトすること" do
              impression_params = FactoryBot.attributes_for(:impression ,user_id: @impression_user)
              post :create, params: {impression: impression_params,recipe_id: @recipe}
              expect(response).to redirect_to new_user_session_path
          end
        end
      end

    describe "#destroy" do
        context "認可されているユーザーの場合" do
          it "脱レポを削除できること" do
              sign_in @impression_user
              expect{
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
              }.to change(@recipe.impression,:count).by(-1)
          end
          it "脱レポを削除後、レシピ詳細ページへリダイレクトすること" do
              sign_in @impression_user
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
              expect(response).to redirect_to recipe_path(@recipe.id)
          end
        end

        context "認可されていないユーザーの場合" do
          it "脱レポは投稿できず、302レスポンスが返ること" do
              sign_in @other_user
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
             expect(response).to have_http_status "302"
          end
          it "レシピ詳細ページへリダイレクトすること" do
              sign_in @other_user
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
              expect(response).to redirect_to recipe_path(@recipe.id)
          end
        end

        context "ゲストユーザーの場合" do
          it "脱レポは投稿できず、302レスポンスが返ること" do
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
             expect(response).to have_http_status "302"
          end
          it "新規登録画面へリダイレクトすること" do
              delete :destroy, params: {id: @impression, recipe_id: @recipe}
              expect(response).to redirect_to new_user_session_path
          end
        end
    end
end
