# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Rails.logger.debug 'Creating movies with content...'

movies_data = [
  {
    movie: { year: 2014, duration_in_seconds: 10_140 },
    content: { original_name: 'Interstellar' }
  },
  {
    movie: { year: 2010, duration_in_seconds: 8880 },
    content: { original_name: 'Inception' }
  },
  {
    movie: { year: 1994, duration_in_seconds: 8520 },
    content: { original_name: 'The Shawshank Redemption' }
  },
  {
    movie: { year: 2008, duration_in_seconds: 9120 },
    content: { original_name: 'The Dark Knight' }
  }
]

movies_data.each do |data|
  movie = Movie.create_with_content!(data[:movie], data[:content])
  Rails.logger.debug { "✓ Created movie: #{movie.content.original_name} (#{movie.year})" }
end

Rails.logger.debug { "Done! Created #{Movie.count} movies with content." }

# Creating TV Shows
Rails.logger.debug 'Creating TV shows with content...'

# Breaking Bad
breaking_bad = TvShow.create_with_content!(
  { year: 2008 },
  { original_name: 'Breaking Bad' }
)

# Season 1
season1 = TvShowsSeason.create_with_content!(
  { tv_show: breaking_bad, number: 1, year: 2008 },
  { original_name: 'Breaking Bad Season 1' }
)

# Episodes for Season 1
TvShowsSeasonsEpisode.create_with_content!(
  { tv_shows_season: season1, number: 1, year: 2008, duration_in_seconds: 3480 },
  { original_name: 'Pilot' }
)

TvShowsSeasonsEpisode.create_with_content!(
  { tv_shows_season: season1, number: 2, year: 2008, duration_in_seconds: 2880 },
  { original_name: 'Cat\'s in the Bag...' }
)

Rails.logger.debug do
  "Created TV show: #{breaking_bad.content.original_name} " \
    "with #{breaking_bad.tv_shows_seasons.count} seasons"
end
