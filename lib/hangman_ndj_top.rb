# frozen_string_literal:true

require 'yaml'
require 'time'

require_relative 'hangman_ndj_top/version'
require_relative 'display'
require_relative 'game'

# main class, calls all other methods
class Hangman
  include Display

  def initialize
    Display.start_screen
    mode_choice(gets.chomp)
  end

  def mode_choice(choice)
    case choice
    when '1'
      start
    when '2'
      Display.saved_games
      manage_saves
    when '3'
      Display.rules
      mode_choice(gets.chomp)
    when 'q'
      quit
    else
      mode_choice(gets.chomp)
    end
  end

  def start
    @game = Game.new
    @game.game_loop
    initialize
  end

  # loading and deleting saves
  def manage_saves(command = gets.chomp.downcase)
    saves = Dir['./saves/*']
    case command
    when /(load)(?= \d+)/
      puts 'loading game...', ''
      load(saves[command.scan(/\d+/).join('').to_i])
    when /(delete)(?= \d+)/
      puts 'deleting game...', ''
      delete(saves[command.scan(/\d+/).join('').to_i])
    else
      puts 'wrong input'
    end
  end

  def load(file)
    to_load = YAML.load_file(file)
    @game = Game.new(to_load[0], to_load[1])
    @game.guesses.each { |guess| @game.guess(guess, @game.password) }
    @game.game_loop
    initialize
  end

  def delete(file)
    File.delete(file)
    initialize
  end

  # saving method
  def self.save(game)
    filename = "./saves/#{Time.now}.txt"
    state = [game.password, game.guesses]
    File.open(filename, 'w+') do |file|
      file.write(YAML.dump(state))
    end
  end

  # quit the game
  def quit
    puts 'Are you sure you want to quit? (y/n)'
    exit if gets.chomp.downcase == 'y'

    mode_choice
  end
end

hangman = Hangman.new
