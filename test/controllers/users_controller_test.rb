require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
    post users_path, params: { user: { name: "Roni Abou Nassif",
    email: "abounassif@gmail.com",
    password: "password",
    password_confirmation: "password" } }
    end
    follow_redirect!
    # assert_template 'users/show'
    end
    
end
