class JsonWebToken
  def self.from_user(user)
    JWT.encode(user.id.to_s, ENV["SECRET_TOKEN"])
  end

  def self.to_user(token)
    return nil if token.blank?

    user_id = JWT.decode(token, ENV["SECRET_TOKEN"])
    User.find_by(id: user_id)
  end
end
