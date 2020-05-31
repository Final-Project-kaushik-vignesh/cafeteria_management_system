class InvoicePdf < Prawn::Document
    def initialize(order)
        super()
        font "Helvetica"
        @order = order
        @user = User.find_by(id: @order.user_id)
        order_id
        line_items
    end
    def order_id
        text "Order \##{@order.id}", size: 30 , style: :bold
        move_down 10
        text "User ID: #{@order.user_id}", size: 15 , style: :bold 
        move_up 10
        text "Customer Name: #{@user.role != "customer" ? "Walk-In Customer" : @user.first_name}", size: 15, style: :bold ,align: :right
        
    end
    def line_items
        move_down 20
         line_items_rows
    end
    def line_items_rows
       
    end

end