class Task < ActiveRecord::Base
  
  belongs_to :project
  
  validates :name, :project_id, presence: true
  
  
end
