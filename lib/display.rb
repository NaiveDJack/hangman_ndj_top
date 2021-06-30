# frozen_string_literal:true

# visual part of the game
module Display
  def self.start_screen
    title = File.read('lib/graphics/titlecard.txt')
    credits = 'by Daniele Latella(github.com/naivedjack)
             Stickman art by Joan G. Stark @ asciiart.eu'
    puts 'Welcome to'
    puts title, credits, '', '1. New Game / 2. Load Game / 3. Game rules'
  end

  def self.rules
    puts 'Hangman is a game where you guess a word or you die!', ''
    puts '1. New Game / 2. Load Game / 3. Game rules'
  end

  def self.gallows(lives)
    image = File.readlines('lib/graphics/gallows.txt')
    puts image[lives*10..lives*10 + 8] if lives == (0..7)
  end
end
