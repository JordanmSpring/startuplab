class UserMailer < ApplicationMailer

  # Sends an invitation to subscribe to alert emails.
  def idea_notification_email(idea)
    @idea    = idea
    @to      = @idea.user.email
    @subject = 'Idea notification'
    mail(to: @to, subject: @subject)
  end

end