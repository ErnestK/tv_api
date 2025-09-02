class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites, id: :bigserial do |t|
      t.bigint :user_id, null: false
      t.bigint :provider_app_id, null: false
      t.integer :order_num, null: false

      t.timestamp :created_at
    end

    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :provider_apps
    add_index :favorites, [:user_id, :provider_app_id], 
              unique: true, name: 'idx_favorites_user_provider_app'
    add_index :favorites, [:user_id, :order_num], 
              unique: true, name: 'idx_favorites_user_order'
  end
end
