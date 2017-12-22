require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "validate name presence" do
    assert_not Store.new({
      owner_id: Owner.first.id,
    }).save
  end

  test "validate owner_id presence" do
    assert_not Store.new({
      name: 'MyName'
    }).save
  end
end
