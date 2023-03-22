FactoryBot.define do
  factory :dinosaur do
    name { Faker::Movies::HowToTrainYourDragon.unique.dragon }
    species
    cage { nil }
  end
end
