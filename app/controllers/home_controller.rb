class HomeController < ApplicationController
  def dashboard
    @user = current_user
    @exchanges = Exchange.where(user1_id: current_user.id)
    if current_user 
      render :dashboard
    else
      redirect_to '/books'
    end
  end
end
