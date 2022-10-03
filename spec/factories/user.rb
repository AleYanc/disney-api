FactoryBot.define do
  factory :rand_user, class: User do
    email {Faker::Internet.email}
    password_digest {'123456'}
  end
end