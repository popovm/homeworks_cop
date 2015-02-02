require 'FileUtils'

class Test < ActiveRecord::Base
  belongs_to :problem

  attr_accessible :input, :output

  def verify_test(file)
    filename = "temp/test_#{id}.txt"
    response_filename = "temp/response_#{id}.txt"
    File.open(filename, 'w+') { |f| f.write(input) }

    system("file < input > #{response_filename}")

    file_output = File.read(response_filename)
    FileUtils.rm(file_output)
    FileUtils.rm(response_filename)
    FileUtils.rm(filename)

    file_output == output
  end
end
<