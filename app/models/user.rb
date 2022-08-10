class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password ,format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "には半角英数両方を含めて設定してください(全角不可)" }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー－]+\z/, message: "には全角文字を使用してください" } do
    validates :last_name
    validates :first_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "には全角カタカナを使用してください" } do
    validates :last_name_spelling
    validates :first_name_spelling
  end
  validates :birthday, presence: true
end