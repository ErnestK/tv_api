class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites, id: :bigserial do |t|
      t.bigint :user_id, null: false
      t.bigint :content_id, null: false

      t.timestamp :created_at
    end

    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :contents
    add_index :favorites, [:user_id, :content_id], 
              unique: true, name: 'idx_favorites_user_content'
  end
end
