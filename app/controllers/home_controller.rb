class HomeController < ApplicationController
  def dashboard
    @user = current_user
    @exchanges = Exchange.all
    if current_user 
      render :dashboard
    else
      redirect_to '/books'
    end
  end
end
