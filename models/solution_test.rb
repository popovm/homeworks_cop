class SolutionTest < ActiveRecord::Base
  belongs_to :solution
  belongs_to :test

  attr_accessible :result
end