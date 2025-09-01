class Movie < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy

  def self.create_with_content!(movie_attrs, content_attrs)
    transaction do
      movie = create!(movie_attrs)
      movie.create_content!(content_attrs)
      movie
    end
  end
end 