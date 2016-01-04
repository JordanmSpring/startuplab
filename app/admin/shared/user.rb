
def social_url(user)
  return '' unless user.provider && user.uid

  url = case user.provider
  when 'facebook'
    "https://www.facebook.com/#{user.uid}"
  when 'twitter'
    "https://twitter.com/intent/user?user_id=#{user.uid}"
  when 'linkedin'
    # I can't figure out how to get a LinkedIn profile URL from the Oauth ID.
    return 'LinkedIn'
  end

  link_to user.provider.humanize, url, target: '_blank'
end

def user_list(_user=nil)
  user ||= _user

  column :id

  column(:name) do |user|
    link_to user.name, admin_user_path(user.id)
  end

  column(:role) do |user|
    status_tag((user.role), (user.role == User::ROLE_ADMIN ? :ok : nil))
  end

  column(:plan) do |user|
    status_tag((user.plan.name), (user.plan.free? ? :nil : :ok))
  end

  column(:email) do |user|
    link_to user.email, admin_user_path(user.id)
  end

  column(:network) do |user|
    social_url(user)
  end

  column(:vote_count) do |user|
    user.votes.count
  end

  column :sign_in_count

  column :created_at
end

def user_table(_user=nil)
  user ||= _user

  row :id
  row :name

  if (user.uid && user.provider)
    row(:network) do
      social_url(user)
    end
  end

  row(:role) do
    status_tag((user.role), (user.role == User::ROLE_ADMIN ? :ok : nil))
  end
  row(:plan) do
    status_tag((user.plan.name), (user.plan.free? ? :nil : :ok))
  end
  row :email
  row :sign_in_count
  row :current_sign_in_ip
  row :last_sign_in_ip
  row :current_sign_in_at
  row :last_sign_in_at
  row :created_at
  row :updated_at
end
