class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet[rand(0..25)] }
  end

  def score
    params[:attempt]
    raise
  end
end
