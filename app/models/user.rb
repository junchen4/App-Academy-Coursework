require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader :password
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 1, allow_nil: true}
  #password is not case-sensitive yet

  after_initialize :ensure_session_token


  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email)
    @user = User.find_by(email: email)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token #or use self.class?
    self.save!
    self.session_token #return session token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    #can't just use @password_digest
    self.password_digest = BCrypt::Password.create(password)
    #Password_digest is a string???
  end

  def is_password?(password)
    #Why can't just do password_digest.is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
