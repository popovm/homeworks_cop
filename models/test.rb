require 'fileutils'

class Test < ActiveRecord::Base
  belongs_to :problem

  has_many :test_solutions

  attr_accessible :input, :output

  def verify(solution, file)
    input_filename = "temp/test_#{id}.txt"
    response_filename = "temp/response_#{id}.txt"
    File.open(input_filename, 'w+') { |f| f.write(self.input) }

    system("#{file} < #{input_filename} > #{response_filename}")

    file_output = File.read(response_filename)
    FileUtils.rm(response_filename)
    FileUtils.rm(input_filename)

    create_test_solution(solution, file_output)
    file_output == self.output
  end

  def create_test_solution(solution, file_output)
    test_solution = TestSolution.new

    if file_output == self.output
      test_solution.result = 1
    else
      test_solution.result = 0
    end

    test_solution.test_id = self.id
    test_solution.solution_id = solution.id

    test_solution.save!
  end
end
