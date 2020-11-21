class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.integer :user_id
      t.datetime :departs_at
      t.string :description
      t.boolean :alert_sent, { :default => false }

      t.timestamps
    end
  end
end
