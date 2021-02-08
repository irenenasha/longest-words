require "open-uri"

class GamesController < ApplicationController
  def new
    # array of 10 random letters
    @letters = ("A"..."Z").to_a.sample(10)
  end

  def score
    # be an english word
    # 1. get letters from params
    @letters = params[:letters].split(' ')
    # 2. get word from params
    @word = params[:word].upcase
    # 3. send word to api
    # a. check if it's found (found == true) == a word
    # 4. return the value of found from the api

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = open(url).read
    json = JSON.parse(response)
    @found = json['found']

    # should be built from the letters given (no duplication)
    # 1. check each of the letters in the word against the grid through an iteration
    @grid_safe = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter)}
  end
end
