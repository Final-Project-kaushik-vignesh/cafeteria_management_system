class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.date :start_date
      t.date :end_date
      t.float :total_sales
      t.integer :total_orders
    end
  end
end
