class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.clerk
    all.where(delivered_at: nil)
  end

  def role_of
    user = User.find(user_id)
    user.role
  end

  def self.delivered
    all.where.not(delivered_at: nil)
  end
  def self.not_delivered
    all.where(delivered_at: nil)
  end
end
