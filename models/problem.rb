class Problem < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :solutions
  has_many :tests

  validates_presence_of :name

  def teacher_solution
    self.solutions.where(author_id: self.author_id).first
  end

  def difficulty
    if graded_solutions.empty?
      -1
    else
      graded_solutions.inject(0){|sum, s| sum + s.grade}/graded_solutions.length
    end
  end

  def graded_solutions
    @graded_solutions ||= self.solutions.where("grade is not null")
  end

  def popularity
    self.solutions.map(&:author).uniq.count
  end

  def rating_of_test(test)
    test.test_solutions.result.to_f / test.test_solutions.count
  end
end