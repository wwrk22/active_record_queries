class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.text :first_name
      t.text :last_name
      t.text :email
      t.integer :visits
      t.integer :orders_count
      t.integer :lock_version

      t.timestamps
    end
  end
end
