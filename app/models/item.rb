class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :delivery
  belongs_to_active_hash :estimated_shipping_date
  belongs_to_active_hash :state
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :category
  belongs_to :user, optional: true
  has_many :comments
  has_many :goods
  validates :name, :price, :text, :prefecture_id, :delivery_id, :state_id, :estimated_shipping_date_id, presence: true
  validates :prefecture_id,:delivery_id,:delivery_id,:state_id,numericality:{greater_than_or_equal_to:1}

  #belongs_to :category
  belongs_to :saler, optional: true, class_name: "User"
  belongs_to :buyer, optional: true, class_name: "User"
  has_many :thumbnails, dependent: :destroy
  accepts_nested_attributes_for :thumbnails, allow_destroy: true
end