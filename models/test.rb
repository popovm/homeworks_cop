require 'fileutils'

class Test < ActiveRecord::Base
  belongs_to :problem

  attr_accessible :input, :output

  def verify(file)
    input_filename = "temp/test_#{id}.txt"
    response_filename = "temp/response_#{id}.txt"
    File.open(input_filename, 'w+') { |f| f.write(self.input) }

    system("#{file} < #{input_filename} > #{response_filename}")

    file_output = File.read(response_filename)
    FileUtils.rm(response_filename)
    FileUtils.rm(input_filename)

    file_output == self.output
  end
end
