class ChangeColumnDefaultToLeadStats < ActiveRecord::Migration[7.1]
  def change
    change_column_default :leads, :emails_sent, from: nil, to: 0
    change_column_default :leads, :calls_made, from: nil, to: 0
  end
end
