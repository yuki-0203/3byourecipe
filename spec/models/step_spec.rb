require 'rails_helper'
RSpec.describe Step, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, user_id: user.id) }
    let!(:step) { create(:step, recipe_id: recipe.id) }

    # 正常系
    it 'recipe_id,explanationが存在すれば登録できること' do
      expect(step).to be_valid
    end

    # 異常系
    context '手順説明文が空白の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        step.explanation = ''
        step.valid?
        expect(step.errors[:explanation]).to include('を入力してください')
      end
    end

    context '料理名が50文字以上の場合' do
      it 'エラー文が表示され、投稿できないこと' do
        step.explanation = 'あ' * 51
        step.valid?
        expect(step.errors[:explanation]).to include('は50文字以内で入力してください')
      end
    end
  end
end
