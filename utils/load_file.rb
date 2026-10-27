require_relative '../constants/directory'
require_relative '../utils/render'
require 'io/console'
require 'tty-reader'

def load_player

  render_typewriter_text(GREEN_TEXT + "Você me parece familiar... Me diga qual desses é você:" + RESET_TEXT, 0.03)

  sleep 0.5

  files_list = Dir.each_child(SAVE_DIRECTORY).to_a
  options_list = files_list + ["Não sou nenhum desses"]

  option = render_select_list(options_list, GREEN_TEXT + "Você me parece familiar... Me diga qual desses é você:" + RESET_TEXT)

  sleep 0.5

  selected_file = find_file_by_index(option)

  is_new_file = option == get_save_files_quantity

  sleep 0.5

  if is_new_file
    return nil
  end

  selected_file_path = (File.join(SAVE_DIRECTORY, selected_file))

  player = YAML.unsafe_load_file(selected_file_path)

  render_typewriter_text(GREEN_TEXT + "Ah sim... Bem-vindo de volta, " + player.name, 0.03)

  player
end

def get_save_files_quantity
  # o "- 2" é necessário para desconsiderar os diretórios "." e ".." na contagem de arquivos
  Dir.entries(SAVE_DIRECTORY).size - 2
end

def find_file_by_index(file_index)
  Dir.entries(SAVE_DIRECTORY)[file_index]
end
