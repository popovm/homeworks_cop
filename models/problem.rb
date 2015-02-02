class Problem < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :solutions

  def teacher_solution
    self.solutions.where(author_id: self.author_id).first
  end
end