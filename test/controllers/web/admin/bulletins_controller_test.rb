# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  test 'should get index' do
    get admin_bulletins_path

    assert_response :success
  end

  test 'should patch reject' do
    bulletin = bulletins(:under_moderation)

    patch reject_admin_bulletin_path(bulletin)

    bulletin.reload

    assert bulletin.rejected?
    assert_response :redirect
  end

  test 'should patch publish' do
    bulletin = bulletins(:under_moderation)

    patch publish_admin_bulletin_path(bulletin)

    bulletin.reload

    assert bulletin.published?
    assert_response :redirect
  end

  test 'should patch archive' do
    bulletin = bulletins(:draft)

    patch archive_admin_bulletin_path(bulletin)

    bulletin.reload

    assert bulletin.archived?
    assert_response :redirect
  end
end
