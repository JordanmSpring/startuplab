
def vote_list(_vote=nil)
  vote ||= _vote

  column :id

  column(:idea) do |vote|
    link_to vote.voteable.name, angular_idea_path(vote.voteable), target: '_blank'
  end

  column(:user) do |vote|
    link_to vote.voter.name, admin_user_path(vote.voter.id)
  end
  column :created_at
end
