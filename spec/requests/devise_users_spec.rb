require 'rails_helper'
 describe User do
   describe '#create' do
    #正常系
     it "last_name,first_name,phone_number,is_gender,email,passwordが存在すれば登録できること"do
       user = build(:user)
       expect(user).to be_valid
      end

    #異常系
      it "last_nameがない場合は登録できないこと" do
      user = build(:user,last_name:nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
       end

      it "first_nameがない場合は登録できないこと" do
        user = build(:user,first_name:nil)
        user.valid?
        expect(user.errors[:first_name]).to include("を入力してください")
      end

       it "phone_numberがない場合は登録できないこと" do
        user = build(:user,phone_number:nil)
        user.valid?
        expect(user.errors[:phone_number]).to include("を入力してください")
      end

       it "is_genderがない場合は登録できないこと" do
        user = build(:user,is_gender:nil)
        user.valid?
        expect(user.errors[:is_gender]).to include("を入力してください")
      end

        it "emailがない場合は登録できないこと" do
        user = build(:user,email:nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

        it "passwordがない場合は登録できないこと" do
        user = build(:user,password:nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

  end
end
