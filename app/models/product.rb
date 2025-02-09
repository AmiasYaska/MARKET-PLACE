class Product < ApplicationRecord
  has_many_attached :images

  belongs_to :user

  has_many :purchases
  has_many :buyers, through: :purchases, source: :user

end
