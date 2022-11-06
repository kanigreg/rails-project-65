# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @attrs = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      image: fixture_file_upload('little_prince.jpg', 'image/jpg'),
      category_id: categories(:cars).id
    }
  end

  test 'index' do
    get bulletins_path

    assert_response :success
  end

  test 'show' do
    get bulletins_path(@bulletin)

    assert_response :success
  end

  test 'new' do
    sign_in users(:one)

    get new_bulletin_path(@bulletin)

    assert_response :success
  end

  test 'create' do
    sign_in users(:one)

    post bulletins_path, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by(@attrs.slice(:title, :description))

    assert bulletin.present?
    assert_redirected_to bulletin_path(bulletin)
  end

  test 'edit' do
    sign_in @bulletin.user

    get edit_bulletin_path(@bulletin)

    assert_response :success
  end

  test 'update' do
    sign_in @bulletin.user

    put bulletin_path(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert_equal @attrs[:title], @bulletin.title
    assert_equal @attrs[:description], @bulletin.description
    assert_redirected_to bulletin_path(@bulletin)
  end

  test 'should send bulletin for modarate' do
    bulletin = bulletins(:draft)
    sign_in bulletin.user

    patch to_moderate_bulletin_url(bulletin)

    bulletin.reload

    assert bulletin.under_moderation?
    assert_response :redirect
  end

  test 'should archive bulletin' do
    sign_in @bulletin.user

    patch archive_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.archived?
    assert_response :redirect
  end
end
