class AddReceivedOutput < ActiveRecord::Migration
  def change
    add_column :solution_tests, :received_output, :text
  end
end
