class Contact < ApplicationRecord
  CONTACT_KINDS = %w(personal work spouse partner other).freeze
  CONTACT_ENUMS = CONTACT_KINDS.zip(CONTACT_KINDS).to_h.freeze

  belongs_to :source
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy

  validates :first_name, :last_name, presence: true

  accepts_nested_attributes_for :emails, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
end
