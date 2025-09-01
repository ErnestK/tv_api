class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies, id: :bigserial do |t|
      t.integer :year
      t.integer :duration_in_seconds

      t.timestamps
    end
  end
end
