class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, :inverse_of => :user

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    url = "https://gravatar.com/avatar/#{gravatar_id}.png"
  end

end
