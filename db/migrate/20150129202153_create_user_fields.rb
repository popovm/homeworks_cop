class CreateUserFields < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :email, :string
    add_column :users, :faculty_number, :integer
  end
end
