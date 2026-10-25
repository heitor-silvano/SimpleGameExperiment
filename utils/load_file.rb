require_relative '../constants/directory'
require 'io/console'
require 'tty-reader'

def load_player

  render_typewriter_text(GREEN_TEXT + "Você me parece familiar... Me diga qual desses é você:", 0.03)

  list_files(0)

  sleep 0.5

  option = get_user_keystrokes

  selected_file = find_file_by_index(option)

  selected_file_path = (File.join(SAVE_DIRECTORY, selected_file))

  YAML.unsafe_load_file(selected_file_path)
end

def list_files(index)
  options = Dir.each_child(SAVE_DIRECTORY).to_a + ["Não sou nenhum desses"]

  options.each_with_index do |filename, file_index|
    puts file_index == index ? GREEN_BACKGROUND + BLACK_TEXT + filename + RESET_BACKGROUND + RESET_TEXT : filename
  end

end

def get_user_keystrokes
  index = 0
  list_size = get_save_files_quantity

  reader = TTY::Reader.new

  loop do
    char = reader.read_keypress

    case char
    when "\e[A"
      if index > 0
        index = index - 1
      end
    when "\e[B"
      if index < list_size
        index = index + 1
      end
    when "\r"
      return index
    else
      puts "else"
    end

    print "\e[2J"
    print "\e[H"
    list_files(index)
  end
end

def get_save_files_quantity
  # o "- 2" é necessário para desconsiderar os diretórios "." e ".." na contagem de arquivos
  Dir.entries(SAVE_DIRECTORY).size - 2
end

def find_file_by_index(file_index)
  Dir.entries(SAVE_DIRECTORY)[file_index]
end
