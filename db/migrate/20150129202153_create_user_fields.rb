class CrreateUserFields < ActiveRecord::Migration
  def change
    add_columm :users, :password_digest, :string
    add_columm :users, :email, :string
    add_columm :users, :name, :string
    add_columm :users, :faculty_number, :number
  end
end
