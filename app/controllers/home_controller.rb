class HomeController < ApplicationController
  def dashboard
    @user = current_user
    @exchanges = Exchange.all

    if user_signed_in?
      render 'dashboard'
    else
      redirect_to '/books'
    end
  end

end
