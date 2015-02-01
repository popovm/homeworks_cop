class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :password, :password_confirmation,
                  :email, :name

  validates_uniqueness_of :email, :faculty_number
end