require_relative '../constants/directory'
require 'fileutils'

def save_file(player)
  unless Dir.exist?(SAVE_DIRECTORY)
    FileUtils.mkdir_p(SAVE_DIRECTORY)
  end

  save_file_path = File.join(SAVE_DIRECTORY, player.name + "_" + create_file_name + ".txt")

  File.write(save_file_path, player.inspect)
end

def create_file_name
  Time.now.strftime("%Y%m%d-%H%M%S")
end