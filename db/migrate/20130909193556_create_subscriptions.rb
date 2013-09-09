class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :transaction_limit, default: 10

      t.timestamps
    end
  end
end
