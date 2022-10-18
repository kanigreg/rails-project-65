# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @attrs = {
      email: 'unique@email.uuu',
      name: Faker::Name.name
    }

    sign_in users(:admin)
  end

  test 'should get index' do
    get admin_users_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    patch admin_user_url(@user), params: { user: @attrs }
    @user.reload

    assert @user.email == @attrs[:email]
    assert @user.name = @attrs[:name]
    assert_redirected_to admin_users_url
  end
end
