require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if english_word?(@word)
      if @word.split('').all? { |letter| @letters.split.include?(letter) }
        @answer = "Congratulation! #{@word.upcase} is a valid english word!"
        @score = @word.length
      else
        @answer = "Sorry but #{@word.upcase} can't be built out of #{@letters.upcase}"
      end
    else
      @answer = "Sorry but #{@word.upcase} don't seem to be a valid english word..."
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
