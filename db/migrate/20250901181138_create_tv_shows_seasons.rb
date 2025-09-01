class CreateTvShowsSeasons < ActiveRecord::Migration[7.1]
  def change
    create_table :tv_shows_seasons, id: :bigserial do |t|
      t.bigint :tv_show_id, null: false
      t.integer :number, null: false

      t.timestamps
    end

    add_foreign_key :tv_shows_seasons, :tv_shows, column: :tv_show_id
    add_index :tv_shows_seasons, [:tv_show_id, :number], 
              unique: true, name: 'idx_seasons_show_number'
  end
end
