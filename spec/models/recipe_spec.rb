require 'rails_helper'
 RSpec.describe Recipe, type: :model do
   describe "バリデーションのテスト" do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, user_id: user.id)  }


    #正常系
    it "user_id,name,introduction,serving,image_id,steps_countが存在すれば登録できること" do
       expect(recipe).to be_valid
     end

    #異常系

    context '料理名が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.name = ""
        recipe.valid?
        expect(recipe.errors[:name]).to include("を入力してください")
      end
    end

    context '料理名が40文字以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.name = "あ"*41
        recipe.valid?
        expect(recipe.errors[:name]).to include("は40文字以内で入力してください")
      end
    end

    context '料理紹介文が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.introduction = ""
        recipe.valid?
        expect(recipe.errors[:introduction]).to include("を入力してください")
      end
    end

    context '料理紹介文が40文字以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.introduction = 'あ'*81
        recipe.valid?
        expect(recipe.errors[:introduction]).to include("は80文字以内で入力してください")
      end
    end

    context '人数が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.serving = ""
        recipe.valid?
        expect(recipe.errors[:serving]).to include("を入力してください")
      end
    end

    context '人数が５人分以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        recipe.serving = "6"
        recipe.valid?
        expect(recipe.errors[:serving]).to include("は5以下の値にしてください")
      end
    end

    context '料理画像が空白の場合' do
      it '投稿できないこと' do
        recipe.image_id = ""
        recipe.valid?
      end
    end
  end
end
