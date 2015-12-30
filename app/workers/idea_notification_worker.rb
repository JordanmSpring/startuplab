# Sends notifications on various idea-related activites.
class IdeaNotificationWorker
  include Sidekiq::Worker

  # Approves or flags this comment, depending on the result of the Akismet spam check.
  def perform
    idea_ids = Comment.approved.not_notified.not_recent.group(:idea_id).count.map { |idea_id, _| idea_id }

    idea_ids.each do |id|
      idea = Idea.find_by_id(id)
      next unless idea && idea.comments_pending_notification.present?

      # Send the email now.
      UserMailer.idea_notification_email(idea).deliver_now

      # Mark these comments as notified.
      Comment.transaction do
        idea.comments_pending_notification.each do |comment|
          comment.update_attribute(:notified, true)
        end
      end

    end
  end

end