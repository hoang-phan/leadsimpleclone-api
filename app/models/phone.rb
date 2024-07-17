class Phone < ApplicationRecord
  belongs_to :contact

  validates :value, presence: true
  validates :value, uniqueness: { scope: :contact_id, case_sensitive: false }
  validates :value, format: { with: /\A\+?[\d ().-]*\z/ }

  enum kind: Contact::CONTACT_ENUMS
end
