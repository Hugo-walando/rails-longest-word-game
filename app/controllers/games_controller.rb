require "open-uri"

class GamesController < ApplicationController
  def new
    @numbers = ('A'..'Z').to_a.sample(10)
  end

  def score
    @guess = params[:text].upcase
    @numbers = params[:numbers]
    @result = @guess.chars.all? do |letter|
      @numbers.count(letter) >= @guess.chars.count(letter)
    end

    if @result == true
      if word_is_english?(@guess)
        @end = "You win!"
      else
        @end = "Sorry but #{@guess} is not an english word"
      end
    else
      @end = "Sorry but #{@guess} cant't be built out of #{@numbers}"
    end
  end

  def word_is_english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end
end
