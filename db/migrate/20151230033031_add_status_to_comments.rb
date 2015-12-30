class AddStatusToComments < ActiveRecord::Migration
  def change
    add_column :comments, :status, :string, null: false, default: Comment::STATUS_PENDING
    # Approve existing comments.
    Comment.update_all(status: Comment::STATUS_APPROVED)
  end
end
