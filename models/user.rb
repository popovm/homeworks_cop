class User < ActiveRecord::Base
  has_secure_password

  has_many :problems, foreign_key: :author_id
  has_many :solutions, foreign_key: :author_id

  attr_accessible :password, :password_confirmation,
                  :email, :name

  validates_uniqueness_of :email

  def student?
    self.role == "student"
  end

  def teacher?
    self.role == "teacher"
  end

  def most_difficult_problem
    problems.reject{|s| s.graded_solutions.empty?}.sort{ |a, b| a.difficulty <=> b.difficulty }.first
  end

  def easiest_problem
    problems.reject{|s| s.graded_solutions.empty?}.sort{ |a, b| a.difficulty <=> b.difficulty }.last
  end

  def most_popular_problem
    problems.sort{ |a, b| a.popularity <=> b.popularity }.last
  end

  def least_popular_problem
    problems.sort{ |a, b| a.popularity <=> b.popularity }.first
  end
end