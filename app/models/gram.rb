class Gram < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :message, presence: true

  belongs_to :user
  has_many :picture
end
