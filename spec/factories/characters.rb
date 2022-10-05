FactoryBot.define do
  factory :random_character, class: Character do
    name {Faker::Name.name}
    age {Faker::Number.between(from: 0, to: 100)}
    weight {Faker::Number.between(from: 0.0, to: 1000.0)}
    history {Faker::Lorem.sentence(word_count: 60)}
    image {Faker::Avatar.image}
    productions {[Production.first]}
  end
end