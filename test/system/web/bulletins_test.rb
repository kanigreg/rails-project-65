# frozen_string_literal: true

require 'application_system_test_case'

class Web::BulletinsTest < ApplicationSystemTestCase
  setup do
    @attrs = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph
    }

    sign_in users(:one)
  end

  test 'creating a Bulletin' do
    visit root_path
    click_on 'Add'

    fill_in 'Title', with: @attrs[:title]
    fill_in 'Description', with: @attrs[:description]
    select categories(:cars).name, from: 'Category'
    attach_file 'Image', 'test/fixtures/files/rocket.jpg'

    click_on 'Create Bulletin'

    assert_text 'Bulletin was successfully created'

    craeted_bulletin = Bulletin.last

    assert craeted_bulletin.title == @attrs[:title]
    assert craeted_bulletin.description == @attrs[:description]
    assert craeted_bulletin.image.attached?
  end

  test 'updating a Bulletin' do
    visit root_path

    click_on 'My bulletins'
    click_on 'Edit', match: :first

    fill_in 'Title', with: @attrs[:title]

    click_on 'Update Bulletin'

    assert_text 'Bulletin was successfully updated'

    updated_bulletin = Bulletin.order(:updated_at).last

    assert updated_bulletin.title = @attrs[:title]
  end

  test 'sending to moderate a Bulletin' do
    draft_bulletin = bulletins(:draft)
    visit profile_path

    within("[data-qa='bulletin-row-#{draft_bulletin.id}'") do
      click_on 'To moderate'
    end

    assert_text 'Bulletin has been sent to moderation'

    draft_bulletin.reload

    assert draft_bulletin.under_moderation?
  end

  test 'archiving a Bulletin' do
    draft_bulletin = bulletins(:draft)
    visit profile_path

    within("[data-qa='bulletin-row-#{draft_bulletin.id}'") do
      accept_confirm do
        click_on 'Archive'
      end
    end

    assert_text 'Bulletin was successfully archived'

    draft_bulletin.reload

    assert draft_bulletin.archived?
  end
end
