class CreateStages < ActiveRecord::Migration[7.1]
  def change
    create_table :stages do |t|
      t.string :name
      t.string :color
      t.integer :kind, default: 0, null: false
      t.integer :order, default: 0, null: false

      t.timestamps
      t.index :order
    end
  end
end
