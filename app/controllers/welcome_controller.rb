class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user.registrateable
    else
      render 'index'
    end
  end
end
