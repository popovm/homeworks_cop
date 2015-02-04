class AddEndDateToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :end_date, :date
  end
end
