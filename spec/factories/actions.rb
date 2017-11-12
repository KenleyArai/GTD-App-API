FactoryGirl.define do
    factory :action do
      title { Faker::StarWars.character }
      done false
      project_id nil
    end
  end