FactoryBot.define do
  factory :rand_production, class: 'Production' do
    title {Faker::Name.unique.name}
    released_date {Faker::Date.between(from:'1940-01-01', to:'2022-01-01')}
    score {Faker::Number.between(from:1, to:5)}
    image {Faker::Avatar.image}
    genres {[Genre.first]}
  end
end