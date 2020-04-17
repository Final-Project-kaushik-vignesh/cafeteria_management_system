class OrdersController < ApplicationController
def create
    order = Order.create!(
        date: Date.today,
        user_id: current_user.id,
        delivered_at: nil,
    )



end
