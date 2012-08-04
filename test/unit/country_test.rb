require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  test_validates_presence_of :name, :code

  test "for_user returns all countries with visits for given user" do
    user1 = users(:one)
    user2 = users(:two)

    assert_equal Country.count, Country.for_user(user1).count
    assert_equal Country.count, Country.for_user(user2).count

    assert_equal nil, Country.for_user(user1).find_by_code('CodeOne').visit_id
    assert_equal 1, Country.for_user(user1).find_by_code('CodeTwo').visit_id

    assert_equal 2, Country.for_user(user2).find_by_code('CodeOne').visit_id
    assert_equal nil, Country.for_user(user2).find_by_code('CodeTwo').visit_id
  end

  test "visited? returns false when there is no visit" do
    user1 = users(:one)
    assert_equal false, Country.for_user(user1).find_by_code('CodeOne').visited?
  end

  test "visited? returns true when there is visit" do
    user1 = users(:one)
    assert_equal true, Country.for_user(user1).find_by_code('CodeTwo').visited?
  end

  test "visited? returns false when no user given" do
    assert_equal false, Country.find_by_code('CodeTwo').visited?
  end
end