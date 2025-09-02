class CreateChannelPrograms < ActiveRecord::Migration[7.1]
  def change
    # Enable btree_gist extension for composite GIST indexes
    enable_extension 'btree_gist'
    
    create_table :channel_programs, id: :bigserial do |t|
      t.bigint :channel_id, null: false
      t.tstzrange :schedule, array: true, null: false

      t.timestamps
    end

    add_foreign_key :channel_programs, :channels
    add_index :channel_programs, :channel_id
  end
end
