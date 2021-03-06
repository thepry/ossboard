class TaskRepository < Hanami::Repository
  def only_approved
    tasks.where(approved: true).order(Sequel.lit('? DESC', :id)).as(Task).to_a
  end

  def not_approved
    tasks.where(approved: false).as(Task).to_a
  end

  def new_tasks
    tasks.where(approved: nil).as(Task).to_a
  end

  def all_from_date(from, status = nil)
    request = tasks.where("created_at > '#{from}'").where("created_at < '#{Time.now}'")
    request = request.where(status: status) if status
    request.as(Task).to_a
  end

  def find_by_status(status)
    if Task::VALID_STATUSES.values.include?(status)
      tasks.where(approved: true, status: status).order(Sequel.lit('? DESC', :id)).as(Task).to_a
    else
      only_approved
    end
  end

  def on_moderation_for_user(id)
    tasks.where(user_id: id, approved: nil).order(Sequel.lit('? DESC', :id)).as(Task).to_a
  end
end
