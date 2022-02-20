require 'rails_helper'
  describe Impression do
    describe '#create' do
      #正常系
      #it "impression,user_id,recipe_idが存在すれば登録できること" do
       # user = FactoryBot.create(:user)
        #impression = build(:impression, user_id: user.id)
        #expect(impression).to be_valid
      #end

      #異常系
        it "impressionがない場合は登録できないこと" do
          impression = build(:impression,impression:nil)
          impression.valid?
          expect(impression.errors[:impression]).to include("を入力してください")
        end

  end
end
