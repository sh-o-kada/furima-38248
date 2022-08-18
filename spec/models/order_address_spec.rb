require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe "商品購入" do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    end

    context "内容に問題がない場合" do
      it "全ての値が正しく入力されていれば保存できる" do
        expect(@order_address).to be_valid
      end
      it "buildingは空でも保存できる" do
        @order_address.building = ""
        expect(@order_address).to be_valid
      end
    end

    context "内容に問題がある場合" do
      it "post_codeが空だと保存できない" do
        @order_address.post_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it "post_codeが全角だと保存できない" do
        @order_address.post_code = "１２３-４５６７"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code には半角数字3桁、ハイフン、半角数字4桁の順で入力してください")
      end
      it "post_codeが3桁の半角数字-4桁の半角数字の形でないと保存できない" do
        @order_address.post_code = "1234-567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code には半角数字3桁、ハイフン、半角数字4桁の順で入力してください")
      end
      it "prefecture_idが空(未選択)だと保存できない" do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空だと保存できない" do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空だと保存できない" do
        @order_address.address = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it "phoneが空だと保存できない" do
        @order_address.phone = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it "phoneが10桁or11桁の半角数字じゃないと保存できない" do
        @order_address.phone = "123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone には10桁or11桁の半角数字で入力してください")
      end
      it "userが紐付けされていないと保存できない" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付けされていないと保存できない" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
