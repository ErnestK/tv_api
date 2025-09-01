# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating movies with content..."

movies_data = [
  {
    movie: { year: 2014, duration_in_seconds: 10140 },
    content: { original_name: "Interstellar" }
  },
  {
    movie: { year: 2010, duration_in_seconds: 8880 },
    content: { original_name: "Inception" }
  },
  {
    movie: { year: 1994, duration_in_seconds: 8520 },
    content: { original_name: "The Shawshank Redemption" }
  },
  {
    movie: { year: 2008, duration_in_seconds: 9120 },
    content: { original_name: "The Dark Knight" }
  }
]

movies_data.each do |data|
  movie = Movie.create_with_content!(data[:movie], data[:content])
  puts "✓ Created movie: #{movie.content.original_name} (#{movie.year})"
end

puts "Done! Created #{Movie.count} movies with content."
