require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  # def setup
  #   @category = Category.new(name: "Sports")
  # end
  test "category should be valid" do
    @category = Category.new(name: "Sports")
    assert @category.valid?
  end

  test "name should be present" do 
    @category = Category.new(name: "Sports")
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do 
    @category = Category.new(name: "Sports")
    @category.save
    @category2 =Category.new(name: "Sports")
    assert_not @category2.valid?
  end

   test "name should not be too long" do 
    @category = Category.new(name: "Sportsad")
    @category.name = "a"*26
    assert_not @category.valid?
   end
   test "name should not be too small" do
    @category = Category.new(name: "Sportss")
    @category.name = "aa"
    assert_not @category.valid?
   end

end