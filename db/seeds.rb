# frozen_string_literal: true

ActiveRecord::Base.transaction do
  image_filenames = %w[little_prince.jpg rocket.jpg typewriter.jpg]

  u = User.create!(email: Faker::Internet.email, name: Faker::Name.name)

  5.times do
    Category.create!(name: Faker::Hobby.unique.activity)
  end

  categories = Category.all

  100.times do
    b = Bulletin.new(
      title: Faker::Restaurant.name,
      description: Faker::Restaurant.description.slice(..999),
      category: categories.sample,
      user: u,
      state: %i[published under_moderation].sample
    )
    filename = image_filenames.sample
    b.image.attach(
      io: File.open("test/fixtures/files/#{filename}"),
      filename: filename
    )
    b.save!
  end
end
