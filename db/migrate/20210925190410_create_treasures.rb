class CreateTreasures < ActiveRecord::Migration[6.1]
  def change
    create_table :treasures do |t|

      t.timestamps
    end
  end
end
