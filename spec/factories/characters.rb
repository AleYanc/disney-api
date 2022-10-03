FactoryBot.define do
  factory :character do
    name {"Rayo McQueen"}
    age {30}
    weight {600.7}
    history {"Rayo McQueen, es un automóvil de carreras prosopopéyico protagonista de las películas producidas por Pixar: Cars, Cars 2 y Cars 3, así como en los cortos de televisión Cars Toons, creado por John Lasseter para la última producción de Pixar antes de entrar a formar parte de Disney."}
    image {'https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FRayo_McQueen&psig=AOvVaw1QYY6TWtw6UwH1HQaEHKj2&ust=1664401151612000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCJjM_Mz3tfoCFQAAAAAdAAAAABAD'}
    #productions {[Production.find(1)]}
  end

  factory :character2, class: Character do
    name {"Mate"}
    age {30}
    weight {700.99}
    history {"Etc etc loremipsum"}
    image {'https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FRayo_McQueen&psig=AOvVaw1QYY6TWtw6UwH1HQaEHKj2&ust=1664401151612000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCJjM_Mz3tfoCFQAAAAAdAAAAABAD'}
    #productions {[Production.find(1)]}
  end

  factory :random_character, class: Character do
    name {Faker::Name.unique.name}
    age {Faker::Number.between(from: 0, to: 100)}
    weight {Faker::Number.between(from: 0.0, to: 1000.0)}
    history {Faker::Lorem.sentence(word_count: 60)}
    image {Faker::Avatar.image}
    #productions {[Production.find(1)]}
  end
end