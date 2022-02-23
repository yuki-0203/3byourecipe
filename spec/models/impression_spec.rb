require 'rails_helper'
describe Impression do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, user_id: user.id) }
    let!(:impression) { create(:impression, recipe_id: recipe.id, user_id: user.id) }

    # 正常系
    it 'recipe_id,user_id,impressionが存在すれば登録できること' do
      expect(impression).to be_valid
    end

    # 異常系
    context 'コメントが空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        impression.impression = ''
        impression.valid?
        expect(impression.errors[:impression]).to include('を入力してください')
      end
    end

    context 'コメント' do
      it 'エラー文が表示され、投稿できないこと' do
        impression.impression = 'あ' * 51
        impression.valid?
        expect(impression.errors[:impression]).to include('は50文字以内で入力してください')
      end
    end
  end
end
