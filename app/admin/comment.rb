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
  end

  show do
    attributes_table do
      comment_table
    end
  end

end
