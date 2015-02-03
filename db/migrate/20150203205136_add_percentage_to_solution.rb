class AddPercentageToSolution < ActiveRecord::Migration
  def change
    add_column :solutions, :percentage, :float
  end
end
