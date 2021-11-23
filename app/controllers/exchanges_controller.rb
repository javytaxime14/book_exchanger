class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /exchanges or /exchanges.json
  def index
    @exchanges = Exchange.where(user1_id: current_user.id)
  end

  # GET /exchanges/1 or /exchanges/1.json
  def show
  end

  # GET /exchanges/new
  def new
    @exchange = Exchange.new
  end

  # GET /exchanges/1/edit
  def edit
  end

  def pending
    @exchanges = Exchange.where(status: '0')
  end

  def accepted
    @exchange = Exchange.where(status: '1')
    if @exchange.save
      @book.update(state: 'Traded')
    end
    redirect_to exchanges_path
  end

  def rejected
    @exchange = Exchange.where(status: '2')
  end

  # POST /exchanges or /exchanges.json
  def create
 
    @book = Book.find(params[:book_id])
    @book = Book.find(params[:book_id])

    @exchange = @book.exchange.new(user1_id: current_user.id, user2_id: @book2.user_id, book1_id: params[:book1_id], book2_id: params[:book2_id])
  


    respond_to do |format|
      if @exchange.save
        format.html { redirect_to @exchange, notice: "Exchange was successfully created." }
        format.json { render :show, status: :created, location: @exchange }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exchanges/1 or /exchanges/1.json
  def update
    respond_to do |format|
      if @exchange.update(exchange_params)
        format.html { redirect_to @exchange, notice: "Exchange was successfully updated." }
        format.json { render :show, status: :ok, location: @exchange }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1 or /exchanges/1.json
  def destroy
    @exchange.destroy
    respond_to do |format|
      format.html { redirect_to exchanges_url, notice: "Exchange was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exchange_params
      params.require(:exchange).permit(:user1_id, :user2_id, :book1_id, :book2_id)
    end
end
