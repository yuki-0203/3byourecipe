require 'rails_helper'
RSpec.describe User, type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, first_name: '') }

  describe 'サインインのテスト' do
    context 'パラメータが妥当な場合' do
      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'サインイン後のリダイレクト先がトップ画面である' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end
    end
  end
end
