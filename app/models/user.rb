class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true, length: { minimum: 5 }
  before_save :downcase_email
  
  def self.authenticate_with_credentials(email, password)
    if email.nil? || password.nil?
      nil
    else
      @user = User.find_by_email(email.strip.downcase)
      if @user && @user.authenticate(password)
        @user
      else
        nil
      end
    end
  end

  private
  def downcase_email
    self.email.downcase!
  end

end
