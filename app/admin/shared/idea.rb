
def idea_list(_idea=nil)
  idea ||= _idea

  column :id

  column(:name) do |idea|
    link_to idea.name, angular_idea_path(idea), target: '_blank'
  end

  column(:user) do |idea|
    link_to idea.user.name, admin_user_path(idea.user.id)
  end

  column(:published) do |idea|
    status_tag((idea.published? ? 'Yes' : 'No'), (idea.published? ? :ok : nil))
  end

  column(:vote_count) do |idea|
    idea.votes.count
  end

  column :created_at
end
