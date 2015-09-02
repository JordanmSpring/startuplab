class AddSocialMediaToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :facebook_url, :string
    add_column :ideas, :twitter_url, :string
    add_column :ideas, :linkedin_url, :string
  end
end
