module TasksHelper
  def exceeded_task (task)
    task.deadline < Time.now ? 'exceeded' : task.deadline.strftime("%D")
  end
end
