class ChangeNullableToLeadStats < ActiveRecord::Migration[7.1]
  def change
    change_column_null :leads, :emails_sent, false
    change_column_null :leads, :calls_made, false
  end
end
