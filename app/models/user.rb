class User < ApplicationRecord
  has_many :leads, dependent: :nullify
  devise :database_authenticatable, :validatable

  def self.create_with_random_password(email)
    password = SecureRandom.uuid
    create(email:, password:, password_confirmation: password)
  end
end
