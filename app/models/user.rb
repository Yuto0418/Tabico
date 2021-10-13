class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*\d)[a-z\d]{8,}+\z/.freeze
  validates :name, presence: true, length: { in: 1..10 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "を○○@○○.○○の形式で入力して下さい" }, length: { maximum: 255 }
  validates :password, presence: true, length: { maximum: 75 }, format: { with: VALID_PASSWORD_REGEX, message: "を半角英数字8文字以上で入力して下さい" }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
