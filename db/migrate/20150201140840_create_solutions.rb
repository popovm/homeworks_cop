class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :author_id
      t.integer :problem_id
      t.text    :text
      t.float   :grade
      t.timestamps
    end
  end
end
