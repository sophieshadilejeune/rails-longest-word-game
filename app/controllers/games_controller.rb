require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << (65 + rand(25)).chr }
  end

  def score
    # binding.pry
    game_array = params[:letters].chars.sort.join.strip.chars
    player_array = params[:word].upcase.chars
    check_array(player_array, game_array)
  end

  def check_array(player_array, game_array)
    player_array.map do |letter|
      if game_array.include?(letter)
        game_array.delete(letter)
        if check_word(params[:word])
          @result = "Congratulations #{params[:word]} is a real word"
        else
          @result = "Sorry #{params[:word]} is not a word part of dictionary"
        end
      else
        return @result = "Sorry, #{params[:word]} is not made of the original letters"
      end
    end
  end

  def check_word(word)
    dictionary_serialized = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    dictionary = JSON.parse(dictionary_serialized)
    return dictionary["found"];
  end


    # binding.pry
    # raise
end
