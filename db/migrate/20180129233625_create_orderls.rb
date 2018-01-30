class CreateOrderls < ActiveRecord::Migration[5.1]
  def change
    create_table :orderls do |t|
      t.text :order
      t.text :order_id

      t.timestamps
    end
  end
end
