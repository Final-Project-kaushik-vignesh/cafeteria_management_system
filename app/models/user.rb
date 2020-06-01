class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates_presence_of :first_name, message: "This field is compulsory: First name"
  validates_presence_of :email, message: "This field is compulsory: Email - Id"
  def self.owner?
    role == "owner"
  end
  def self.clerk?
    role == "clerk"
  end
  def self.customer?
    role == "customer"
  end
end
