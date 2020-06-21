class OrderItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in
  skip_before_action :ensure_order_created

  def index
    @order_items = OrderItem.all.where(order_id: current_order_id)
    render "index"
  end

  def create
    menu_item = MenuItem.find_by(id: params[:menu_item_id])
    order = Order.find_by(id: current_order_id)
    order_items = OrderItem.all.where(order_id: order.id)
    existing_order_count = order_items.all.where(menu_item_id: menu_item.id).count
    if existing_order_count == 0
      order_item = OrderItem.create!(
        order_id: current_order_id,
        menu_item_id: menu_item.id,
        menu_item_name: menu_item.name,
        menu_item_price: menu_item.price,
        quantity: params[:quantity],
        item_value: menu_item.price * params[:quantity].to_f,
      )
      flash[:notice] = "Order is placed in your cart"
    else
      existing_order_item = order_items.find_by(menu_item_id: menu_item.id)
      existing_order_quantity = existing_order_item.quantity
      new_order_quantity = existing_order_quantity + params[:quantity].to_f
      existing_order_item.update(quantity: new_order_quantity)
      existing_order_item.update(item_value: menu_item.price * new_order_quantity)
      flash[:notice] = "Order quantity has been updated in your cart"
    end
    total_price = order_items.sum(:item_value)
    order.update(total_price: total_price)
    redirect_to menu_items_path
  end

  def update
    id = params[:id]
    order_item = OrderItem.find_by(id: id)
    order_item.update(quantity: params[:quantity])
    order_item.update(item_value: order_item.menu_item.price * params[:quantity].to_f)
    order = Order.find_by(id: current_order_id)
    order_items = OrderItem.all.where(order_id: order.id)
    total_price = order_items.sum(:item_value)
    order.update(total_price: total_price)
    redirect_to order_items_path
  end

  def view
    @id = params[:id]
    order = Order.all.where(user_id: @current_user.id).find_by(id: @id)
    if order == nil && @current_user.role == "customer"
      redirect_to orders_path
    else
      @order_items = OrderItem.all.where(order_id: @id)
      respond_to do |format|
        format.html { render "invoice" }
        format.pdf do
          render :pdf => "Invoice-#{@id}.pdf",
                 :margin => { :top => 10, :bottom => 10, :left => 5, :right => 5 },
                 :template => "order_items/invoice-pdf.html.erb"
        end
      end
    end
  end

  def destroy
    id = params[:id]
    order_item = OrderItem.find(id)
    order_item.destroy
    order = Order.find_by(id: current_order_id)
    order_items = OrderItem.all.where(order_id: order.id)
    total_price = order_items.sum(:item_value)
    order.update(total_price: total_price)
    redirect_to order_items_path
  end
end
