class Source < ApplicationRecord
  LEAD_SIMPLE_SOURCE = "LeadSimple".freeze

  validates :name, presence: true, uniqueness: true

  def self.lead_simple
    find_or_create_by(name: LEAD_SIMPLE_SOURCE)
  end
end
