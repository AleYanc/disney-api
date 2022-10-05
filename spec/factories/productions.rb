FactoryBot.define do
  factory :production do
    title {"Toy Story"}
    released_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    score {4}
    image {Faker::Avatar.image}
  end

  factory :production2, class: 'Production' do
    title {"Cars"}
    released_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    score {4}
    image {Faker::Avatar.image}
  end

  factory :rand_production, class: 'Production' do
    title {Faker::Name.unique.name}
    released_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    score {Faker::Number.between(from:1, to:5)}
    image {Faker::Avatar.image}
  end
end