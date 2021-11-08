class Tweet < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :body, presence: true
end
