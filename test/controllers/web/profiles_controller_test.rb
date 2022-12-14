# frozen_string_literal: true

require 'test_helper'
class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    sign_in users(:one)

    get profile_path

    assert_response :success
  end

  test 'should redirect an unauthorized user' do
    get profile_path

    assert_response :redirect
  end
end
