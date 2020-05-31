class ReportsController < ApplicationController
  skip_before_action :ensure_order_created

  def index
    render "index"
  end

  def create
    report = Report.new(
      start_date: params[:start_date],
      end_date: params[:end_date],
      total_sales: Order.sort(params[:start_date].to_date, params[:end_date].to_date).sum(:total_price),
      total_orders: Order.sort(params[:start_date].to_date, params[:end_date].to_date).count,
    )
    if report.valid?
      report.save
      redirect_to reports_path
    else
      redirect_to reports_path
      flash[:errors] = report.errors
    end
  end

  def update
    report = Report.find_by(id: params[:id])
    report.start_date = params[:start_date]
    report.end_date = params[:end_date]
    report.total_sales = Order.sort(params[:start_date].to_date, params[:end_date].to_date).sum(:total_price)
    report.total_orders = Order.sort(params[:start_date].to_date, params[:end_date].to_date).count
    if report.valid?
      report.save
      redirect_to reports_path
    else
      redirect_to reports_path
      flash[:errors] = report.errors
    end
  end

  def destroy
    Report.destroy_all
    redirect_to reports_path
  end

  def view
    @id = params[:id]
    order = Order.all.where(user_id: @current_user.id).find_by(id: @id)
    if order == nil && @current_user.role == "customer"
      redirect_to reports_path
    else
      @order_items = OrderItem.all.where(order_id: @id)
      render "report-invoice"
    end
  end
end