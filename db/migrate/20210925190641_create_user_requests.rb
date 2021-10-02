class CreateUserRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_requests do |t|
      t.string :email, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.float :distance, null: false

      t.timestamps
    end
  end
end
