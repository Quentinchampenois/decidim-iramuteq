#!/usr/bin/env ruby

require 'csv'
require_relative 'decidim_iramuteq'

file_name = if ARGV.empty?
              puts 'No filename provided, please enter file name : '
              gets.chomp
            else
              ARGV.first
            end

return puts "File '#{file_name}' does not exist" unless File.exist? file_name
return puts "File '#{file_name}' seems to be empty" if File.zero? file_name


iramuteq = DecidimIramuteq.new(file_name)

CSV.foreach(file_name, headers: :first_row, col_sep: ';') do |row|
  iramuteq.current_line = row.to_hash
  iramuteq.write_data!
end



