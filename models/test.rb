require 'fileutils'

class Test < ActiveRecord::Base
  belongs_to :problem

  has_many :solution_tests

  attr_accessible :input, :output

  def verify(solution, file, compilation_status)
    if compilation_status
      input_filename = "temp/test_#{id}.txt"
      response_filename = "temp/response_#{id}.txt"
      File.open(input_filename, 'w+') { |f| f.write(self.input) }

      if system("#{file} < #{input_filename} > #{response_filename}")
        file_output = File.read(response_filename)
        FileUtils.rm(response_filename)
        FileUtils.rm(input_filename)

        create_solution_test(solution, file_output)
        file_output == self.output
      else
        create_solution_test(solution, "Runtime error")
        return false
      end
    else
      create_solution_test(solution, "Compilation Error")
      return false
    end
  end

  def create_solution_test(solution, file_output)
    solution_test = SolutionTest.where(test_id: self.id, solution_id: solution.id).first_or_initialize

    if file_output == self.output
      solution_test.result = 1
    else
      solution_test.result = 0
    end

    solution_test.received_output = file_output

    solution_test.save!
  end
end
