class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /exchanges or /exchanges.json
  def index
    @selected_status = 'All'
    if params[:status].present? && params[:status] != 'All'
      @selected_status = params[:status]
      @exchanges = Exchange.where(status: params[:status]).page(params[:page]).per(10)
    else
      @exchanges = Exchange.page(params[:page]).per(10)
    end
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
  end

  def rejected
    @exchange = Exchange.where(status: '2')
  end

  # POST /exchanges or /exchanges.json
  def create
    @user1 = User.find_by(id: params[:exchange][:user1_id])
    @user2 = User.find_by(id: params[:exchange][:user2_id])
    @book1 = Book.find_by(id: params[:exchange][:book1_id], user_id: @user1.id)
    @book2 = Book.find_by(id: params[:exchange][:book2_id], user_id: @user2.id)
    @exchange = Exchange.new(exchange_params)
  

    if @exchange.save
      redirect_to @exchange, notice: 'Exchange was successfully created.'
      from = SendGrid::Email.new(email: 'javiera_56@hotmail.com') 
      to = SendGrid::Email.new(email: @exchange.user2.email)
      subject = 'New exchange request'
      content = SendGrid::Content.new(type: 'text/plain', value: 'Hi! You have a new exchange request. Please check the app for more details. Thanks!')
      mail = SendGrid::Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: Rails.application.credentials.dig(:sendgrid, :sendgrid_api_key))
      response = sg.client.mail._('send').post(request_body: mail.to_json)

      if response.status_code == 202
        puts 'Email sent successfully!'
      else
        puts 'There was an error sending the email!'
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
      params.require(:exchange).permit(:user1_id, :user2_id, :book1_id, :book2_id, :status)
    end
end
