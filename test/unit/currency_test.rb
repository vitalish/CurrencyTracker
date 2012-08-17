require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test_validates_presence_of :name, :code

  test "for_user returns all currencies with visits for given user" do
    user1 = users(:one)
    user2 = users(:two)

    assert_equal Currency.count, Currency.for_user(user1).count
    assert_equal Currency.count, Currency.for_user(user2).count

    assert_equal nil, Currency.for_user(user1).find_by_code('CodeOne').visit_id
    assert_equal 1, Currency.for_user(user1).find_by_code('CodeTwo').visit_id

    assert_equal 2, Currency.for_user(user2).find_by_code('CodeOne').visit_id
    assert_equal nil, Currency.for_user(user2).find_by_code('CodeTwo').visit_id
  end

  test "collected? returns false when there is no visit" do
    user1 = users(:one)
    assert_equal false, Currency.for_user(user1).find_by_code('CodeOne').collected?
  end

  test "collected?returns true when there is visit" do
    user1 = users(:one)
    assert_equal true, Currency.for_user(user1).find_by_code('CodeTwo').collected?
  end

  test "collected? returns false when no user given" do
    assert_equal false, Currency.find_by_code('CodeTwo').collected?
  end
end
