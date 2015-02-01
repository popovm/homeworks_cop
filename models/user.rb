class User < ActiveRecord::Base
  has_secure_password

  has_many :problems, foreign_key: :author_id
  has_many :solutions, foreign_key: :author_id

  attr_accessible :password, :password_confirmation,
                  :email, :name

  validates_uniqueness_of :email, :faculty_number
end