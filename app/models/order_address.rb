class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building, :phone, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "には半角数字3桁、ハイフン、半角数字4桁の順で入力してください"}
    validates :city
    validates :address
    validates :phone, format: {with: /\A\d{10}$|^\d{11}\z/, message: "には10桁or11桁の半角数字で入力してください"}
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone, order_id: order.id)
  end
end
