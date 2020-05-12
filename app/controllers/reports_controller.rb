class ReportsController < ApplicationController
  skip_before_action :ensure_order_created

  def index
    render "index"
  end

  def create
    report = Report.create!(
      start_date: params[:start_date],
      end_date: params[:end_date],
      total_sales: Order.sort(params[:start_date].to_date, params[:end_date].to_date).sum(:total_price),
      total_orders: Order.sort(params[:start_date].to_date, params[:end_date].to_date).count,
    )
    @report = Order.sort(report.start_date.to_date, report.end_date.to_date).where.not(delivered_at: nil)
    redirect_to reports_path
  end

  def update
    report = Report.find_by(id: params[:id])
    report.update(
      start_date: params[:start_date],
      end_date: params[:end_date],
      total_sales: Order.sort(params[:start_date].to_date, params[:end_date].to_date).sum(:total_price),
      total_orders: Order.sort(params[:start_date].to_date, params[:end_date].to_date).count,
    )
    redirect_to reports_path
  end

  def destroy
    Report.destroy_all
  end
end
