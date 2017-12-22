require 'test_helper'

class SellerTest < ActiveSupport::TestCase
  test "validate name presence" do
    assert_not Seller.new({
      owner_id: Owner.first.id,
      registration: '12332'
    }).save
  end

  test "validate registration presence" do
    assert_not Seller.new({
      owner_id: Owner.first.id,
      name: 'MyName'
    }).save
  end

  test "validate owner_id presence" do
    assert_not Seller.new({
      name: 'MyName',
      registration: '12332'
    }).save
  end

  test "validate registration uniqueness" do
    assert_not Seller.new({
      name: 'MyName',
      owner_id: Owner.first.id,
      registration: '12345'
    }).save
  end

  test "validate registration numericality" do
    assert_not Seller.new({
      name: 'MyName',
      owner_id: Owner.first.id,
      registration: 'B12332'
    }).save
  end
end