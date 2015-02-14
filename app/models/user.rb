require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  has_many :urls

  validates :username, :presence => true,
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true,
                       :format => { :with => /\w+@\w+\.\w+/ }
  validates :password, :presence => true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by(email: params[:email])
    (user && user.password == params[:password]) ? user : nil
  end

end
