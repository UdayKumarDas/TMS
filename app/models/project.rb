class Project < ActiveRecord::Base
  has_many :tasks
  has_and_belongs_to_many :users
  belongs_to :user, :foreign_key => 'admin_id'
  has_attached_file :picture, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
end
