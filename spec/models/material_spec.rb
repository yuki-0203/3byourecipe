require 'rails_helper'
RSpec.describe Material, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, user_id: user.id) }
    let!(:material) { create(:material, recipe_id: recipe.id) }

    # 正常系
    it 'recipe_id,name,quantityが存在すれば登録できること' do
      expect(material).to be_valid
    end

    # 異常系
    context '材料名が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        material.name = ''
        material.valid?
        expect(material.errors[:name]).to include('を入力してください')
      end
    end

    context '材料名が20文字以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        material.name = 'あ' * 21
        material.valid?
        expect(material.errors[:name]).to include('は20文字以内で入力してください')
      end
    end

    context '量材料名が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        material.quantity = ''
        material.valid?
        expect(material.errors[:quantity]).to include('を入力してください')
      end
    end

    context '量が10文字以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        material.quantity = 'あ' * 11
        material.valid?
        expect(material.errors[:quantity]).to include('は10文字以内で入力してください')
      end
    end
  end
end
