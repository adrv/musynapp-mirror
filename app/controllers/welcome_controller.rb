class WelcomeController < ApplicationController
  def index
    @upcoming_shows = Show.upcoming(10)
    @shows_by_genres = Show.genres_map(5)
  end
end
