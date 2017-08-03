class User < ApplicationRecord
	has_secure_password
  has_many :skills
  has_many :skills_users
  belongs_to :rol
  validates_uniqueness_of :email, message: 'email ya existe'
  before_create :set_is_change_password
  before_create :set_first_password

  private
  def set_is_change_password
  	self.ischangepassword = 'T'
  end

  def set_first_password
  	self.password = SecureRandom.hex(10)
  end

end
