# frozen_string_literal:true

require_relative 'display'

# game logic functions class
class Game
  include Display

  def initialize(password = word_picker, lives = 7, wrong_letters = [])
    @password = password
    @masked_password = mask_password(@password)
    @lives = lives
    @wrong_letters = wrong_letters
    game_loop
  end

  def game_loop
    until @lives.zero? || @masked_password.gsub(/\s+/, '') == @password
      Display.guess_board(@lives, @wrong_letters, @masked_password)
      break if guess(gets.chomp.downcase, @password) == 'exit'
    end
    game_over
  end

  def game_over
    if @lives.zero?
      puts "You lose! The word was #{@password}.", ''
    elsif @masked_password.gsub(/\s+/, '') == @password
      puts 'You got the right word!', ''
    end
    sleep 3
  end

  # setting and storing the secret word
  def word_picker
    dictionary = File.readlines('lib/5desk.txt')
    word = dictionary.sample(1)[0].chomp.downcase
    word = dictionary.sample(1)[0].chomp.downcase until word.length.between?(5, 12)
    word
  end

  def mask_password(password)
    @masked_index = {}
    @masked_password = password.gsub(/(.{1})/, '\1 ').strip!
    @masked_password.chars.each.with_index do |char, index|
      @masked_index[char] ? @masked_index[char] += [index] : @masked_index[char] = [index]
    end
    @masked_password.gsub!(/([a-z])/, '_')
  end

  # handling the guesses
  def guess(guess, password)
    case guess.length
    when 1
      input_validation(guess, password)
    when 4
      command(guess)
    when password.length
      password == guess ? right_word(password) : error
    else
      p 'wrong input'
    end
  end

  # avoid using the same letter twice
  # if you use the same word twice you deserve losing lives
  def input_validation(guess, password)
    if (@masked_password.include? guess) || (@wrong_letters.include? guess) # add only alphabet input?
      puts 'You already tried that one!', ''
    else
      guess_letter(guess, password) ? right_letter(guess) : wrong_letter(guess)
    end
  end

  def guess_letter(letter, password)
    password.include? letter
  end

  def right_letter(letter)
    @masked_index[letter].each { |index| @masked_password[index] = letter }
  end

  def wrong_letter(guess)
    @wrong_letters.push(guess)
    error
  end

  def right_word(password)
    password.each_char { |letter| right_letter(letter) }
  end

  def error
    @lives -= 1
    puts "You made a mistake! You're closer to the hanging...", '' unless @lives.zero?
  end

  def command(action)
    Hangman.save if action == 'save'
    puts '', 'Do you want to leave this game? (y/n)'
    'exit' if gets.chomp.downcase == 'y'
  end
end
