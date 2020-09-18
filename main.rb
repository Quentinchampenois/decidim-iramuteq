#!/usr/bin/env ruby

require 'csv'
require 'byebug'

# Find data source
# Open data source
# Read it line by line
# Refactor with wanted format "iramuteq"

class DecidimIramuteq

  attr_accessor :data_source, :current_line

  def initialize(file_name, format=:CSV)
    @file_name = file_name
    @format = format
    @formatted_data = []
  end

  def get_data
    return unless @format == :CSV

    @data_source = File.read @file_name
  end

  def store_data
    @formatted_data = @formatted_data << formated_item
  end

  def write_data!
    @formatted_data = @formatted_data.join('')
    timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
    base_name = File.basename(@file_name, '.*')
    File.write("#{timestamp}_#{base_name}.txt", @formatted_data, mode: 'a')
  end

  private

  def proposal_item
    {
      id: current_line[0],
      title: current_line[8],
      body: current_line[9]
    }
  end

  def formated_item(separator='*', doubled_separator=' ', line_separator='')
    line_beginning = separator * 4

    row = []

    row << line_beginning
    row + add_key(separator, doubled_separator, :id)
    row + add_key(separator, doubled_separator, :title)
    row + add_key(separator, doubled_separator, :body)
    row << line_separator

    row.join('')
  end

  def add_key(separator='*', doubled_separator=' ', sym_key)
    [doubled_separator, separator, proposal_item[sym_key]]
  end
end


file_name = if ARGV.empty?
              puts 'No filename provided, please enter file name : '
              'open_data.csv'
            else
              ARGV.first
            end


puts "File '#{file_name}' does not exists" unless File.exist? file_name
puts "File '#{file_name}' seems to be empty" if File.zero? file_name


iramuteq = DecidimIramuteq.new(file_name)

first_line = true

CSV.parse(iramuteq.get_data, col_sep: ';') do |line|
  first_line = false if first_line

  unless first_line
    iramuteq.current_line = line
    iramuteq.store_data
  end
end

iramuteq.write_data!


