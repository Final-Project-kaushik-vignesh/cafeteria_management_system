class MenuItem < ApplicationRecord
  belongs_to :menu
  validates_uniqueness_of :name, message: "Menu Item exists !"


  def self.of_menu(menu)
    all.where(menu_id: menu.id)
  end
end
