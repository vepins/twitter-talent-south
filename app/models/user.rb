class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :tweets, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader
  
  validates :username, presence: true, uniqueness: true
  
  serialize :following, Array
end
