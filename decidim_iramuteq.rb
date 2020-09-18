class DecidimIramuteq

  attr_accessor :data_source, :current_line

  def initialize(file_name, target_dir, format=:CSV)
    @file_name = file_name
    @target_dir = target_dir
    @format = format
    @formatted_data = []
    @timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
    @basename = File.basename(@file_name, '.*')
    Dir.mkdir(@target_dir) unless File.exists?(@target_dir)
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
    File.open("#{@target_dir}#{@timestamp}_#{@basename}.txt", 'a') { |f|
      f << "#{selector}\n\n"
      f << proposal_item[:body]
      f << "\n\n"
    }
  end

  private

  def proposal_item
    {
        id: current_line["id"],
        title: current_line["title"],
        body: current_line["body"]
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
