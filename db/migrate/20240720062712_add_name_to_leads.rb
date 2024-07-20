class AddNameToLeads < ActiveRecord::Migration[7.1]
  def change
    add_column :leads, :name, :string, null: false
  end
end
