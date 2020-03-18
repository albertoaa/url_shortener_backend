FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    shortened { Faker::TvShows::FamilyGuy.character }
  end
end