require 'test_helper'

class CountriesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  should_not_respond_to_actions :new => :get, :destroy => :get

  setup do
    @country = countries(:one)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should create country" do
    assert_difference('Country.count') do
      post :create, :country => { :name => 'NewCountry', :code => 'NewCode' }
    end

    assert_redirected_to country_path(assigns(:country))
  end

  test "should not create duplicate currency" do
    assert_no_difference('Currency.count') do
      post :create, :country => @country.attributes
    end

    assert !assigns[:country].errors[:code].empty?
  end

  test "should show country" do
    get :show, :id => @country.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @country.to_param
    assert_response :success
  end

  test "should update country" do
    put :update, :id => @country.to_param, :country => @country.attributes
    assert_redirected_to country_path(assigns(:country))
  end

  test "should create visit" do
    assert_difference('Visit.count', 1) do
      post :visit, :id => @country.to_param
    end

    assert_redirected_to country_path(assigns(:country))
    assert_equal 'Country was successfully visited.', flash[:notice]
  end

  test "should not create visit when already visited" do
    @country = countries(:two)
    assert_no_difference('Visit.count') do
      post :visit, :id => @country.to_param
    end

    assert_redirected_to country_path(assigns(:country))
    assert_equal 'Country has been already visited.', flash[:notice]
  end

  test "should create visits only for countries that wasn't visited when html" do
    assert_difference('Visit.count', 2) do
      post :visit_all, :countries => ['CodeThree', 'CodeTwo', 'CodeOne']
    end

    assert_redirected_to countries_path
  end

  test "should delete visit for visited countries" do
    @country = countries(:two)
    assert_difference('Visit.count', -1) do
      delete :unvisit, :id => @country.to_param
    end

    assert_redirected_to country_path(assigns(:country))
    assert_equal 'Country visit was successfully deleted.', flash[:notice]
  end

  test "should not delete visit for not visited countries" do
    @country = countries(:one)
    assert_no_difference('Visit.count') do
      delete :unvisit, :id => @country.to_param
    end

    assert_redirected_to country_path(assigns(:country))
    assert_equal 'Country has not been visited yet.', flash[:notice]
  end

  test "should create visits only for countries that wasn't visited when json" do
    assert_difference('Visit.count', 2) do
      post :visit_all, :countries => ['CodeThree', 'CodeTwo', 'CodeOne'], :format => :json
    end

    last_2_visits = Visit.last(2)
    assert_response :success
    assert_equal last_2_visits.to_json(:methods => :date, :only => [:date]), @response.body
  end

  test "should get country visits progress" do
    get :progress
    assert_response :success
    assert_equal users(:one).visits.to_json(:methods => :date, :only => [:date]), @response.body
  end
end