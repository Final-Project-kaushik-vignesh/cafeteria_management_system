class Menu < ApplicationRecord
  has_many :menu_items
  validates_uniqueness_of :name, message: "Menu already exists !"

  def self.active_menu?
    all.find_by(active_menu: true) != nil
  end
end
