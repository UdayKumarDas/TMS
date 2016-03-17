class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_and_belongs_to_many :projects
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

       validates :name,presence: :true
       validates :dob,presence: :true
       validates :company_name,presence: :true
end
