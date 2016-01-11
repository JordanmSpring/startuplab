ActiveAdmin.register User do

  permit_params :name,
                :role,
                :email,
                :password,
                :password_confirmation,
                :plan_id

  scope :all, default: true
  scope :admins
  scope :users

  filter :id
  filter :name
  filter :email
  filter :role, as: :select, collection: User::ROLES
  filter :current_sign_in_at
  filter :last_sign_in_at
  filter :created_at
  filter :updated_at

  actions :all, except: [:create, :new, :destroy]

  index do
    user_list
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :role, as: :select, collection: User::ROLES, include_blank: false
      f.input :plan_id, as: :select, collection: Plan::PLANS.map(&:id), include_blank: false
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # Don't validate passwords if none have been provided.
  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

  show title: :name do
    panel 'Ideas' do
      paginated_collection(user.ideas.includes(:user).page(params[:ideas_page]).per(10), param_name: :ideas_page) do
        table_for(collection) do
          idea_list(nil)
        end
      end
    end

    panel 'Comments' do
      paginated_collection(user.comments.includes(:user).page(params[:comments_page]).per(10), param_name: :comments_page) do
        table_for(collection) do
          comment_list(nil)
        end
      end
    end

    panel 'Votes' do
      paginated_collection(user.votes.page(params[:votes_page]).per(10), param_name: :votes_page) do
        table_for(collection) do
          vote_list(nil)
        end
      end
    end
  end

  sidebar 'User Details', only: :show do
    attributes_table_for user do
      user_table(user)
    end
  end

end
