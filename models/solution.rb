class Solution < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :problem

  def name
    "#{problem.name}_#{author.name}"
  end

  def verify_solution
    src_filename  = "temp/#{name}.cpp"
    exec_filename = "temp/#{name}.exe"
    File.open(src_filename, 'w+') { |f| f.write(self.text) }

    system("g++ -o #{exec_filename} #{src_filename}")


    positive_test_count = problem.tests.select do |test|
      verify_test(exec_filename)
    end.length

    positive_test_count.to_f / problem.tests.count
  end
end