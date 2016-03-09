class User < BaseModel
  include Ohm::Timestamps

  attribute :name

  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Session token
  attribute :token
  index     :token

  # Notification email
  attribute :email
  index     :email

  # Submitted movies
  collection :movies, :Movie
end
