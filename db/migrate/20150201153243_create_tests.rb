class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :problem_id
      t.text :input
      t.text :output
      t.timestamps
    end
  end
end
