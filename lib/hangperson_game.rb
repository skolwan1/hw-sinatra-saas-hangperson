class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess (character)
    
    raise(ArgumentError) if character.empty?
    raise(ArgumentError) if character.match(/[^A-za-z]/i)
    raise(ArgumentError) if character.nil?
    
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
  output_string =''
  @word.split("").each do |char|
    if @guesses.include? char
      output_string += char
    else
      output_string += '-'
    end
  end
  return output_string
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
