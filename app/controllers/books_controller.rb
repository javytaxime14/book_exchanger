class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_current_book, only: [:list]

  # GET /books or /books.json
  def index
    @q = Book.page(params[:page]).per(5).ransack(params[:q])
    @books = @q.result

    if params[:q].blank?
      if signed_in? && current_user.friends.count > 0
        @books = Book.friends_books_index(current_user).order(created_at: :desc).page params[:page]
      else
        @books = Book.order(created_at: :desc).page params[:page]
      end
    end
  end

  def my_books
    @user = User.find(params[:user_id])
    @books = @user.books.page(params[:page]).per(9)
  end

  # GET /books/1 or /books/1.json
  def show
    if @book.reviews.empty?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  # GET /books/new
  def new
    @book = Book.new
    @book.id = params[:book_id]
  end

  def list
    if @book.is_listed?(current_user)
      @book.unlist(current_user)  
    else
      @book.list(current_user)
    end
    redirect_to books_path
  end
  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    respond_to do |format|
      if @book.save
        format.html { redirect_to root_path, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book = Book.find(params[:book_id])
    if @book.destroy
      redirect_to books_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_current_book
      @book = Book.find(params[:book_id])
    end
  

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :description, :genre, :publisher, :year, :isbn, :state)
    end
end
