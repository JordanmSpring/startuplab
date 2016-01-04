# Sends notifications on various idea-related activites.
class IdeaNotificationWorker
  include Sidekiq::Worker

  # Notifies the owner of the canvas about comments or likes.
  def perform
    commented_idea_ids = Comment.approved.not_notified.not_recent.group(:idea_id).count.map { |idea_id, _| idea_id }
    voted_idea_ids     = Vote.not_notified.not_recent.group(:voteable_id).count.map { |idea_id, _| idea_id }
    idea_ids           = (commented_idea_ids + voted_idea_ids).uniq

    idea_ids.each do |id|
      idea             = Idea.find_by_id(id)
      next unless idea
      comments_pending = idea.comments_pending_notification
      votes_pending    = idea.votes_pending_notification
      next unless comments_pending.present? || votes_pending.present?

      # Lower-level plans don't allow notifications.
      unless idea.user.can_notify?
        Rails.logger.debug "Notifications disabled for idea #{idea.id} - skipping."
        mark_notified(comments_pending, votes_pending)
        next
      end

      # Send the email now.
      UserMailer.idea_notification_email(idea).deliver_now

      mark_notified(comments_pending, votes_pending)
    end
  end

  private

    def mark_notified(comments, votes)
      # Mark these comments as notified.
      Comment.transaction do
        comments.each do |comment|
          comment.update_attribute(:notified, true)
        end
      end

      # Mark these votes as notified.
      Vote.transaction do
        votes.each do |vote|
          vote.update_attribute(:notified, true)
        end
      end
    end

end