class MtLineEraser
  class << self
    def erase_in(file_or_dir_path)
      return "Invalid File path" unless File.exists?(file_or_dir_path)
      files_to_be_processed = File.file?(file_or_dir_path) ? file_or_dir_path
                                                           : Dir["#{file_or_dir_path}/**/*.*"]
      files_to_be_processed.each do |_file|
        erase_empty_lines_in_file(_file)
        p "Erased all the empty lines from #{_file}"
      end
      return nil
    end

    def erase_empty_lines_in_file(file_path)
      original_file = File.open(file_path, 'r')
      clone_file    = File.open(file_path + '.clone', 'w')
      original_file.readlines.each do |line|
        clone_file.write(line) if line.gsub(/^[\s|\n]*/, '') != ''
      end
      [original_file, clone_file].map{|_file| _file.close}
      File.rename(clone_file, original_file)
    end
  end
end
