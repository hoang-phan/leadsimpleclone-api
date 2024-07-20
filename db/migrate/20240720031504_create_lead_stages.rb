class CreateLeadStages < ActiveRecord::Migration[7.1]
  def change
    create_table :lead_stages do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :stage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
