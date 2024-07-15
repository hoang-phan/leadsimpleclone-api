class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
