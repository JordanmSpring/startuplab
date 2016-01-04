# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def idea_notification_email
    UserMailer.idea_notification_email(Idea.first)
  end

  def plan_expired_email
    UserMailer.plan_expired_email(User.first, Plan::Entrepreneur.name, User.first.ideas)
  end

end
