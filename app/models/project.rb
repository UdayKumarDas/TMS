class Project < ActiveRecord::Base
  has_many :tasks,:dependent=>:destroy
  has_and_belongs_to_many :users
  belongs_to :user, :foreign_key => 'admin_id'
  has_attached_file :picture, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates :name,presence: :true,uniqueness: true
  validates :submission_date,presence: :true
  validates :description,presence: :true
  validates :picture,presence: :true
  validate :validate_date, :on => [:create,:update]

private
	def validate_date
	if self.submission_date.present? && self.submission_date < Date.today
		p errors.add :submission_date, "should not be less than today's Date"
	end
end

end
