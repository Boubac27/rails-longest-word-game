class GamesController < ApplicationController
  def new
    @letters = generate
  end

  def score
    answer = params[:word]
    gird = params[:letters]
    @message = play_game(answer, gird)
  end

  def play_game(answer, gird)
    if word_different_grid(answer, gird) == false
      "Sorry but #{answer} can't built out of #{gird.split('').join(',')}"
    elsif word_not_valid_english(answer) == false
      "Sorry but #{answer} does not seem to be a walid English word..."
    else
      "Confratulations! #{answer} is a valid English word!"
    end
  end

  def word_not_valid_english(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    response = open(url).read
    word = JSON.parse(response)
    word['found']
  end

  def word_different_grid(answer, grid)
    grid_array = grid.upcase.split('')
    letters = answer.upcase.split('')
    letters.all? { |letter| letters.count(letter) <= grid_array.count(letter) }
  end

  def generate
    grid = []
    10.times do
      grid << ('A'...'Z').to_a.sample
    end
      grid
  end
end
