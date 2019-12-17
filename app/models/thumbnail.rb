class Thumbnail < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploader :images, ImageUploader
  validates :images,  presence: :true
end