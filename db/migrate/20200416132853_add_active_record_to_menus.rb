class AddActiveRecordToMenus < ActiveRecord::Migration[6.0]
  def change
    add_column :menus, :Active_Menu, :boolean
  end
end
