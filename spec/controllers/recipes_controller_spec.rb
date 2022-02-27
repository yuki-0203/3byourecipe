require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
    describe "#index" do
        it "正常にレスポンスを返すこと" do
          get :index
          expect(response).to be_successful
      end
    end

    describe "#show" do
      before do
          @user = create(:user)
          @recipe = create(:recipe,user: @user)
      end
      it "正常にレスポンスを返すこと" do
          get :show ,params: {id: @recipe.id}
          expect(response).to be_successful
      end
    end

    describe "#new" do
      context "ログインユーザーの場合" do
        before do
          @user = create(:user)
        end
        it "正常にレスポンスを返すこと" do
            sign_in @user
            get :new
            expect(response).to be_successful
        end
      end

      context "ゲストユーザーの場合" do
          it "302レスポンスが返ってくること" do
              get :new
              expect(response).to have_http_status "302"
          end
           it "新規登録ページにリダイレクトされること" do
              get :new
              expect(response).to redirect_to new_user_session_path
          end
       end
    end

    describe "#edit" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:recipe) { FactoryBot.create(:recipe,user_id: user.id) }

        context "認可されているユーザーの場合" do
          it "正常にレスポンスを返すこと" do
              sign_in user
              get :edit ,params: {id: recipe.id}
              expect(response).to be_successful
          end
        end

        context "認可されていないユーザーの場合" do
          before do
            @other_user = create(:user)
          end
            it "302レスポンスが返ってくること" do
              sign_in @other_user
                get :edit ,params: {id: recipe.id}
                expect(response).to have_http_status "302"
            end
             it "レシピ詳細ページにリダイレクトされること" do
               sign_in @other_user
                get :edit ,params: {id: recipe.id}
                expect(response).to redirect_to recipe_path(recipe.id)
            end
         end

         context "ゲストユーザーの場合" do
            it "302レスポンスが返ってくること" do
                get :edit ,params: {id: recipe.id}
                expect(response).to have_http_status "302"
            end
             it "新規登録ページにリダイレクトされること" do
                get :edit ,params: {id: recipe.id}
                expect(response).to redirect_to new_user_session_path
            end
         end
    end

    describe "#create" do
      before do
        @user = FactoryBot.create(:user)
      end
        context "ログインユーザーの場合" do
          it "レシピを投稿できること" do
            pending ("保留")
              recipe_params = FactoryBot.attributes_for(:recipe)
              sign_in @user
              expect{
              post :create, params: { recipe: recipe_params }
              }.to change(@user.recipes,:count).by(1)
            end
          end
      end

    describe "#update" do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, user_id: user.id, name: "old_name") }
        context "認可されたユーザーの場合" do
          it "レシピを修正できること" do
            sign_in user
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(recipe.reload.name).to eq "new_name"
          end
          it "レシピ修正後、レシピ詳細ページへリダイレクトされること" do
            sign_in user
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(response).to redirect_to recipe_path(recipe.id)
          end
        end

        context "認可されていないユーザーの場合" do
          before do
            @other_user = create(:user)
          end
          it "レシピを修正できないこと" do
            sign_in @other_user
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(recipe.reload.name).to eq "old_name"
          end
          it "レシピ詳細ページへリダイレクトされること" do
            sign_in @other_user
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(response).to redirect_to recipe_path(recipe.id)
          end
        end

        context "ゲストユーザーの場合" do
          it "レシピを修正できないこと" do
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(recipe.reload.name).to eq "old_name"
          end
          it "新規登録画面へリダイレクトされること" do
            recipe_params = {name: "new_name" }
            patch :update, params: { recipe: recipe_params, id: recipe.id }
            expect(response).to redirect_to new_user_session_path
          end
        end
    end


    describe "#destroy" do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, user_id: user.id) }
        context "認可されたユーザーの場合" do
          it "レシピを削除できること" do
            sign_in user
            expect{
            patch :destroy, params: { id: recipe.id }
            }.to change(Recipe,:count).by(-1)
          end
          it "レシピ削除後、レシピ一覧ページへリダイレクトされること" do
            sign_in user
            patch :destroy, params: { id: recipe.id }
            expect(response).to redirect_to recipes_path
          end
        end

        context "認可されていないユーザーの場合" do
          before do
            @other_user = create(:user)
          end
          it "レシピを削除できず、302レスポンスが返ること" do
            sign_in @other_user
            patch :destroy, params: { id: recipe.id }
            expect(response).to have_http_status "302"
          end
          it "レシピ詳細ページへリダイレクトされること" do
            sign_in @other_user
            patch :destroy, params: { id: recipe.id }
            expect(response).to redirect_to recipe_path(recipe.id)
          end
        end

        context "ゲストユーザーの場合" do
          it "レシピを削除できず、302レスポンスが返ること" do
            patch :destroy, params: { id: recipe.id }
            expect(response).to have_http_status "302"
          end
          it "新規登録画面へリダイレクトされること" do
            patch :destroy, params: { id: recipe.id }
            expect(response).to redirect_to new_user_session_path
          end
        end
      end
end

