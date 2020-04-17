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
end
