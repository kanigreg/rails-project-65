# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    sign_in users(:admin)

    get admin_bulletins_path

    assert_response :success
  end
end
