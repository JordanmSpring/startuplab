class InviteMailer < Devise::Mailer
  helper :paths

  # Used to customize the content of the 'share' email.
  def share_invitation_instructions(record, opts={})
    @token = opts[:token]
    devise_mail(record, :share_invitation_instructions, opts)
  end

end