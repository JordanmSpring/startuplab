ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do

      column do
        panel 'Recent Ideas' do
          ul do
            Idea.recent.limit(10).map do |idea|
              li link_to(idea.name, admin_idea_path(idea))
            end
          end
        end
      end

      column do
        panel 'Recent Users' do
          ul do
            User.recent.limit(10).map do |user|
              li link_to(user.name, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel 'Recent Comments' do
          ul do
            Comment.recent.limit(10).map do |comment|
              li link_to(comment.body.truncate(20), admin_idea_comment_path(comment))
            end
          end
        end
      end
    end
  end

  def authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.is_admin?
  end
end
