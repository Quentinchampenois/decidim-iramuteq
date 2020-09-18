#!/usr/bin/env ruby

require 'csv'

# Find data source
# Open data source
# Read it line by line
# Refactor with wanted format "iramuteq"



if ARGV.empty?
  puts "No filename provided, please enter file name : "
  file_name = "open_data.csv"
  #file_name = gets
else
  file_name = ARGV.first
end


puts "File '#{file_name}' does not exists" unless File.exist? file_name
puts "File '#{file_name}' seems to be empty" if File.zero? file_name
data = File.read file_name

CSV.parse(data, col_sep: ";") do |line|
  puts line
end


puts '> EOF'
