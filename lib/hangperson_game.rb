class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess (character)
    if character == nil
      raise ArgumentError.new("No nil.")
    elsif character.length == 0
      raise ArgumentError.new("No empty character.")
    elsif character !~ /[[:alpha:]]/
      raise ArgumentError.new("No special characters.")
    end
    
    character = character.downcase
    
    if @word.include? character
      if @guesses.include? character
        return false
      else 
        @guesses += character
        return true
      end
    else
      if @wrong_guesses.include? character
        return false
      else
        @wrong_guesses += character
        return true
      end
    end
  end

def word_with_guesses
  output =''
  @word.split("").each do |char|
    if @guesses.include? char
      output += char
    else
      output += '-'
    end
  end
  return output
end  

def check_win_or_lose
  if @wrong_guesses.length >= 7
    return :lose
  end
  @word.split("").each do |char|
    if !@guesses.include? char
      return :play
    end
  end
  return :win
end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
