require 'json'
require 'open-uri'

# dsaghadksghfjkds
class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet[rand(0..25)] }
  end

  def score
    try = params[:attempt].downcase
    # raise
    letters = params[:letters].downcase

    @result = if letters_are_valid?(letters, try) && validate_word?(try)
                "Congratulations, #{try} is valid and is in the dictionary!"
              elsif letters_are_valid?(letters, try)
                "#{try} uses all the letters given to you but we couldn't find it in our dictionary."
              elsif validate_word?(try)
                "#{try} is in our dictionary but it contains letters not present in the original letters we gave you."
              else 'Not your best effort.'
              end
  end

  private

  def letters_are_valid?(letters, try)
    letters.chars.all? do |letter|
      try.count(letter) <= letters.count(letter)
    end
  end

  def validate_word?(try)
    url = "https://wagon-dictionary.herokuapp.com/#{try}"
    page = URI.open(url).read
    word = JSON.parse(page)
    word['found']
  end
end
