require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  should_not_respond_to_actions :new => :get,
                                :destroy => :get,
                                :create => :post,
                                :edit => :get,
                                :update => :put

  setup do
    @currency = currencies(:one)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should show currency" do
    get :show, :id => @currency.to_param
    assert_response :success
  end

  test "collect should create visit for collection" do
    assert_difference('Visit.count', 1) do
      post :collect, :id => @currency.to_param
    end

    assert_redirected_to currency_path(assigns(:currency))
    assert_equal 'Currency was successfully collected.', flash[:notice]
  end

  test "collect should not create visit for collection when already collected" do
    @currency = currencies(:two)
    assert_no_difference('Visit.count') do
      post :collect, :id => @currency.to_param
    end

    assert_redirected_to currency_path(assigns(:currency))
    assert_equal 'Currency has been already colleted.', flash[:notice]
  end

  test "delete_collection should delete visit for collection for visited countries" do
    @currency = currencies(:two)
    assert_difference('Visit.count', -1) do
      delete :delete_collection, :id => @currency.to_param
    end

    assert_redirected_to currency_path(assigns(:currency))
    assert_equal 'Currency collection was successfully deleted.', flash[:notice]
  end

  test "delete_collection should not delete visit for not collected currencies" do
    assert_no_difference('Visit.count') do
      delete :delete_collection, :id => @currency.to_param
    end

    assert_redirected_to currency_path(assigns(:currency))
    assert_equal 'Currency has not been collected yet.', flash[:notice]
  end

  test "collect_all should create visits only for currencies that wasn't collected when html" do
    assert_difference('Visit.count', 1) do
      post :collect_all, :currencies => ['CodeTwo', 'CodeOne']
    end

    assert_redirected_to countries_path
  end


  test "collect_all should create visits only for currencies that wasn't collected when json" do
    assert_difference('Visit.count', 1) do
      post :collect_all, :currencies => ['CodeTwo', 'CodeOne'], :format => :json
    end

    assert_response :success
    assert_equal [Visit.last].to_json(:methods => :date, :only => [:date]), @response.body
  end

  test "progress should get country visits progress" do
    get :progress
    collected = Currency.for_user(users(:one)).collected.order_by_visit_date
    assert_response :success
    assert_equal collected.to_json(:methods => :date, :only => [:date]), @response.body
  end
end