class Task < ActiveRecord::Base
  
  belongs_to :project
  
  validates :name, :project_id, presence: true

  def set_priority
    self.priority = Task.where(project_id: self.project_id).count
  end

  def up_prior
    if self.priority != 1
      task = Task.find_by(priority: self.priority - 1)
      task.update(priority: self.priority)
      self.update(priority: self.priority - 1)
    end
  end

  def down_prior
    count = project.tasks.count
    if self.priority != Task.count
      task = Task.find_by(priority: self.priority + 1)
      task.update(priority: self.priority)
      self.update(priority: self.priority + 1)
    end
  end

  def update_priority
    new_priority = 1
    Task.order(:priority).each do |task|
      task.update(priority: new_priority)
      new_priority += 1
    end
  end
end
