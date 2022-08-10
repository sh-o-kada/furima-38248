class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :take
  has_one_attached :image

  validates :name, :content, :price, presence: true
  validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :take_id, numericality: { other_than: 1, message: "can't be blank" }
end
