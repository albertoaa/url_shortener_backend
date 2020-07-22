20.times do
  url = Faker::Internet.url
  shortened = Faker::TvShows::FamilyGuy.character

  Link.create( url: url, shortened: shortened)
end