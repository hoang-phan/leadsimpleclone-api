class CreateLeads < ActiveRecord::Migration[7.1]
  def change
    create_table :leads do |t|
      t.integer :emails_sent
      t.integer :calls_made

      t.timestamps
    end
  end
end
