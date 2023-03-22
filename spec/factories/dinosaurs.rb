FactoryBot.define do
  factory :dinosaur do
    name { Faker::Movies::HowToTrainYourDragon.unique.dragon }
    species
    cage { nil }
  end

  trait :carnivore do
    species { build(:species, :carnivore) }
  end

  trait :herbivore do
    species { build(:species, :herbivore) }
  end
end
