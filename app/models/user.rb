class User < ActiveRecord::Base

  validates :password, length: {minimum: 6, not_nil: true}
  validates :password_digest, :session_token, presence: true
  validates :user_name, presence: true, uniqueness: true
  attr_reader :password

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(user_name: username)
    return nil if @user.nil?
    #check password
    return nil unless user.is_password?(password)
    user
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
