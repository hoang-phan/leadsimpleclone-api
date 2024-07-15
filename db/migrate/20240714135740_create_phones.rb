class CreatePhones < ActiveRecord::Migration[7.1]
  def change
    create_table :phones do |t|
      t.string :value, null: false
      t.enum :kind, enum_type: :contact_kind, default: "personal", null: false
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
