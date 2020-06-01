class Menu < ApplicationRecord
  has_many :menu_items

  def self.active_menu?
    all.find_by(active_menu: true) != nil
  end
end
