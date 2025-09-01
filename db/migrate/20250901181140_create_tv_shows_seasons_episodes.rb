class CreateTvShowsSeasonsEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :tv_shows_seasons_episodes, id: :bigserial do |t|
      t.bigint :tv_shows_season_id, null: false
      t.integer :number, null: false
      t.integer :duration_in_seconds, null: false

      t.timestamps
    end

    add_foreign_key :tv_shows_seasons_episodes, :tv_shows_seasons
    add_index :tv_shows_seasons_episodes, [:tv_shows_season_id, :number], 
              unique: true, name: 'idx_episodes_season_number'
  end
end
