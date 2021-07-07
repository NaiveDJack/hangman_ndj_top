# frozen_string_literal:true

require 'erb'
require 'yaml'

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
      load
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
    initialize
  end

  def load
    p 'checks the folder for saved games
    these are the saved games
    prompt to pick one of those'
    exit
  end

  def self.save
    p 'stores the information about the game in a file
    information are: secret word, masked password, wrong letters, lives
    encrypts it?
    prompts continue game/quit'
  end

  def quit
    puts 'Are you sure you want to quit? (y/n)'
    exit if gets.chomp.downcase == 'y'

    mode_choice
  end
end

hangman = Hangman.new
