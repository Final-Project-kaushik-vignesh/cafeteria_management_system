class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates_presence_of :first_name, message: "This field is compulsory: First name"
  validates_presence_of :email, message: "This field is compulsory: Email - Id"
end
