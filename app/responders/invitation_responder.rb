class InvitationResponder < ActionController::Responder
  def to_json
    if resource.persisted?
      render json: FounderExhibit.new(resource.founders.last), status: 201
    else
      render status: 422, json: {
        errors: resource.errors.full_messages.join(', ')
      }
    end
  end
end
