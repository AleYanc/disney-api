FactoryBot.define do
  factory :studio do
    name {"Pixar"}
    foundation_date {'1996-02-03'}
    image {Faker::Avatar.image}
  end

  factory :rand_studio, class: Studio do
    name {Faker::Name.unique}
    foundation_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    image {Faker::Avatar.image}
  end
end