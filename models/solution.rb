require 'fileutils'

class Solution < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :problem

  has_many :solution_tests

  def name
    "#{problem.name}_#{author.name}"
  end

  def result
    (self.percentage.to_f * 100).to_i
  end

  def verify
    unless problem.tests.empty?
      src_filename  = "temp/#{name}.cpp"
      exec_filename = "temp/#{name}.exe"
      File.open(src_filename, 'w+') { |f| f.write(self.text) }

      compilation_status = system("g++ -o #{exec_filename} #{src_filename}")

      positive_test_count = problem.tests.select do |test|
        test.verify(self, exec_filename, compilation_status)
      end.length

      if compilation_status
        FileUtils.rm exec_filename
        FileUtils.rm src_filename
      end

      self.percentage = positive_test_count.to_f / problem.tests.count
      self.save!
    end
  end

  def passed_tests
    test_solutions.select{ |t| t.result == 1}.count
  end

  def failed_tests
    test_solutions.select{ |t| t.result == 0}.count
  end
end