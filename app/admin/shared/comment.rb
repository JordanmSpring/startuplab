
def comment_list(_comment=nil)
  comment ||= _comment

  column :id

  column(:body) do |comment|
    link_to comment.body.truncate(50), admin_idea_comment_path(comment.id)
  end

  column(:user) do |comment|
    link_to comment.user.name, admin_user_path(comment.user.id)
  end

  column(:status) do |comment|
    status = case comment.status
    when Comment::STATUS_PENDING
      nil
    when Comment::STATUS_APPROVED
      :ok
    else
      :error
    end
    status_tag((comment.status), status)
  end

  column :created_at
end

def comment_table(_comment=nil)
  comment ||= _comment

  row :id
  row :user
  row :idea
  row :body
  row :created_at
  row :updated_at
end