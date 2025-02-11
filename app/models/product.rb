class Product < ApplicationRecord
  has_many_attached :images

  belongs_to :user

  has_many :purchases
  has_many :buyers, through: :purchases, source: :user

  scope :active, -> { where(deleted_at: nil)}
  scope :with_deleted, -> { unscope(where: :deleted_at)}

  def soft_delete
    update(deleted_at: Time.current)
  end

  def active?
    deleted_at.nil?
  end

  def self.search(query)
    where(
      "title ILIKE :query OR description ILIKE :query OR category ILIKE :query",
      query:"%#{sanitize_sql_like(query)}%"
    )
  end

end
