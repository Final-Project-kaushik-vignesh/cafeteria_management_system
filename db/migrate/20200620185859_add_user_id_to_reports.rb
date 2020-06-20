class AddUserIdToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :user_id, :integer
  end
end
