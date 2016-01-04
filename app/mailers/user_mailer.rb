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

  # Sends an invitation when a paid plan expires.
  def plan_expired_email(user, plan_name, ideas)
    @user      = user
    @plan_name = plan_name
    @ideas     = ideas
    @subject   = I18n.t('user_mailer.plan_expired_email.subject')

    mail(to: user.email, subject: @subject)
  end

end
