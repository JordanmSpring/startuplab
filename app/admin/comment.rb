ActiveAdmin.register Comment, as: 'Idea Comment' do

  actions :all, except: [:create, :new, :update, :edit, :destroy]

  scope :all, default: true
  scope :pending
  scope :approved
  scope :rejected

  filter :id
  filter :body
  filter :user_name, as: :string
  filter :user_email, as: :string
  filter :idea_name, as: :string
  filter :created_at
  filter :updated_at

  index do
    comment_list

    actions defaults: false do |comment|
      result = ''
      unless comment.approved?
        result += ' ' + link_to('Approve', { controller: 'admin/idea_comments', action: :approve, id: comment.id }, { method: :put, data: { confirm: 'Are you sure?' } })
      end
      unless comment.rejected?
        result += ' ' + link_to('Reject',  { controller: 'admin/idea_comments', action: :reject,  id: comment.id }, { method: :put, data: { confirm: 'Are you sure?' } })
      end
      result.html_safe
    end
  end

  show do
    attributes_table do
      comment_table
    end
  end

  action_item :approve, only: [:show] do
    unless resource.approved?
      link_to('Approve', { controller: 'admin/idea_comments', action: :approve, id: resource.id, origin: :show }, { method: :put, data: { confirm: 'Are you sure?' } })
    end
  end

  action_item :reject, only: [:show] do
    unless resource.rejected?
      link_to('Reject', { controller: 'admin/idea_comments', action: :reject, id: resource.id, origin: :show }, { method: :put, data: { confirm: 'Are you sure?' } })
    end
  end

  member_action :approve, method: :put do
    comment = Comment.find(params[:id])
    comment.approve!
    flash[:info] = "Comment ##{params[:id]} has been approved."
    if params[:origin] == 'show'
      redirect_to admin_idea_comment_path(comment)
    else
      redirect_to admin_idea_comments_path
    end
  end

  member_action :reject, method: :put do
    comment = Comment.find(params[:id])
    comment.reject!
    flash[:info] = "Comment ##{params[:id]} has been rejected."
    if params[:origin] == 'show'
      redirect_to admin_idea_comment_path(comment)
    else
      redirect_to admin_idea_comments_path
    end
  end

end
