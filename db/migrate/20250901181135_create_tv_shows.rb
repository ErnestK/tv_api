class CreateTvShows < ActiveRecord::Migration[7.1]
  def change
    create_table :tv_shows, id: :bigserial do |t|
      t.integer :year, null: false

      t.timestamps
    end
  end
end
