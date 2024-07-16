# frozen_string_literal: true

module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :email, String, null: true
    field :error, String, null: true

    def resolve(email:, password:)
      user = User.find_by(email:)

      if user&.valid_password?(password)
        {
          token: JsonWebToken.from_user(user),
          email: user.email
        }
      else
        { error: "Invalid email or password" }
      end
    end
  end
end
