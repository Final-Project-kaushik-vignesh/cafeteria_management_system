class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates_presence_of :first_name, message: "This field is compulsory: First name"
  validates_presence_of :email, message: "This field is compulsory: Email - Id"
  validates_uniqueness_of :email, message: "This email is already taken!"

  def owner?
    role == "owner"
  end

  def clerk?
    role == "clerk"
  end

  def customer?
    role == "customer"
  end

  def name_with_role
    "#{first_name}: #{role}"
  end
end
