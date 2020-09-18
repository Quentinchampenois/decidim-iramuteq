class IramuCore

  UNWANTED_FILES = %w[. ..]
  attr_reader :target_dir

  def initialize(dirname, extension=".csv")
    @dirname = dirname
    @extension = extension
    @target_dir = "#{construct_dir_path(dirname)}results/"
  end

  def get_entries
    entries = Dir.entries(@dirname) - UNWANTED_FILES

    sanitize_files entries
  end

  def construct_dir_path(dirname)
    return "#{dirname}/" if dirname[-1, 1] != '/'

    dirname
  end

  def construct_relative_path(dirname, file)
    "#{construct_dir_path(dirname)}#{file}"
  end

  private

  def sanitize_files(entries)
    ary = []
    entries.each { |rep| ary << rep if rep.include?(@extension) }
    ary
  end
end
