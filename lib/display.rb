# frozen_string_literal:true

# visual part of the game
module Display
  def self.start_screen
    title = File.read('lib/graphics/titlecard.txt')
    credits = 'by Daniele Latella(github.com/naivedjack)
             Stickman art by Joan G. Stark @ asciiart.eu'
    puts 'Welcome to'
    puts title, credits, '', '1. New Game / 2. Load/Delete Game / 3. Game rules / Press q to quit'
  end

  def self.rules
    puts 'Hangman is a game where you guess a word or you die!', ''
    puts '1. New Game / 2. Load/Delete Game / 3. Game rules'
  end

  # loads the ascii of the gallows
  def self.gallows(lives)
    image = File.readlines('lib/graphics/gallows.txt')
    p lives
    puts image[lives * 10..lives * 10 + 8] if lives.between?(0, 7)
  end

  # main game display
  def self.guess_board(lives, wrong_letters, masked_password)
    gallows(lives)
    puts '', "the word is #{masked_password}", ''
    puts "Not included: #{wrong_letters}", ''
    puts 'Try a letter to get closer to the secret word. Or try and guess the word.'
    puts "Type 'save' to save the game. Type 'exit' to go back to main screen.", ''
  end

  # showed saved games stored in /saves
  def self.saved_games
    saves = Dir['./saves/*']
    puts 'Available saved games:'
    saves.each.with_index { |save, index| puts "#{index}. #{save[8..-5]}" }
    puts '', 'Enter load [savefile number] to load a game, or delete [savefile number] to delete it'
  end
end
