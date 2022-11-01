# frozen_string_literal: true

require 'csv'

namespace :bulletins do
  desc 'Load bulletins to DB'
  task import: :environment do
    categories = Category.all
    author = User.first
    Bulletin.transaction do
      CSV.foreach('test/fixtures/files/data.csv', headers: true) do |row|
        b = Bulletin.new(
          title: row['title'],
          description: row['description'],
          user: author,
          category: categories.sample
        )
        b.image.attach(
          io: Rails.root.join("test/fixtures/files/#{row['image']}").open,
          filename: row['image']
        )
        b.save!
      end
    end
    puts 'Successfully loaded!'

  rescue StandardError => e
    puts "Importing failed: #{e.message}"
  end
end
