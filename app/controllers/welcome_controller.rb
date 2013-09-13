class WelcomeController < ApplicationController
  def index
    @upcoming_shows = Show.next(10)
  end
end
