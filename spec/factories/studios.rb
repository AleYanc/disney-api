FactoryBot.define do
  factory :rand_studio do
    name {Faker::Name.unique}
    foundation_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    image {Faker::Avatar.image}
  end
end