class Skill < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :skills_users, dependent: :destroy
end
