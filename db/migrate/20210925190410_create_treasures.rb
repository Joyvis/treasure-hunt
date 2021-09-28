class CreateTreasures < ActiveRecord::Migration[6.1]
  def change
    create_table :treasures do |t|
      t.string :longitude, null: false
      t.string :latitude, null: false
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
