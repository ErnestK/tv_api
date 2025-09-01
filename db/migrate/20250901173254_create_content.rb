class CreateContent < ActiveRecord::Migration[7.1]
  def change
    create_table :contents, id: :bigserial do |t|
      t.string :original_name, limit: 255, null: false
      t.string :contentable_type, limit: 50, null: false
      t.bigint :contentable_id, null: false
      t.integer :year, null: true

      t.timestamps
    end

    add_index :contents, [:contentable_type, :contentable_id], 
              unique: true, name: 'idx_content_polymorphic'
  end
end
