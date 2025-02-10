class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :products
  has_many :purchases 
  has_many :purchased_products, through: :purchases, source: :product

  def purchased_products
    Product.with_deleted.joins(:purchases).where( purchases: {user_id: id})
  end

  def purchased?(product)
    purchased_products.include?(product)
  end
end
