class UserMailer < ApplicationMailer
  helper :paths

  # Sends an invitation to subscribe to alert emails.
  def idea_notification_email(idea)
    @idea     = idea
    @comments = idea.comments.approved.not_notified
    @to       = idea.user.email
    @subject  = I18n.t('user_mailer.idea_notification_email.subject', name: idea.name, count: @comments.count)
    mail(to: @to, subject: @subject)
  end

end