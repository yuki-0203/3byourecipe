require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user,nickname:"old_name")
    @other_user = FactoryBot.create(:user)
  end

    describe "#show" do
      it "正常にレスポンスを返すこと" do
          get :show ,params: {id: @user.id}
          expect(response).to be_successful
      end
    end

    describe "#edit" do
        context "ログインユーザーの場合" do
          it "正常にレスポンスを返すこと" do
              sign_in @user
              get :edit ,params: {id: @user.id}
              expect(response).to be_successful
          end
        end

        context "ゲストユーザーの場合" do
          it "302レスポンスが返ってくること" do
              get :edit ,params: {id: @user.id}
              expect(response).to have_http_status "302"
          end
        end
    end

    describe "#profile" do
      context "ログインユーザーの場合" do
        it "正常にレスポンスを返すこと" do
            sign_in @user
            get :profile ,params: {id: @user.id}
            expect(response).to be_successful
        end
      end

      context "ゲストユーザーの場合" do
        it "302レスポンスが返ってくること" do
          get :profile ,params: {id: @user.id}
          expect(response).to have_http_status "302"
        end
      end
    end

    describe "#update" do
      let!(:user) { FactoryBot.create(:user) }
        context "認可されているユーザーの場合" do
          it "プロフィール情報を更新できること" do
              user_params = { nickname: "名無しさん" }
              sign_in @user
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to eq "名無しさん"
          end
          it "更新後、マイページへリダイレクトすること" do
              user_params = { nickname: "名無しさん" }
              sign_in @user
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to redirect_to "/users/#{@user.id}"
          end
        end

        context "認可されていないユーザーの場合" do
          it "プロフィール情報を更新できないこと" do
              user_params = { nickname: "名無しさん" }
              sign_in @other_user
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to eq "old_name"
          end
           it "ログインユーザーのマイページへリダイレクトすること" do
              user_params = { nickname: "名無しさん" }
              sign_in @other_user
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to redirect_to "/users/#{@other_user.id}"
          end
        end

        context "ゲストユーザーの場合" do
          it "プロフィール情報を更新できないこと" do
              user_params = { nickname: "名無しさん" }
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to eq "old_name"
          end
           it "新規登録画面へリダイレクトすること" do
              user_params = { nickname: "名無しさん" }
              patch :update, params: { id: @user.id, user: user_params }
              expect(@user.reload.nickname).to redirect_to new_user_session_path
          end
        end
    end
end
