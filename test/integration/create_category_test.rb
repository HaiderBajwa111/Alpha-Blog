require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "jhonedoe", email:"haider.bajwa.111@gmail.com", password: "password", admin: "true")
    sign_in_as(@admin_user)
  end
  test "get new category form and creting the new category" do
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 1 do 
      post categories_path, params: {category: {name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
  end

  test "get new category form and reject the invalid category submission" do
    get '/categories/new'
    assert_response :success
    assert_no_difference 'Category.count' do 
      post categories_path, params: {category: {name: " "} }
    end
    assert_match "Some Errors prevented your form to submit", response.body
  end


end
