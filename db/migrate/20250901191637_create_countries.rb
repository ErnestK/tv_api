class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries, id: :bigserial do |t|
      t.string :name, limit: 100, null: false
      t.string :code, limit: 5, null: false

      t.timestamp :created_at
    end

    add_index :countries, :name, unique: true
  end
end
