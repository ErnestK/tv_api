class CreateChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :channels, id: :bigserial do |t|
      t.timestamps
    end
  end
end
