class Source < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
