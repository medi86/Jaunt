class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,:omniauthable, :omniauth_providers => [:twitter, :google_oauth2]

  has_many :jaunts
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 30 },uniqueness:
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 150 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
