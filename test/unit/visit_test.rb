require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  test "should calculate date" do
    visit = visits(:one)
    assert_equal visit.date, visit.created_at.to_i * 1000
  end
end
