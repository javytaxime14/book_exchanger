class HomeController < ApplicationController

  def dashboard
    @user = current_user
    @exchanges = Exchange.all
    @listed_books = @user.listed_books.order(:title)

    if user_signed_in?
      render 'dashboard'
    else
      redirect_to '/home/home_page'
    end
  end

  def home_page
  end

end
