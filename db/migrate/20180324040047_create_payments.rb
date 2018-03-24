class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :token
      t.float :amount
      t.boolean :failed
      t.integer :user_id

      t.timestamps
    end
  end
end
