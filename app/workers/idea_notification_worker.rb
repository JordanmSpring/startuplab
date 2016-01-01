# Sends notifications on various idea-related activites.
class IdeaNotificationWorker
  include Sidekiq::Worker

  # Approves or flags this comment, depending on the result of the Akismet spam check.
  def perform
    commented_idea_ids = Comment.approved.not_notified.not_recent.group(:idea_id).count.map { |idea_id, _| idea_id }
    voted_idea_ids     = Vote.not_notified.not_recent.group(:voteable_id).count.map { |idea_id, _| idea_id }
    idea_ids           = (commented_idea_ids + voted_idea_ids).uniq

    idea_ids.each do |id|
      idea             = Idea.find_by_id(id)
      comments_pending = idea.comments_pending_notification
      votes_pending    = idea.votes_pending_notification
      next unless idea && (comments_pending.present? || votes_pending.present?)

      # Send the email now.
      UserMailer.idea_notification_email(idea).deliver_now

      # Mark these comments as notified.
      Comment.transaction do
        comments_pending.each do |comment|
          comment.update_attribute(:notified, true)
        end
      end

      # Mark these votes as notified.
      Vote.transaction do
        votes_pending.each do |vote|
          vote.update_attribute(:notified, true)
        end
      end

    end
  end

end