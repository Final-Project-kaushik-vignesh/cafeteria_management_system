class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.clerk
    all.where(delivered_at: nil)
  end
end
