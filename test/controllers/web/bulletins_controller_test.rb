# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @attrs = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      category_id: categories(:cars).id
    }
  end

  test 'index' do
    get bulletins_path

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

    bulletin = Bulletin.find_by(@attrs)

    assert bulletin.present?
    assert_redirected_to bulletin_path(bulletin)
  end

  test 'edit' do
    sign_in @bulletin.creator

    get edit_bulletin_path(@bulletin)

    assert_response :success
  end

  test 'update' do
    sign_in @bulletin.creator

    put bulletin_path(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert @bulletin.title == @attrs[:title]
    assert @bulletin.description == @attrs[:description]
    assert_redirected_to bulletin_path(@bulletin)
  end
end
