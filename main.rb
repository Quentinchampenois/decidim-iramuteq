#!/usr/bin/env ruby

require 'csv'
require 'byebug'
require_relative 'decidim_iramuteq'
require_relative 'iramu_core'

dirname = if ARGV.empty?
            puts 'No filename provided, please enter file name : '
            gets.chomp
          else
            ARGV.first
          end

core = IramuCore.new(dirname)
entries = core.get_entries

entries.each do |file|
  # TODO: use errors and rescue

  relative_path = core.construct_relative_path(dirname, file)
  return puts "File '#{relative_path}' does not exist" unless File.exist? relative_path
  return puts "File '#{relative_path}' seems to be empty" if File.zero? relative_path
  if File.extname(relative_path) != '.csv'
    return puts "File '#{relative_path}' invalid extension"
  end

  iramuteq = DecidimIramuteq.new(relative_path, core.target_dir)

  CSV.foreach(relative_path, headers: :first_row, col_sep: ';') do |row|
    iramuteq.current_line = row.to_hash
    iramuteq.write_data!
  end
end

