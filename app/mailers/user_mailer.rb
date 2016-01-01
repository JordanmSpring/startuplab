class UserMailer < ApplicationMailer
  helper :paths

  # Sends an invitation to subscribe to alert emails.
  def idea_notification_email(idea)
    @idea     = idea
    @comments = idea.comments_pending_notification
    @votes    = idea.votes_pending_notification
    @to       = idea.user.email
    @subject  = if @comments.present?
      I18n.t('user_mailer.idea_notification_email.subject_comments', name: idea.name, count: @comments.count)
    else
      I18n.t('user_mailer.idea_notification_email.subject_votes', name: idea.name, count: @votes.count)
    end
    mail(to: @to, subject: @subject)
  end

end