class CreateUserRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_requests do |t|


      t.timestamps
    end
  end
end
