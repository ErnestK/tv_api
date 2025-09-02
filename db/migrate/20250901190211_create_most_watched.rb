class CreateMostWatched < ActiveRecord::Migration[7.1]
  def change
    create_table :most_watcheds, id: :bigserial do |t|
      t.bigint :user_id, null: false
      t.bigint :channel_program_id, null: false
      t.integer :time_overall, null: false, default: 0

      t.timestamps
    end

    add_foreign_key :most_watcheds, :users
    add_foreign_key :most_watcheds, :channel_programs
    add_index :most_watcheds, [:user_id, :channel_program_id], 
              unique: true, name: 'idx_most_watched_user_channel_program'
    add_index :most_watcheds, [:user_id, :time_overall], 
              name: 'idx_most_watched_time'
  end
end
