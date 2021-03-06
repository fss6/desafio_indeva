require 'test_helper'

class GoalTest < ActiveSupport::TestCase

  test "check end_date in interval" do
    goal = Goal.new({store_id: 1, start_date: '15/12/2017', end_date: '17/12/2017'})
    goal.check_interval
    assert_not goal.errors.empty?
  end

  test "check start_date in interval" do
    goal = Goal.new({store_id: 1, start_date: '20/12/2017', end_date: '21/12/2017'})
    goal.check_interval
    assert_not goal.errors.empty?
  end

  test "check both out of range" do
    goal = Goal.new({store_id: 1, start_date: '15/12/2017', end_date: '16/12/2017'})
    goal.check_interval
    assert goal.errors.empty?
  end

  test "check both in interval" do
    goal = Goal.new({store_id: 1, start_date: '12/12/2017', end_date: '12/12/2017'})
    goal.check_interval
    assert_not goal.errors.empty?
  end

  test "check both in interval other store" do
    goal = Goal.new({store_id: 2, start_date: '12/12/2017', end_date: '12/12/2017'})
    goal.check_interval
    assert goal.errors.empty?
  end

  test "check start_date in interval other store" do
    goal = Goal.new({store_id: 2, start_date: '18/12/2017', end_date: '21/12/2017'})
    goal.check_interval
    assert_not goal.errors.empty?
  end

end