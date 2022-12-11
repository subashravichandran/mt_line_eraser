class MtLineEraser
  class << self
    def erase_in(file_name_with_path)
      return "Invalid File path" unless File.exists?(file_name_with_path) 
      original_file = File.open(file_name_with_path, 'r')
      clone_file    = File.open(file_name_with_path + '.clone', 'w')
      original_file.readlines.each do |line|
        clone_file.write(line) if line.gsub(/^[\s|\n]*/, '') != ''
      end
      [original_file, clone_file].map{|_file| _file.close}
      File.rename(clone_file, original_file)
      p "Removed all the empty lines from #{file_name_with_path}"
    end
  end
end
