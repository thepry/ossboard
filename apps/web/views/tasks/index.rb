module Web::Views::Tasks
  class Index
    include Web::View

    def title
      'OSSBoard: tasks'
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def link_to_new_task
      link_to 'POST A TASK', routes.new_task_path, class: 'link'
    end

    def status_selected_class(status)
      'pure-menu-selected' if tasks_status == status
    end

    def task_statuses
      {
        'in progress' => 'Open',
        'assigned' => 'Assigned',
        'closed' => 'Closed',
        'done' => 'Finished'
      }
    end

    def tasks_status
      params[:status] || 'in progress'
    end

    def tasks_active?
      true
    end

    def complexity_label(task)
      html.span(class: "level level-#{task.complexity}") { text(task.complexity.upcase) }
    end

    # TODO: Tests
    def author_information(author, task)
      html.div(class: 'task-item__author') do
        text('Posted by')
        a(href: routes.user_path(author.login)) do
          img class: 'task-item__author-avatar', src: author.avatar_url
          text(author.name || author.login)
        end
        text(RelativeTime.in_words(task.created_at))
      end
    end
  end
end
