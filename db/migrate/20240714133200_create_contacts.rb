class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :source, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company_name

      t.timestamps
    end
  end
end
