# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create users
5.times do
    User.create(
            name: Faker::Name.first_name, 
            last_name: Faker::Name.last_name,
            phone_number: rand(1000000000..9999999999),
            email: Faker::Internet.email,
            password: '123456',
            password_confirmation: '123456')
end

# Create 
100.times do
    Book.create(
            title: Faker::Book.title,
            author: Faker::Book.author,
            description: Faker::Lorem.paragraph(sentence_count: 12),
            genre: Faker::Book.genre,
            publisher: Faker::Book.publisher,
            year: rand(1900..2020),
            isbn: Faker::Code.isbn,
            state: rand(0..1),
            user_id: [1,2,3,4,5].sample
            )
end

# Create exchanges
10.times do
    Exchange.create(
            book1_id: rand(1..100),
            book2_id: rand(1..100),
            user1_id: rand(1..5),
            user2_id: rand(1..5),
            status: rand(0..2)
            )
end

# Create reviews
263.times do
    Review.create(
            book_id: rand(1..100),
            user_id: [1,2,3,4,5].sample,
            comment: Faker::Lorem.paragraph(sentence_count: 4),
            rating: rand(1..5)
            )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?