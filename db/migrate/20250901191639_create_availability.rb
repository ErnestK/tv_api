class CreateAvailability < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities, id: :bigserial do |t|
      t.bigint :content_id, null: false
      t.bigint :provider_app_id, null: false
      t.bigint :country_id, null: false
      t.jsonb :stream_info, null: true

      t.timestamp :created_at
    end

    add_foreign_key :availabilities, :contents
    add_foreign_key :availabilities, :provider_apps
    add_foreign_key :availabilities, :countries
    add_index :availabilities, [:content_id, :provider_app_id, :country_id], 
              unique: true, name: 'idx_availability_unique'
    add_index :availabilities, :stream_info, using: :gin
  end
end
