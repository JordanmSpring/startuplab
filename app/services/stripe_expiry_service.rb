class StripeExpiryService

  def call(event)
    case event.type
    when 'customer.subscription.deleted'
      downgrade_account(event)
    end
  end

  private

    def downgrade_account(event)
      user = User.find_by(stripe_customer_id: event.data.object.customer)
      return unless user

      User.transaction do
        plan_name = user.plan.name
        ideas     = user.ideas.published
        user.update_attribute(:plan_id, Plan::Free.id)
        ideas.update_all(published: false)

        UserMailer.plan_expired_email(user, plan_name, ideas.to_a).deliver_later if user.email.present?
      end
    end

end
