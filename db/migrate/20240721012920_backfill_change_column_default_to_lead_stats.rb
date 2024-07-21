class BackfillChangeColumnDefaultToLeadStats < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    Lead.where(emails_sent: nil).in_batches do |relation|
      relation.update_all emails_sent: 0
      sleep(0.01)
    end

    Lead.where(calls_made: nil).in_batches do |relation|
      relation.update_all calls_made: 0
      sleep(0.01)
    end
  end
end
