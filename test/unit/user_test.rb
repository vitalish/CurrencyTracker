require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "visit_country creates new visit" do
    user1 = users(:one)
    country3 = countries(:three)
    new_visit = nil

    assert_difference('Visit.count', 1) do
      new_visit = user1.visit_country(country3)
    end

    assert_equal new_visit, user1.visits.last
  end

  test "visit_country deletes visit" do
    user1 = users(:one)
    country2 = countries(:two)

    assert_difference('Visit.count', -1) do
      user1.unvisit_country(country2)
    end

    assert_equal user1.visits.where(:country_id => country2.code), []
  end
end
