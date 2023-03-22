FactoryBot.define do
  factory :species do
    name { Faker::Games::Pokemon.unique.name }
    dinosaur_type { "herbivore" }
  end
end
