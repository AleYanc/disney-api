FactoryBot.define do
  factory :genre do
    name {Faker::Book.genre}
    image {Faker::Avatar.image}
  end
end