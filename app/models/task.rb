class Task < ActiveRecord::Base
  belongs_to :project
  validates :title,presence: :true,uniqueness: true
  validates :description,presence: :true
  validates :due_date,presence: :true
end
