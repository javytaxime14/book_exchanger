require 'test_helper'

class ExchangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exchange = exchanges(:one)
  end

  test "should get index" do
    get exchanges_url
    assert_response :success
  end

  test "should get new" do
    get new_exchange_url
    assert_response :success
  end

  test "should create exchange" do
    assert_difference('Exchange.count') do
      post exchanges_url, params: { exchange: { book1_id: @exchange.book1_id, book2_id: @exchange.book2_id, user1_id: @exchange.user1_id, user2_id: @exchange.user2_id } }
    end

    assert_redirected_to exchange_url(Exchange.last)
  end

  test "should show exchange" do
    get exchange_url(@exchange)
    assert_response :success
  end

  test "should get edit" do
    get edit_exchange_url(@exchange)
    assert_response :success
  end

  test "should update exchange" do
    patch exchange_url(@exchange), params: { exchange: { book1_id: @exchange.book1_id, book2_id: @exchange.book2_id, user1_id: @exchange.user1_id, user2_id: @exchange.user2_id } }
    assert_redirected_to exchange_url(@exchange)
  end

  test "should destroy exchange" do
    assert_difference('Exchange.count', -1) do
      delete exchange_url(@exchange)
    end

    assert_redirected_to exchanges_url
  end
end
