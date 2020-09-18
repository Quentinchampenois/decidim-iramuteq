class DecidimIramuteq

  attr_accessor :data_source, :current_line

  def initialize(file_name, format=:CSV)
    @file_name = file_name
    @format = format
    @formatted_data = []
    @timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
    @basename = File.basename(@file_name, '.*')
  end

  def get_data
    return unless @format == :CSV

    @data_source = File.read @file_name
  end

  def store_data
    @formatted_data = @formatted_data << "*" * 4
    @formatted_data = @formatted_data << '\n'
    @formatted_data = @formatted_data << proposal_item[:body]
    @formatted_data = @formatted_data << '\n'
  end

  def write_data!
    selector = "*"*4
    File.open("#{@timestamp}_#{@basename}.txt", 'a') { |f|
      f << "#{selector}\n\n"
      f << proposal_item[:body]
      f << "\n\n"
    }
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
    row << add_key(separator, doubled_separator, :id)
    row << add_key(separator, doubled_separator, :title)
    row << add_key(separator, doubled_separator, :body)
    row << line_separator

    row.flatten.compact.join('')
  end

  def add_key(separator='*', doubled_separator=' ', sym_key)
    [doubled_separator, separator, proposal_item[sym_key]]
  end
end
