class Email < ApplicationRecord
  belongs_to :contact

  validates :value, presence: true
  validates :value, uniqueness: { scope: :contact_id }
  validates :value, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  enum kind: Contact::CONTACT_ENUMS
end
