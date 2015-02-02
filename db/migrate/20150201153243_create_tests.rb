class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :problem_id
      t.text :input
      t.text :output
      t.timestamps
    end
  end
end
