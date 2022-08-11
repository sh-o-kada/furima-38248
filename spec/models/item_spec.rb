require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品新規登録" do
    context "商品新規登録できる時" do
      it "name, content, category, condition, delivery_charge, prefecture, take, priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context "商品新規登録できない時" do
      it "nameが空では登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "contentが空では登録できない" do
        @item.content = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it "imageが空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "category_idが空(未選択)では登録できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end
      it "condition_idが空(未選択)では登録できない" do
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end
      it "delivery_charge_idが空(未選択)では登録できない" do
        @item.delivery_charge_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge を選択してください")
      end
      it "take_idが空(未選択)では登録できない" do
        @item.take_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Take を選択してください")
      end
      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price には300~9,999,999の半角数字で入力してください")
      end
      it "priceが全角だと登録できない" do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price には300~9,999,999の半角数字で入力してください")
      end
      it "priceが300以下だと登録できない" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price には300~9,999,999の半角数字で入力してください")
      end
      it "priceが10,000,000以上だと登録できない" do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price には300~9,999,999の半角数字で入力してください")
      end
    end
  end
end