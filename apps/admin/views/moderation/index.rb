module Admin::Views::Moderation
  class Index
    include Admin::View

    def link_to_task(task)
      link_to task.title, routes.task_path(task.id)
    end

    def tasks
      TaskRepository.new.new_tasks
    end

    def approve_task_button(task)
      form_for :task, routes.moderation_path(task.id), { method: :patch } do
        input(type: "hidden", name: "action", value: "approve")
        submit 'Approve', class: 'pure-button pure-button-green'
      end
    end

    def deny_task_button(task)
      form_for :task, routes.moderation_path(task.id), { method: :patch } do
        input(type: "hidden", name: "action", value: "deny")
        submit 'Deny', class: 'pure-button pure-button-danger'
      end
    end

    def params
      {}
    end

    def moderation_active?
      true
    end
  end
end
