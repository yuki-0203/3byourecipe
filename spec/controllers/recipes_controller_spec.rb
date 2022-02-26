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




end
