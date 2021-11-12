class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*\d)[a-z\d]{8,}+\z/.freeze
  validates :name, presence: true, length: { in: 1..10 }
  validates :description, presence: true
  validates :image_name, presence: true
  validates :email, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX, message: "を○○@○○.○○の形式で入力して下さい" },
                    length: { maximum: 255 }
  mount_uploader :image_name, ImageUploader
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
end
