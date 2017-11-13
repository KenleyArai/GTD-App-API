FactoryGirl.define do
    factory :project do
      title { Faker::Lorem.word }
      created_by { Faker::Name.name }
    end
  end