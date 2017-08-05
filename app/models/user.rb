class User < ApplicationRecord
  mount_uploader :fotolink, PhotoUploader
	has_secure_password
  #validations
  validates_uniqueness_of :email
  #relations
  has_many :skills
  has_many :skills_users
  belongs_to :rol
  # callbacks
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
