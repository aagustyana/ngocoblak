class WelcomeController < ApplicationController
  def index
    redirect_to new_feed_path
  end  
  
end
