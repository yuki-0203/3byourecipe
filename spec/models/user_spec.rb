require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    before do
      @user = FactoryBot.build(:user)
    end

    # 正常系
    it 'last_name,first_name,phone_number,is_gender,email,passwordが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    # 異常系
    context 'last_nameがない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include('を入力してください')
      end
    end

    context 'first_nameがない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include('を入力してください')
      end
    end

    context 'phone_numberがない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.phone_number = ''
        @user.valid?
        expect(@user.errors[:phone_number]).to include('を入力してください')
      end
    end

    context '重複したphone_numberが登録された場合' do
      it '登録できないこと' do
        duplicate_user = @user.dup
        @user.save
        duplicate_user.invalid?
      end
    end

    context 'emailがない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include('を入力してください')
      end
    end

    context '重複したemailが登録された場合' do
      it '登録できないこと' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        duplicate_user.invalid?
      end
    end

    context 'passwordがない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors[:password]).to include('を入力してください')
      end
    end

    context 'passwordとpassword（確認）が一致しない場合' do
      it 'エラー文が表示され、登録できないこと' do
        @user.password = 'password'
        @user.password_confirmation = 'password1'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to be_present
      end
    end

    context 'プロフィール文が51文字以上の場合' do
      it 'エラー文が表示され、登録できないこと' do
        user = build(:user, introduction: 'あ' * 51)
        user.valid?
        expect(user.errors[:introduction]).to include('は50文字以内で入力してください')
      end
    end
  end
end
