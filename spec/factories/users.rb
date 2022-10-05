FactoryBot.define do
  factory :user, class: 'User' do
    email {'test@test'}
    password {'123456'}
  end
end