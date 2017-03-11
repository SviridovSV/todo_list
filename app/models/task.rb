class Task < ActiveRecord::Base
  
  belongs_to :project
  
  validates :name, :project_id, presence: true

  def set_priority
    self.priority = Task.where(project_id: self.project_id).count
  end

  def up_prior
    next_priority = self.priority - 1
    if self.priority != 1
      task = Task.find_by(priority: next_priority)
      task.update(priority: self.priority)
      self.update(priority: next_priority)
    end
  end
end
