FactoryGirl.define do
    factory :area do
      title { Faker::Name.name }
      created_by { Faker::Name.name }
    end
  end