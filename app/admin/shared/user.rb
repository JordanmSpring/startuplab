
def user_list(_user=nil)
  user ||= _user

  column :id

  column(:name) do |user|
    link_to user.name, admin_user_path(user.id)
  end

  column(:role) do |user|
    status_tag((user.role), (user.role == User::ROLE_ADMIN ? :ok : nil))
  end

  column(:email) do |user|
    link_to user.email, admin_user_path(user.id)
  end

  column :created_at
  column :sign_in_count
end

def user_table(_user=nil)
  user ||= _user

  row :id
  row :name
  row(:role) do
    status_tag((user.role), (user.role == User::ROLE_ADMIN ? :ok : nil))
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
