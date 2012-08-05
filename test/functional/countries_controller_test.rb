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

  test "should create visits for only for countries that wasn't visited" do
    assert_difference('Visit.count', 2) do
      post :visit_all, :countries => ['CodeThree', 'CodeTwo', 'CodeOne']
    end

    assert_redirected_to countries_path
  end
end