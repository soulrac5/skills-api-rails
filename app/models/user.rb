class User < ApplicationRecord
  acts_as_paranoid
  # mount_uploader :fotolink, PhotoUploader
  mount_base64_uploader :fotolink, PhotoUploader, file_name: -> (u) { 'photo_user' }
	has_secure_password
  #validations
  validates_uniqueness_of :email
  #validates :password, length: {maximum:6}
  #relations
  has_many :skills
  has_many :skills_users
  belongs_to :rol
  belongs_to :city, optional: true
  # callbacks
  before_create :set_is_change_password


  private
  def set_is_change_password
  	self.ischangepassword = 'T'
  end


end
