class Phone < ApplicationRecord
  belongs_to :contact

  validates :value, presence: true
  validates :value, uniqueness: { scope: :contact_id, case_sensitive: false }
  validates :value, format: { with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/ }

  enum kind: Contact::CONTACT_ENUMS
end
