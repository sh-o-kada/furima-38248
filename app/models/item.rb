class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :take
  has_one_attached :image

  validates :name, :content, :image, presence: true
  validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :take_id, presence: true,
                                                                                        numericality: { other_than: 1, message: 'を選択してください' }
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'には300~9,999,999の半角数字で入力してください' }
  end
end
