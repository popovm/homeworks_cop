# encoding: UTF-8

class SolutionTest < ActiveRecord::Base
  belongs_to :solution
  belongs_to :test

  attr_accessible :result

  def outcome
    result == 1 ? 'верен' : 'грешен'
  end
end