class CreateSolutionTests < ActiveRecord::Migration
  def change
    create_table :solution_tests do |t|
      t.integer :solution_id
      t.integer :test_id
      t.integer :result
    end
  end
end
