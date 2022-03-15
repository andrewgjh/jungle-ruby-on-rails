class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, :uniqueness => {:case_sensitive => false}
  before_save :downcase_fields

  def downcase_fields
     self.email.downcase!
  end
  
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.strip.downcase)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
