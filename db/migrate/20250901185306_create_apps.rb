class CreateApps < ActiveRecord::Migration[7.1]
  def change
    create_table :apps, id: :bigserial do |t|
      t.timestamp :created_at
    end
  end
end
