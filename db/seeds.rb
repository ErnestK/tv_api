# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Rails.logger.debug 'Creating movies with content...'

movies_data = [
  {
    movie: { duration_in_seconds: 10_140 },
    content: { original_name: 'Interstellar', year: 2014 }
  },
  {
    movie: { duration_in_seconds: 8880 },
    content: { original_name: 'Inception', year: 2010 }
  },
  {
    movie: { duration_in_seconds: 8520 },
    content: { original_name: 'The Shawshank Redemption', year: 1994 }
  },
  {
    movie: { duration_in_seconds: 9120 },
    content: { original_name: 'The Dark Knight', year: 2008 }
  }
]

movies_data.each do |data|
  movie = Movie.create_with_content!(data[:movie], data[:content])
  Rails.logger.debug { "✓ Created movie: #{movie.content.original_name} (#{movie.content.year})" }
end

Rails.logger.debug { "Done! Created #{Movie.count} movies with content." }

# Creating TV Shows
Rails.logger.debug 'Creating TV shows with content...'

# Breaking Bad
breaking_bad = TvShow.create_with_content!(
  {},
  { original_name: 'Breaking Bad', year: 2008 }
)

# Season 1
season1 = TvShowsSeason.create_with_content!(
  { tv_show: breaking_bad, number: 1 },
  { original_name: 'Breaking Bad Season 1', year: 2008 }
)

# Episodes for Season 1
TvShowsSeasonsEpisode.create_with_content!(
  { tv_shows_season: season1, number: 1, duration_in_seconds: 3480 },
  { original_name: 'Pilot', year: 2008 }
)

TvShowsSeasonsEpisode.create_with_content!(
  { tv_shows_season: season1, number: 2, duration_in_seconds: 2880 },
  { original_name: 'Cat\'s in the Bag...', year: 2008 }
)

Rails.logger.debug do
  "Created TV show: #{breaking_bad.content.original_name} " \
    "with #{breaking_bad.tv_shows_seasons.count} seasons"
end

# Creating Channels and Programs
Rails.logger.debug 'Creating channels with programs...'

# HBO Channel
hbo = Channel.create_with_content!(
  {},
  { original_name: 'HBO' }
)

# Channel Programs for HBO
ChannelProgram.create_with_content!(
  {
    channel: hbo,
    time_range: Time.zone.parse('2024-01-01 20:00')..Time.zone.parse('2024-01-01 22:00')
  },
  { original_name: 'Game of Thrones Rerun' }
)

ChannelProgram.create_with_content!(
  {
    channel: hbo,
    time_range: Time.zone.parse('2024-01-01 22:00')..Time.zone.parse('2024-01-02 00:00')
  },
  { original_name: 'The Last of Us' }
)

# Netflix Channel
netflix = Channel.create_with_content!(
  {},
  { original_name: 'Netflix' }
)

ChannelProgram.create_with_content!(
  {
    channel: netflix,
    time_range: Time.zone.parse('2024-01-01 19:00')..Time.zone.parse('2024-01-01 20:30')
  },
  { original_name: 'Stranger Things Marathon' }
)

Rails.logger.debug do
  "Created #{Channel.count} channels with #{ChannelProgram.count} programs"
end

# Creating Apps
Rails.logger.debug 'Creating apps...'

App.create_with_content!({}, { original_name: 'Netflix Mobile App', year: 2023 })
App.create_with_content!({}, { original_name: 'HBO Max App', year: 2022 })

Rails.logger.debug { "Created #{App.count} apps" }

# Creating Users and their activity
Rails.logger.debug 'Creating users and their activity...'

john = User.create!(name: 'John Doe')
jane = User.create!(name: 'Jane Smith')

# Add some favorites
interstellar_content = Content.find_by(original_name: 'Interstellar')
breaking_bad_content = Content.find_by(original_name: 'Breaking Bad')

john.favorites.create!(content: interstellar_content) if interstellar_content
jane.favorites.create!(content: breaking_bad_content) if breaking_bad_content

# Add watch time
john.most_watched.create!(content: interstellar_content, time_overall: 7200) if interstellar_content
jane.most_watched.create!(content: breaking_bad_content, time_overall: 3600) if breaking_bad_content

Rails.logger.debug do
  "Created #{User.count} users with #{Favorite.count} favorites and #{MostWatched.count} watch records"
end

Rails.logger.debug { "Total content records: #{Content.count}" }
