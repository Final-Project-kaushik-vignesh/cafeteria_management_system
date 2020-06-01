class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def self.no_items(order_id)
    all.find_by(order_id: order_id) == nil
  end
end
