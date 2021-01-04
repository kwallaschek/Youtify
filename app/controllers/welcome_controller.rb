class WelcomeController < ApplicationController
  def index
    redirect_to '/tbd' if logged_in?
  end
end
