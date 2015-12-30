# Decides whether a comment is spam or not using the Akismet API.
class CommentSpamCheckWorker
  include Sidekiq::Worker

  # Approves or flags this comment, depending on the result of the Akismet spam check.
  def perform(comment_id)
    comment = Comment.find(comment_id)

    if comment.spam?
      Rails.logger.info "Comment ##{comment.id} was REJECTED by Akismet ('#{comment.body}')"
      comment.update_attribute(:status, Comment::STATUS_FLAGGED_BY_AKISMET)
    else
      Rails.logger.info "Comment ##{comment.id} was APPROVED by Akismet ('#{comment.body}')"
      comment.approve!
    end
  end

end