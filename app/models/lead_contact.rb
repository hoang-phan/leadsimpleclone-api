class LeadContact < ApplicationRecord
  belongs_to :lead
  belongs_to :contact
end
