class CreateProviderApps < ActiveRecord::Migration[7.1]
  def change
    create_table :provider_apps, id: :bigserial do |t|
      t.timestamp :created_at
    end
  end
end
