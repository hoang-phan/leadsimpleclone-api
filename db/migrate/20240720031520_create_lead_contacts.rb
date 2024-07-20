class CreateLeadContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :lead_contacts do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
