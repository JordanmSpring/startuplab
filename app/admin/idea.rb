ActiveAdmin.register Idea do

  actions :all, except: [:create, :new, :update, :edit, :destroy]

  scope :all, default: true
  scope :published
  scope :draft

  filter :id
  filter :name
  filter :user_name, as: :string
  filter :user_email, as: :string
  filter :published
  filter :mvp_stage, as: :select
  filter :channels, as: :select, multiple: true
  filter :crowdfunding_options, as: :select, multiple: true
  filter :created_at
  filter :updated_at
  filter :problems_description, as: :string
  filter :comments_body, as: :string
  filter :company
  filter :mvp_url
  filter :target_customer
  filter :costs
  filter :revenue
  filter :pitch_why
  filter :pitch_how
  filter :timing_why
  filter :timing_description

  index do
    idea_list

    actions defaults: false do |idea|
      link_to 'View', angular_idea_path(idea), target: '_blank'
    end
  end

end
